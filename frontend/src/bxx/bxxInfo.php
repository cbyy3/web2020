<?php
    /* 设置响应数据的内容格式，和字符集*/
    header('Content-type:text/html;charset=utf-8');
    
    class Jwt {
    
        //头部
        private static $header=array(
            'alg'=>'HS256', //生成signature的算法
            'typ'=>'JWT'    //类型
        );
    
        //使用HMAC生成信息摘要时所使用的密钥
        private static $key='123456';
    
    
        /**
         * 获取jwt token
         * @param array $payload jwt载荷   格式如下非必须
         * [
         *  'iss'=>'jwt_admin',  //该JWT的签发者
         *  'iat'=>time(),  //签发时间
         *  'exp'=>time()+7200,  //过期时间
         *  'nbf'=>time()+60,  //该时间之前不接收处理该Token
         *  'sub'=>'www.admin.com',  //面向的用户
         *  'jti'=>md5(uniqid('JWT').time())  //该Token唯一标识
         * ]
         * @return bool|string
         */
        public static function getToken($payload)
        {
            if(is_array($payload))
            {
                $base64header=self::base64UrlEncode(json_encode(self::$header,JSON_UNESCAPED_UNICODE));
                $base64payload=self::base64UrlEncode(json_encode($payload,JSON_UNESCAPED_UNICODE));
                $token=$base64header.'.'.$base64payload.'.'.self::signature($base64header.'.'.$base64payload,self::$key,self::$header['alg']);
                return $token;
            }else{
                return false;
            }
        }
    
    
        /**
         * 验证token是否有效,默认验证exp,nbf,iat时间
         * @param string $Token 需要验证的token
         * @return bool|string
         */
        public static function verifyToken($Token)
        {
            $tokens = explode('.', $Token);
            if (count($tokens) != 3)
                return false;
    
            list($base64header, $base64payload, $sign) = $tokens;
    
            //获取jwt算法
            $base64decodeheader = json_decode(self::base64UrlDecode($base64header), JSON_OBJECT_AS_ARRAY);
            if (empty($base64decodeheader['alg']))
                return false;
    
            //签名验证
            if (self::signature($base64header . '.' . $base64payload, self::$key, $base64decodeheader['alg']) !== $sign)
                return false;
    
            $payload = json_decode(self::base64UrlDecode($base64payload), JSON_OBJECT_AS_ARRAY);
    
            //签发时间大于当前服务器时间验证失败
            if (isset($payload['iat']) && $payload['iat'] > time())
                return false;
    
            //过期时间小于当前服务器时间验证失败
            if (isset($payload['exp']) && $payload['exp'] < time())
                return false;
    
            //该nbf时间之前不接收处理该Token
            if (isset($payload['nbf']) && $payload['nbf'] > time())
                return false;
    
            return $payload;
        }
    
    
    
    
        /**
         * base64UrlEncode   https://jwt.io/  中base64UrlEncode编码实现
         * @param string $input 需要编码的字符串
         * @return string
         */
        private static function base64UrlEncode($input)
        {
            return str_replace('=', '', strtr(base64_encode($input), '+/', '-_'));
        }
    
        /**
         * base64UrlEncode  https://jwt.io/  中base64UrlEncode解码实现
         * @param string $input 需要解码的字符串
         * @return bool|string
         */
        private static function base64UrlDecode($input)
        {
            $remainder = strlen($input) % 4;
            if ($remainder) {
                $addlen = 4 - $remainder;
                $input .= str_repeat('=', $addlen);
            }
            return base64_decode(strtr($input, '-_', '+/'));
        }
    
        /**
         * HMACSHA256签名   https://jwt.io/  中HMACSHA256签名实现
         * @param string $input 为base64UrlEncode(header).".".base64UrlEncode(payload)
         * @param string $key
         * @param string $alg   算法方式
         * @return mixed
         */
        private static function signature($input, $key, $alg = 'HS256')
        {
            $alg_config=array(
                'HS256'=>'sha256'
            );
            return self::base64UrlEncode(hash_hmac($alg_config[$alg], $input, $key,true));
        }
    }
    
    $token = $_POST['token'];
    $jwt=new Jwt;
    $payload=$jwt->verifyToken($token);
    $username = $payload['username'];
    //echo $username;
    
    $con=mysqli_connect("localhost","web_xihongshi_w","5zFJnJtmyy");
    if(!$con )
    {
        die('连接失败: ' . mysqli_error($con));   
    }
    mysqli_query($con , "set names utf8");
    mysqli_select_db( $con, "web_xihongshi_w" );
    
    $dbuserid=null;
    $result=mysqli_query( $con, "SELECT * FROM `web2020_user` WHERE username ='$username' AND status ='1';");
    if(!$result )
    {
        die('无法读取数据: ' . mysqli_error($con));
    }
    while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
        $dbuserid=$row["id"]; 
    }
    
    
    $arr=array();
    
    $result=mysqli_query( $con, "SELECT * FROM `web2020_orders` WHERE user_id ='$dbuserid';");
    if(!$result )
    {
        die('无法读取数据: ' . mysqli_error($con));
    }
    $i=0;
    while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
    {
        $bdstatus=$row["status"]; 
        $rstatus=null;
        if($bdstatus=="waiting"){
            $rstatus="购买申请正在排队中，请稍后查询结果。";
        }else if($bdstatus=="accept"){
            $rstatus="购买申请已经提交成功，请在规定时间内付款。";
        }else if($bdstatus=="payment"){
            $rstatus="商品已付款成功，将于七日内发货。";
        }else if($bdstatus=="delivery"){
            $rstatus="商品已发货，请随时关注物流信息。";
        }else if($bdstatus=="success"){
            $rstatus="商品已签收成功！";
        }else if($bdstatus=="failure"){
            $rstatus="购买失败！";
        }
        
        $good=array();
        $good[0]=$row["good_id"]; 
        $good[1]=$rstatus;
        $good[2]=date("Y-m-d H:i:s",$row["createtime"]); 
        
        $arr[$i+1]=$good;
        $i++;
    }
    $arr[0]=$i;
    for($j=1;$j<=$i;$j++){
        $goodid=$arr[$j][0];
        $result=mysqli_query( $con, "SELECT * FROM `web2020_goods` WHERE id ='$goodid' AND status ='1';");
        if(!$result )
        {
            die('无法读取数据: ' . mysqli_error($con));
        }
        while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $arr[$j][0]=$row["name"]; 
        }
    }
    $str=json_encode($arr);
    echo $str;
?>
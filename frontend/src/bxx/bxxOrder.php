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
    $arr=array();
    $arr['status']="200";
    $timekey = "2021-01-22 00:00:00"; //秒杀时间
    if(time()<strtotime($timekey)){
        //秒杀未开始
        $arr['status']="208";
    }else if(isset($_POST['token'])&&isset($_POST['name'])){
        $token = $_POST['token'];
        $jwt=new Jwt;
        $payload=$jwt->verifyToken($token);
        if($payload==false){
            //超时或token不存在等情况
            $arr['status']="201";
        }else{
            $username = $payload['username'];
            $password = $payload['password'];//等等加密加盐
            $con=mysqli_connect("localhost","web_xihongshi_w","5zFJnJtmyy");
            if(!$con )
            {
                die('连接失败: ' . mysqli_error($con));   
            }
            mysqli_query($con , "set names utf8");
            mysqli_select_db( $con, "web_xihongshi_w" );
            $dbusername=null;
            $dbpassword=null; 
            $userid=null; 
            $result=mysqli_query( $con, "SELECT * FROM `web2020_user` WHERE username ='$username';");
            if(!$result )
            {
                die('无法读取数据: ' . mysqli_error($con));
            }
            while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
                $dbusername=$row["username"]; 
                $dbpassword=$row["password"]; 
                $userid=$row["id"]; 
            }
            if (is_null($dbusername)||$dbpassword!=$password) {
                //恶意入侵，token存在，但用户名密码对不上
                $arr['status']="202";
            }else{
                //验证成功
                //检测是否可以提交订单
                $goodname = $_POST['name'];
                $goodid=null; 
                $result=mysqli_query( $con, "SELECT * FROM `web2020_goods` WHERE name ='$goodname';");
                if(!$result )
                {
                    die('无法读取数据: ' . mysqli_error($con));
                }
                while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
                    $goodid=$row["id"]; 
                }
                
                $dbordrstatus=null; 
                $result=mysqli_query( $con, "SELECT * FROM `web2020_orders` WHERE user_id ='$userid' AND good_id ='$goodid';");
                if(!$result )
                {
                    die('无法读取数据: ' . mysqli_error($con));
                }
                while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
                    $dbordrstatus=$row["status"]; 
                }
                
                $redis = new \Redis();
                $redis->connect('127.0.0.1', 6379);
                $redis->auth('web2020');
                
                if($goodid==null){
                    $arr['status']="203";
                }else if($redis->get($goodname)<=0){
                    $arr['status']="204";
                //}else if($dbordrstatus!=null&&$dbordrstatus!="failure"){
                    //$arr['status']="206";
                }else{
                    $redis->decr($goodname);
                    $time=time();
                    mysqli_query( $con, "INSERT INTO `web2020_orders` (user_id, good_id, status, createtime) VALUES ('$userid','$goodid','waiting','$time');");
                    $host = '127.0.0.1';
                    $port = '5050';
                    $conn = fsockopen($host, $port, $errno, $errstr, 3);
                    if (!$conn) {
                        var_dump('链接失败');
                        exit;
                    }
                    $method = 'RpcService.Order';
                    $params = ['dtype'=>4,'userid'=>intval($userid),'goodid'=>intval($goodid)];
                    $err = fwrite($conn, json_encode(array(
                            'method' => $method,
                            'params' => [$params],
                            'id'     => 0,
                        ))."\n");
                    if ($err === false){
                        var_dump('写入数据失败');
                        var_dump(http_response_code(205));
                        exit;
                    }
                    stream_set_timeout($conn, 0, 30000);
                    $line = fgets($conn);
                    if ($line === false) {
                        var_dump('获取响应数据失败');
                        var_dump(http_response_code(205));
                        exit;
                    }
                    var_dump(json_decode($line,true));
                    exit;
                }
                
            }
        }
    }else{
        //未知错误
        $arr['status']="203";
    }
    $str=json_encode($arr);
    echo $str;
?>
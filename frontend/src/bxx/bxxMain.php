<?php
    /* 设置响应数据的内容格式，和字符集*/
    header('Content-type:text/html;charset=utf-8');
    $con=mysqli_connect("localhost","web_xihongshi_w","5zFJnJtmyy");
    if(!$con )
    {
        die('连接失败: ' . mysqli_error($con));   
    }
    mysqli_query($con , "set names utf8");
    mysqli_select_db( $con, "web_xihongshi_w" );
    $arr=array();
    
    $result=mysqli_query( $con, "SELECT * FROM `web2020_goods` WHERE status ='1';");
    if(!$result )
    {
        die('无法读取数据: ' . mysqli_error($con));
    }
    $i=0;
    while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
    {
        $good=array();
        $good[0]=$row["name"]; 
        $good[1]=$row["des"]; 
        $good[2]=$row["num"]; 
        $good[3]=$row["price"]; 
        $arr[$i+1]=$good;
        $i++;
    }
    $arr[0]=$i;
    $str=json_encode($arr);
    echo $str;
?>
<?php
    header('Content-type:text/html;charset=utf-8');
    
    
    $redis = new \Redis();
    $redis->connect('127.0.0.1', 6379);
    $redis->auth('web2020'); # 如果没有密码则不需要这行
 
    //把 'test'字符串存入 redis
    //$redis->set('username', 0);
    $redis->set('iPhone', 500);
    $redis->set('Huawei', 1000);
    $redis->set('Xiaomi', 800);
    $redis->set('OPPO', 5000);
    $redis->set('Vivo', 4000);
    $redis->set('Samsung', 1000);
    $redis->set('DOOV', 4500);
    // 把 'test_name' 的 值从 redis 读取出来 
    //echo $redis->get('username');
    //echo $redis->get('iPhone');
    //echo $redis->get('Samsung');
       
?>
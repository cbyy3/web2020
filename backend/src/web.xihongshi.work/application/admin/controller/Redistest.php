<?php
namespace app\admin\controller;

use think\Controller;

class Redistest extends Controller
{

    public function index()
    {
        echo "redis_test";
    }
    public function cby0()
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('web2020'); # 如果没有密码则不需要这行
     
        //把 'test'字符串存入 redis
        $redis->set('cby0',122);
        $redis->expire('cby0',20);
        // 把 'test_name' 的 值从 redis 读取出来 
        $cby=$redis->get('cby0');
        if($cby>1) echo("大于一");
        else echo("mudamuda");
        
    }
    public function cby1()
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('web2020'); # 如果没有密码则不需要这行
     
        // 把 'test_name' 的 值从 redis 读取出来 
        $cby=$redis->get('cby0');
        echo($cby);
        if($cby>1) echo("大于一");
        else echo("mudamuda");
        
    }
    public function cby2()
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('web2020'); # 如果没有密码则不需要这行
     
        // 把 'test_name' 的 值从 redis 读取出来 
        $redis->incr("cby1");
        $redis->expire('cby1',20);
        $cby=$redis->get('cby1');
        echo($cby);
        if($cby>1) echo("大于一");
        else echo("mudamuda");
        
    }
    public function test1()
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('web2020'); # 如果没有密码则不需要这行
     
        //把 'test'字符串存入 redis
        $redis->set('username', 0);
        $redis->set('iPhone', 500);
        $redis->set('Huawei', 1000);
        $redis->set('Xiaomi', 800);
        $redis->set('OPPO', 5000);
        $redis->set('Vivo', 4000);
        $redis->set('Samsung', 1000);
        $redis->set('DOOV', 4500);
        // 把 'test_name' 的 值从 redis 读取出来 
        echo $redis->get('username');
        echo $redis->get('iPhone');
        echo $redis->get('Samsung');
    }
    public function test_inc()
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('web2020');
        $redis->incr("username");
        echo $redis->get("username");
    }
    public function test_dec()
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('web2020');
        $redis->decr("username");
        echo $redis->get("username");
    }
    public function test_settimeout()
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('web2020');
        $redis->incr("username2");
        $redis->expire("username2",20);  //设置过期时间，单位秒
        echo $redis->get("username2");
    }
    public function test_login()
    {
        //此处如何实现连续尝试三次出现验证码？
        return $this->fetch();
    }
    public function dologin()
    {
        //获取用户提交的用户名和密码
        $username = input('username');
        $password = input('password');
        //用户存在数据库的密码
        $pwd = '123456';
 
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('web2020');
        $num = $redis->get($username);
        if($num > 5){
            echo '登录次数超过5次,请5分钟后再尝试';
            exit();
        }
 
        if($password != $pwd){
            //登录失败进行计数操作，key为用户名这里认为是唯一值，value就是错误次数
            $redis->incr($username);
            $redis->expire($username,20);  //设置过期时间，单位秒
            echo '登录失败';
        }else{
            echo '登录成功';
        }
    }
}
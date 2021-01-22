<?php
namespace app\admin\controller;

use think\Controller;

class Login extends Controller
{
    //登入
    public function index()
    {
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    //处理登录请求
    public function dologin()
    {
        $username = input('post.username');
        $password = input('post.password');
        $yzmcode = input('post.code');
        //验证验证码是否输入正确
        $captcha = new \think\captcha\Captcha();
        $result=$captcha->check($yzmcode);
        if($result===false){
            $this->error('验证码不正确');
        }
        //后端再次判断用户名密码是否为空
        if (!$username) {
            $this->error('用户名不能为空');
        }
        if (!$password) {
            $this->error('密码不能为空');
        }
        //模块获取对应的管理员表信息
        $admin = model('Admin');
        $info = $admin->getInfoByUsername($username);
        //如果输入用户名不存在
        if (!$info) {
            $this->error('用户名或密码错误');
        }
        //如果账号被锁住（失败五次以上就会被锁住,五分钟后解锁）
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('web2020');
        $num = $redis->get($username);
        if($num > 5){
            $this->error('登录次数超过5次,请5分钟后再尝试');
            
        }
        //如果输入密码错误
        $md5_salt = config('md5_salt');
        if (md5(md5($password).$md5_salt) != $info['password']) {
            $redis->incr($username);
            $redis->expire($username,300);
            $this->error('用户名或密码错误');
        //如果输入用户名密码正确    
        } else {
            $redis->set($username,0);
            $redis->expire($username,300);
            //设置session
            session('user_name', $info['username']);
            session('user_id', $info['id']);
            session('group_id', $admin->getUserGroups($info['id']));
            //记录登录信息，登陆时间和ip
            $admin->editInfo($info['id']);
            $this->success('登入成功', 'index/index');
        }
    }
    //登出
    public function logout()
    {
        session('user_name', null);
        session('user_id', null);
        $this->success('退出成功', 'login/index');
    }
}
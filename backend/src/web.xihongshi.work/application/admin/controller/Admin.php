<?php
namespace app\admin\controller;

use think\Controller;

class Admin extends Common
{
    /**
     * 登入
     */
    public function index()
    {
        if(input('?param.findbyname')&&input('param.findbyname')!="")
        {
            $user_dee = db('admin')->where('username',input('param.findbyname'))->where('id','<>',1)->select();
        }
        else
        {
            $user_dee = db('admin')->where('id','<>',1)->select();
        }    
        $this->assign("namelast", input('param.findbyname'));
        $this->assign("numlist", count($user_dee));
        $this->assign("maglist", $user_dee);
        return $this->fetch('index');
    }
    /**
     * dee用户_添加
     */
    public function dee_add() {
        echo("dee用户_添加");
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_dee_add() {
        echo("执行_dee用户_添加");
        $username = input('post.username');
        $password = input('post.password');
        $group_id = input('post.group');
        $code = input('post.code');
        $md5_salt = config('md5_salt');
        $passwordmd5 = md5(md5($password).$md5_salt);
        //向admin表添加数据
        $data = ['username' => $username, 'password' => $passwordmd5, 'lastloginip' => ip2long(request()->ip()), 'lastlogintime' => time(), 'code' => $code];
        db('admin')->insert($data);
        //向admin_group_access表添加数据
        $uid = db('admin')->where('username',$username)->value('id');
        $data2 = ['uid' => $uid, 'group_id' => $group_id];
        db('admin_group_access')->insert($data2);
        ?>
        <script>
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
        </script>
        <?php
    }
    /**
     * dee用户_编辑
     */
    public function dee_edit() {
        echo("dee用户_编辑");
        $adee = db('admin')->where('id',input('param.void'))->find();
        $agroupid = db('admin_group_access')->where('uid',$adee['id'])->value('group_id');
        $agroup = db('admin_group')->where('id',$agroupid)->value('name');
        if($adee['code']==1){
            $this->assign("code", "正常");
        }else{
            $this->assign("code", "锁定");
        }
        $this->assign("adee", $adee);
        $this->assign("agroup", $agroup);
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_dee_edit() {
        echo("执行_dee用户_编辑");
        $username = input('post.username');
        $group_id = input('post.group');
        $code = input('post.code');
        $dee_id = db('admin')->where('username',$username)->value('id');
        if($code!="0"){
            db('admin')->where('username',$username)->update(['code' => $code]);
        }
        if($group_id!="0"){
            db('admin_group_access')->where('uid',$dee_id)->update(['group_id' => $group_id]);
        }
        ?>
        <script>
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
        </script>
        <?php
    }
    /**
     * dee用户_删除
     */
    public function dee_del() {
        echo("dee用户_删除");
        $void = input('param.void');
        db('admin')->where('id',$void)->delete();
        db('admin_group_access')->where('uid',$void)->delete();
        $this->success('删除成功', 'admin/index');
    }
    /**
     * dee用户_批量删除
     */
    public function dee_delall() {
        echo("dee用户_批量删除");
        $tag = input('param.tag');
        $strs = explode(",",$tag);
		for ($i = 0; $i < count($strs); $i++) {
			db('admin')->where('id',$strs[$i])->delete();
            db('admin_group_access')->where('uid',$strs[$i])->delete();
		}
        $this->success('批量删除成功', 'admin/index');
    }

    public function public_edit_info()
    {
        $username=session('user_name');
        $adee = db('admin')->where('username',$username)->find();
        $this->assign("adee", $adee);
        return $this->fetch('public_edit_info');
    }
    public function do_change() {
        echo("执行_编辑基本信息");
        $reusername = input('post.reusername');
        $username = input('post.username');
        $email = input('post.email');
        $mobile = input('post.mobile');
        $realname = input('post.realname');
        db('admin')->where('username',$reusername)->update(['username' => $username,'email' => $email,'mobile' => $mobile,'realname' => $realname]);
        $this->success('更改成功', 'admin/public_edit_info');
    }
    public function do_changepsd() {
        echo("执行_编辑密码");
        $reusername = input('post.reusername');
        $md5_salt = config('md5_salt');
        $oldpsd = md5(md5(input('post.oldpsd')).$md5_salt);
        $newpsd = input('post.newpsd');
        $renewpsd = input('post.renewpsd');
        $passworddb = db('admin')->where('username',$reusername)->value('password');
        if($passworddb!=$oldpsd){
            $this->error('原密码错误，更改失败！');
        }else if($newpsd!=$renewpsd){
            $this->error('新密码不一致，更改失败！');
        }else{
            db('admin')->where('username',$reusername)->update(['password' => md5(md5($newpsd).$md5_salt)]);
            $this->success('更改成功', 'admin/public_edit_info');
        }
    }
    
}
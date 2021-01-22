<?php
namespace app\admin\controller;

use think\Controller;

class Orders extends Common
{
    /**
     * 登入
     */
    public function index()
    {
        return $this->fetch('index');
    }
    /**
     * 发货
     */
    public function sendgoods()
    {
        if(input('?param.findbyname')&&input('param.findbyname')!="")
        {
            $user_dee = db('orders')->where('id',input('param.findbyname'))->where('status','payment')->select();
        }
        else
        {
            $user_dee = db('orders')->where('status','payment')->select();
        }
        $this->assign("namelast", input('param.findbyname'));
        $this->assign("numlist", count($user_dee));
        $this->assign("maglist", $user_dee);
        return $this->fetch();
    }
    /**
     * dee用户_编辑
     */
    public function sendedit() {
        echo("订单_发货");
        $adee = db('orders')->where('id',input('param.void'))->find();
        $auser = db('user')->where('id',$adee['user_id'])->value('username');
        $agood = db('goods')->where('id',$adee['good_id'])->value('name');
        $this->assign("adee", $adee);
        $this->assign("auser", $auser);
        $this->assign("agood", $agood);
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_sendedit() {
        echo("执行_订单_发货");
        $id = input('post.id');
        db('orders')->where('id',$id)->update(['status' => 'delivery']);
        ?>
        <script>
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
        </script>
        <?php
    }
    /**
     * 退货
     */
    public function backgoods()
    {
        if(input('?param.findbyname')&&input('param.findbyname')!="")
        {
            $user_dee = db('orders')->where('id',input('param.findbyname'))->where('status','payment')->whereOr('status','delivery')->whereOr('status','success')->select();
        }
        else
        {
            $user_dee = db('orders')->where('status','payment')->whereOr('status','delivery')->whereOr('status','success')->select();
        }
        $this->assign("namelast", input('param.findbyname'));
        $this->assign("numlist", count($user_dee));
        $this->assign("maglist", $user_dee);
        return $this->fetch();
    }
    /**
     * dee用户_编辑
     */
    public function backedit() {
        echo("订单_发货");
        $adee = db('orders')->where('id',input('param.void'))->find();
        $auser = db('user')->where('id',$adee['user_id'])->value('username');
        $agood = db('goods')->where('id',$adee['good_id'])->value('name');
        $this->assign("adee", $adee);
        $this->assign("auser", $auser);
        $this->assign("agood", $agood);
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_backedit() {
        echo("执行_订单_发货");
        $id = input('post.id');
        db('orders')->where('id',$id)->update(['status' => 'failure']);
        ?>
        <script>
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
        </script>
        <?php
    }
}
<?php
namespace app\admin\controller;

use think\Controller;

class Menu extends Common
{
    /**
     * 登入
     */
    public function index()
    {
        if(input('?param.findbyname')&&input('param.findbyname')!="")
        {
            $user_dee = db('menu')->where('name',input('param.findbyname'))->where('display',1)->select();
        }
        else
        {
            $user_dee = db('menu')->where('display',1)->select();
        }    
        $this->assign("namelast", input('param.findbyname'));
        $this->assign("numlist", count($user_dee));
        $this->assign("maglist", $user_dee);
        return $this->fetch('index');
    }
    /**
     * dee用户_添加
     */
    public function add() {
        echo("菜单_添加");
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_add() {
        echo("执行_菜单_添加");
        $name = input('post.name');
        $c = input('post.c');
        $a = input('post.a');
        $parentid = input('post.parentid');
        
        //向admin_group表添加数据
        $data = ['name' => $name, 'c' => $c, 'a' => $a, 'parentid' => $parentid, 'display' => "1", 'updatetime' => time()];
        db('menu')->insert($data);
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
    public function edit() {
        echo("菜单_编辑");
        $adee = db('menu')->where('id',input('param.void'))->find();
        if($adee['parentid']=="0"){
            $this->assign("agroup", "根节点");
        
        }else{
            $agroup = db('menu')->where('id',$adee['parentid'])->value('name');
            $this->assign("agroup", $agroup);
        }
        $this->assign("adee", $adee);
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_edit() {
        echo("执行_菜单_编辑");
        $rename = input('post.rename');
        $name = input('post.name');
        $c = input('post.c');
        $a = input('post.a');
        $parentid = input('post.parentid');
        if($parentid!="m"){
            db('menu')->where('name',$rename)->update(['name' => $name,'c' => $c,'a' => $a,'parentid' => $parentid,'updatetime' => time()]);
        }else{
            db('menu')->where('name',$rename)->update(['name' => $name,'c' => $c,'a' => $a,'updatetime' => time()]);
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
    public function del() {
        echo("菜单_删除");
        $void = input('param.void');
        db('menu')->where('id',$void)->delete();
        $this->success('删除成功', 'menu/index');
    }
    /**
     * dee用户_批量删除
     */
    public function delall() {
        echo("菜单_批量删除");
        $tag = input('param.tag');
        $strs = explode(",",$tag);
		for ($i = 0; $i < count($strs); $i++) {
			db('menu')->where('id',$strs[$i])->delete();
		}
        $this->success('批量删除成功', 'menu/index');
    }
}
<?php
namespace app\admin\controller;

use think\Controller;

class Group extends Common
{
    /**
     * 登入
     */
    public function index()
    {
        if(input('?param.findbyname')&&input('param.findbyname')!="")
        {
            $user_dee = db('admin_group')->where('name',input('param.findbyname'))->select();
        }
        else
        {
            $user_dee = db('admin_group')->select();
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
        echo("组_添加");
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_add() {
        echo("执行_组_添加");
        $name = input('post.name');
        $des = input('post.des');
        
        //向admin_group表添加数据
        $data = ['name' => $name, 'description' => $des, 'updatetime' => time()];
        db('admin_group')->insert($data);
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
        echo("组_编辑");
        $adee = db('admin_group')->where('id',input('param.void'))->find();
        $this->assign("adee", $adee);
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_edit() {
        echo("执行_组_编辑");
        $rename = input('post.rename');
        $name = input('post.name');
        $des = input('post.des');
        db('admin_group')->where('name',$rename)->update(['name' => $name,'description' => $des,'updatetime' => time()]);
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
        echo("组_删除");
        $void = input('param.void');
        db('admin_group')->where('id',$void)->delete();
        $this->success('删除成功', 'group/index');
    }
    /**
     * dee用户_批量删除
     */
    public function delall() {
        echo("组_批量删除");
        $tag = input('param.tag');
        $strs = explode(",",$tag);
		for ($i = 0; $i < count($strs); $i++) {
			db('admin_group')->where('id',$strs[$i])->delete();
		}
        $this->success('批量删除成功', 'group/index');
    }
}
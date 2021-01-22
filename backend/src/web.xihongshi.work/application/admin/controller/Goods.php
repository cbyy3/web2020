<?php
namespace app\admin\controller;

use think\Controller;

class Goods extends Common
{
    /**
     * 默认
     */
    public function index()
    {
        if(input('?param.findbyname')&&input('param.findbyname')!="")
        {
            $user_dee = db('goods')->where('name',input('param.findbyname'))->select();
        }
        else
        {
            $user_dee = db('goods')->select();
        }    
        $this->assign("namelast", input('param.findbyname'));
        $this->assign("numlist", count($user_dee));
        $this->assign("maglist", $user_dee);
        return $this->fetch('index');
    }
    /**
     * 添加
     */
    public function add() {
        echo("商品_添加");
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_add() {
        echo("执行_商品_添加");
        $name = input('post.name');
        $des = input('post.des');
        $num = input('post.num');
        $price = input('post.price');
        $status = input('post.status');
        
        //向admin_group表添加数据
        $data = ['name' => $name, 'des' => $des, 'num' => $num, 'price' => $price, 'status' => $status];
        db('goods')->insert($data);
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
        echo("商品_编辑");
        $adee = db('goods')->where('id',input('param.void'))->find();
        $this->assign("adee", $adee);
        $this->view->engine->layout(false);
        return $this->fetch();
    }
    public function do_edit() {
        echo("执行_商品_编辑");
        $rename = input('post.rename');
        $name = input('post.name');
        $des = input('post.des');
        $num = input('post.num');
        $price = input('post.price');
        $status = input('post.status');
        db('goods')->where('name',$rename)->update(['name' => $name,'des' => $des,'num' => $num,'price' => $price,'status' => $status]);
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
        echo("商品_删除");
        $void = input('param.void');
        db('goods')->where('id',$void)->delete();
        $this->success('删除成功', 'goods/index');
    }
    /**
     * dee用户_批量删除
     */
    public function delall() {
        echo("商品_批量删除");
        $tag = input('param.tag');
        $strs = explode(",",$tag);
		for ($i = 0; $i < count($strs); $i++) {
			db('goods')->where('id',$strs[$i])->delete();
		}
        $this->success('批量删除成功', 'goods/index');
    }
}
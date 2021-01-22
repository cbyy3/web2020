<?php
namespace app\admin\controller;

use think\Controller;

class Log extends Common
{
    /**
     * 登入
     */
    public function index()
    {
        //echo(time());
        if(input('?param.findbyname')&&input('param.findbyname')!="")
        {
            $data = db('admin_log')->where('username',input('param.findbyname'))->select();
        }
        else
        {
            $data = db('admin_log')->select();
        }    
        $this->assign("namelast", input('param.findbyname'));
        $this->assign("numlist", count($data));
        $this->assign("maglist", $data);
        return $this->fetch('index');
    }
    
    
    
    /**
     * dee用户_批量删除
     */
    public function delall() {
        echo("dee用户_批量删除");
        $dtime=strtotime(date("Y-m-d H:i:s",strtotime("-7 day")));
        db('admin_log')->where('time','<',$dtime)->delete();
        $this->success('批量删除成功，仅剩七天的日志', 'Log/index');
    }

}
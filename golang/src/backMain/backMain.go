package main

import (
	"encoding/json"
	"fmt"
	"net/rpc"
	"net/rpc/jsonrpc"
	"os"
	"github.com/streadway/amqp"
	"log"
	"net"
)

type Datas struct {
	Userid   int     `json:"userid"`
	Goodid   int     `json:"goodid"`
}

func failOnError(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
	}
}
type RpcService struct {
}

//请求数据结构体
type RequestData struct {
	dtype int
	userid int
	goodid int
}

// 响应数据结构体
type ResponseData struct {
	Status int // 状态
	Data interface{} //数据
	Msg string //说明
}

var userid int
var goodid int
// 方法（必须是公有方法，且必须是两个参数）
func (this *RpcService  ) Order(request map[string]int  , response *ResponseData ) error {
	m := map[string]string{"type":"10","msg":"hello."}
	//mjson,_ :=json.Marshal(m)
	//mString :=string(mjson)

	//res.Status = request.dtype
	userid=request["userid"]
	goodid=request["goodid"]
	response.Data = m
	response.Msg = "success"
	return nil
}


func main() {
	_ = rpc.Register(new(RpcService )) // 注册rpc服务
	lis, err := net.Listen("tcp", "127.0.0.1:5050") //监听端口，如果监听所有客户端则去掉ip
	if err != nil {
		log.Fatalln("fatal error: ", err)
	}

	_, _ = fmt.Fprintf(os.Stdout, "%s", "jsonrpc is started\n")

	for {
		conn, err := lis.Accept() // 接收客户端连接请求
		if err != nil {
			continue
		}
		go func(conn net.Conn) { // 并发处理客户端请求
			_, _ = fmt.Fprintf(os.Stdout, "%s", "new client connect\n")
			jsonrpc.ServeConn(conn)

			con, err := amqp.Dial("amqp://admin:admin@localhost:5672")
			failOnError(err, "Failed to connect to RabbitMQ")
			defer con.Close()

			ch, err := con.Channel()
			failOnError(err, "Failed to open a channel")
			defer ch.Close()

			q, err := ch.QueueDeclare(
				"orderqueue", // name
				false,   // durable
				false,   // delete when unused
				false,   // exclusive
				false,   // no-wait
				nil,     // arguments
			)
			failOnError(err, "Failed to declare a queue")
			datas:=Datas{}
			datas.Userid=userid
			datas.Goodid=goodid
			bchars, err := json.Marshal(datas)
			body := bchars
			err = ch.Publish(
				"",     // exchange
				q.Name, // routing key
				false,  // mandatory
				false,  // immediate
				amqp.Publishing{
					ContentType: "text/plain",
					Body:        []byte(body),
				})
			log.Printf(" [x] Sent %s", body)
			failOnError(err, "Failed to publish a message")
		}(conn)
	}
}
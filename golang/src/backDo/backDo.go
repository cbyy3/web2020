package main

import (
	"encoding/binary"
	"encoding/json"
	"log"
	"errors"
	"fmt"
	"time"

  _ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
  _ "github.com/jinzhu/gorm/dialects/mysql"

	"github.com/streadway/amqp"
)

//Good ...
type Good struct {
	ID     int    `gorm:"primaryKey"`
	Name   string    `gorm:"column:name"`
	Des   string    `gorm:"column:des"`
	Num int `gorm:"column:num"`
	Price int `gorm:"column:price"`
	Status int `gorm:"column:status"`
}
//User ...
type User struct {
	ID     int    `gorm:"primaryKey"`
	Username   string    `gorm:"column:username"`
	Status       int    `gorm:"column:status"`
}
//Order ...
type Order struct {
	ID     int    `gorm:"primaryKey"`
	Userid int `gorm:"column:user_id"`
	Goodid int `gorm:"column:good_id"`
	Status       string    `gorm:"column:status"`
	Createtime int `gorm:"column:createtime"`
	
}
type Datas struct {
	Userid   int     `json:"userid"`
	Goodid   int     `json:"goodid"`
}

func failOnError(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
	}
}

func BytesToInt(buf []byte) int {
	return int(binary.BigEndian.Uint64(buf))
}

func main() {
	conn, err := amqp.Dial("amqp://admin:admin@120.53.124.191:5672/")
	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	ch, err := conn.Channel()
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

	msgs, err := ch.Consume(
		q.Name, // queue
		"",     // consumer
		true,   // auto-ack
		false,  // exclusive
		false,  // no-local
		false,  // no-wait
		nil,    // args
	)
	failOnError(err, "Failed to register a consumer")
	forever := make(chan bool)
	go func() {
		for d := range msgs{
			log.Printf("Received a message: %s",d.Body)

			var datas Datas
			err := json.Unmarshal([]byte(d.Body), &datas)
			if err != nil {
				fmt.Println(err)
			}
			
			userid := datas.Userid
			goodid := datas.Goodid

			//连接数据库
			db, err := gorm.Open("mysql", "web_xihongshi_w:5zFJnJtmyy@tcp(127.0.0.1:3306)/web_xihongshi_w?charset=utf8mb4&parseTime=True")
			if err != nil {
				fmt.Println(err)
			}
			fmt.Println("------------连接数据库成功-----------")
			isok := 1
	
			//检查用户是否满足条件
			user := User{}
			errUser := db.Table("web2020_user").Where(" status = 1").Where(" id = ?", userid).First(&user).Error
			if errors.Is(errUser, gorm.ErrRecordNotFound) {
				fmt.Println("该用户已被锁定，无法下单")
				isok = 0
			} else {
				fmt.Println("找到用户：",user.Username)
			}
			//查找物品数量是否大于零
			good :=  Good{}
			errGood := db.Table("web2020_goods").Where(" id = ?", goodid).Where(" num > 0").First(&good).Error
			if errors.Is(errGood, gorm.ErrRecordNotFound) {
				fmt.Println("商品已卖光")
				isok = 0
			} else {
				fmt.Println("找到商品：",good.Name)
			}
			//查找该用户是否已经对该商品下单
			order :=  Order{}
			errOrder := db.Table("web2020_orders").Where(" user_id = ?", userid).Where(" good_id = ?", goodid).Where(" status = ?", "waiting").First(&order).Error
			if errors.Is(errOrder, gorm.ErrRecordNotFound) {
				fmt.Println("无法下单")
				isok = 0
			} else {
				fmt.Println("可以对该商品下单，状态:",order.Status)
			}
			// 开始事务
			tx := db.Begin()
			timenow := time.Now().Unix()

			if isok == 1 {
				db.Table("web2020_orders").Where(" user_id = ?", userid).Where(" good_id = ?", goodid).Update("status","accept").Update("createtime",int(timenow))		
				db.Table("web2020_goods").Where(" id = ?", goodid).Update("num",good.Num-1)	
				
				fmt.Println("购买商品成功！")
			} else {
				db.Table("web2020_orders").Where(" user_id = ?", userid).Where(" good_id = ?", goodid).Update("status","failure").Update("createtime",int(timenow))		
				fmt.Println("购买商品失败！")
			}

			// 否则，提交事务
			tx.Commit()
			defer db.Close()
			fmt.Println("------------做完啦-----------")
		}
		}()
		log.Printf(" [*] Waiting for logs. To exit press CTRL+C")
		<-forever
}
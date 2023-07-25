# aws cli 설치
https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/install-cliv2-mac.html#cliv2-mac-install-cmd

# aws cli 설정
aws configure
aws s3 --endpoint-url=http://localhost:4566 ls

# bucket 생성

aws s3api create-bucket --bucket stest --create-bucket-configuration LocationConstraint=us-east-2 --endpoint-url=http://localhost:4566

# object 업로드
aws s3api put-object --bucket stest --body hello.txt --key hello --endpoint-url=http://localhost:4566

# bucket 내 object list up
aws s3api list-objects --endpoint-url=http://localhost:4566 --bucket stest

# object 다운로드
aws s3api get-object --endpoint-url=http://localhost:4566 --bucket stest --key hello output.txt

# mysql connector 등록
curl -v -XPOST -H'Accept:application/json' -H'Content-Type:application/json' http://connect1:18083/connectors \
  -d '
{
    "name": "mysql-source-connector",
    "config": {
        "connector.class": "io.debezium.connector.mysql.MySqlConnector",
        "database.hostname": "127.0.0.1",
        "database.port": "3306",
        "database.user": "root",
        "database.password": "passwd",
        "database.server.id": "1234",
        "database.server.name": "mysql-1",
        "database.include.list": "test",
        "database.history.kafka.bootstrap.servers": "b-2.amanokomsk.xoy4br.c4.kafka.ap-northeast-2.amazonaws.com:9092,b-1.amanokomsk.xoy4br.c4.kafka.ap-northeast-2.amazonaws.com:9092",
        "database.history.kafka.topic": "kafka-student-changes",
        "include.schema.changes": "true",
        "key.converter": "org.apache.kafka.connect.json.JsonConverter",
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "key.converter.schemas.enable": "false",
        "value.converter.schemas.enable": "false"
    }
}'

# s3 connector 등록
curl -v -XPOST -H'Accept:application/json' -H'Content-Type:application/json' http://connect1:18083/connectors \
  -d '{
    "name": "s3-sink-connector",
    "config": {
      "topics": "mysql-1.s3test.kafka",
      "connector.class": "io.confluent.connect.s3.S3SinkConnector",
      "flush.size": 1,
      "s3.bucket.name": "s3test",
      "s3.region": "us-east-2",
      "s3.part.size": "5242880",
      "s3.proxy.url": "http://localhost:4566",
      "format.class": "io.confluent.connect.s3.format.json.JsonFormat",
      "key.converter": "org.apache.kafka.connect.json.JsonConverter",
      "value.converter": "org.apache.kafka.connect.json.JsonConverter",
      "key.converter.schemas.enable": "false",
      "value.converter.schemas.enable": "false",
      "storage.class": "io.confluent.connect.s3.storage.S3Storage",
      "aws.access.key.id": "test",
      "aws.secret.access.key": "test",
      "topics.dir": "topicsdir"
    }
  }'

# Cluster status
curl -v -XGET -H'Accept: application/json' http://connect1:18083

# connectors
curl -v -XGET -H'Accept: application/json' http://connect1:18083/connectors
curl -v -XGET -H'Accept: application/json' 'http://connect1:18083/connectors?expand=status'
curl -v -XGET -H'Accept: application/json' http://connect1:18083/connectors/mysql-source-connector/config
curl -v -XGET -H'Accept: application/json' http://connect1:18083/connectors/mysql-source-connector/status
curl -v -XPUT -H'Accept: application/json' http://connect1:18083/connectors/mysql-source-connector/pause
curl -v -XPUT -H'Accept: application/json' http://connect1:18083/connectors/mysql-source-connector/resume

# mysql queries
/* CREATE TABLE kafka (
    student_no int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name char(10) NOT NULL,
    phone_no char(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO kafka(name, phone_no) VALUES('Sam', '01012345768');
INSERT INTO kafka(name, phone_no) VALUES('Mary', '01022445768');
INSERT INTO kafka(name, phone_no) VALUES('Tom', '0212342132');
INSERT INTO kafka(name, phone_no) VALUES('Susan', '021234423');
INSERT INTO kafka(name, phone_no) VALUES('Joe', '01073219284');

SELECT * FROM kafka;

UPDATE kafka SET phone_no='01077778888' where name='Sam';
*/


CREATE TABLE kafka (
    student_no INT NOT NULL IDENTITY  PRIMARY KEY,
    name char(10) NOT NULL,
    phone_no char(20)
) 
# 동작

terraform init
terraform plan
terraform apply -auto-approve

# 생성후 설정
# 퍼블릭 msk 를 사용하기 위해 acl 설정이 필수
# zookeeper 접속이 외부에서 불가 하기 때문에 bastion 에서 zookeeper 로 명령을 사용

bin/kafka-acls.sh --authorizer-properties zookeeper.connect=10.0.1.64:2181,10.0.1.55:2181,10.0.0.236:2181 --add --allow-principal "User:CN=*" --operation All --topic=* --transactional-id=*

bin/kafka-acls.sh --authorizer-properties zookeeper.connect=10.0.1.64:2181,10.0.1.55:2181,10.0.0.236:2181 --add --allow-principal "User:producer" --operation All --topic=* --group=* --transactional-id=*

bin/kafka-acls.sh --authorizer-properties zookeeper.connect=10.0.1.64:2181,10.0.1.55:2181,10.0.0.236:2181 --add --allow-principal "User:consumer" --operation All --topic=* --group=*


fullfillment-schemahistory

# connect 실행
bin/connect-distributed.sh config/connect-distributed.properties


# 토픽 조회
bin/kafka-topics.sh --list --zookeeper 10.0.1.64:2181,10.0.1.55:2181,10.0.0.236:2181

# 토픽 삭제
bin/kafka-topics.sh --delete --zookeeper 10.0.1.64:2181,10.0.1.55:2181,10.0.0.236:2181 --topic connect-configs
bin/kafka-topics.sh --delete --zookeeper 10.0.1.64:2181,10.0.1.55:2181,10.0.0.236:2181 --topic connect-offsets
bin/kafka-topics.sh --delete --zookeeper 10.0.1.64:2181,10.0.1.55:2181,10.0.0.236:2181 --topic connect-status

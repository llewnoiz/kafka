variable "region" {
    default = "ap-northeast-2"
    type = string
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
    type = string
}

variable "profile" {
    default = "mfa"
    type = string
}

variable "kafa_cluster_prefix" {
    default = "amano-ko"
    type = string
}

variable "tfstate_bucket" {
    default = "amano-dev-tfstate"
    type = string
}

variable "terraform_state_lock" {
    default = "amano-dev-state-lock"
    type = string
}

variable "tfstate_key" {
    default = "msk.tfstate"
    type = string
}

variable "public_access" {
    default = "SERVICE_PROVIDED_EIPS"#"SERVICE_PROVIDED_EIPS" #"DISABLED"
    type = string
}

variable "connector_external_url" {
    default = "https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/2.3.0.Final/debezium-connector-mysql-2.3.0.Final-plugin.tar.gz"
    type = string
}

variable "connector" {
    default = "connector.tar.gz"
    type = string
}

variable "instance_type"  {
    default = "kafka.t3.small"   
    type = string
}

variable "bastion_instance_type" {
    default = "t3.medium"   
    type = string
}

variable "key_pair_name" {
     default = "mks_key_pair"   
    type = string 
}
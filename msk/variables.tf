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


variable "source_connector" {
    default = "debezium-connector-sqlserver-2.3.0.Final.jar"
    type = string
}

variable "sink_connector" {
    default = "mssql-jdbc-8.4.1.jre8.jar"
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
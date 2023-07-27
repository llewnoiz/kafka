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

variable "rds_cluster_prefix" {
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
    default = "rds.tfstate"
    type = string
}

variable "database_subnet_group" {
    default = "rds.tfstate"
    type = string
}

variable "vpc_id" {
    default = "rds.tfstate"
    type = string
}
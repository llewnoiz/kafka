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
    default = "amano-ko-rds"
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
    default = "msk_rds_groups"
    type = string
}
variable "rds_subnet_ids" {
    default = [
        "subnet-05f48de8925351487",
        "subnet-026dab86bbede08bd",
        "subnet-01f7cd15637ba12e2",
        "subnet-0a352a007d442dbcd",
        "subnet-02becd1b4904b61e6",
        "subnet-08a81c29f63ee1bc5"
    ]
    type = list(string)
}

variable "vpc_id" {
    default = "vpc-0d18a4d4b26903c5a"
    type = string
}

variable "manage_master_user_password" {
    default = false
    type = bool
}

variable "rds_password" {
    default = "Bespin1!2"
    type = string
}

variable "monitoring_role_name" {
    default = "amano-rds-monitoring-role"
    type = string
}

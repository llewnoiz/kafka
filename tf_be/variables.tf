variable "region" {
    default = "ap-northeast-2"
    type = string
}

variable "profile" {
    default = "mfa"
    type = string
}

variable "kafa_cluster_prefix" {
    default = "amano"
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
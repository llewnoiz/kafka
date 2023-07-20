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

variable "tags" {
   default= {
    Name: "송현민-msk",
    resource: "msk",
    purpose : "amano korea proj test",
    team : "SK MFG서비스",
    enddate: "23/07/21"
  }
  type = map
  
}
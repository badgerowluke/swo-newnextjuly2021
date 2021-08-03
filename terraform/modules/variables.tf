variable "rg_name" {
    type = string
}

variable "location" {
    type = string
    default = "northcentralus"
}

variable "tier" {
    type = string
}

variable "redundancy" {
    type = string
}

variable "kind" {
    type = string
}
variable "admin_login" {
    type = string
    default = "SpadeSAUser"
}

variable "admin_password" {
    type = string
    default = "R3@llyGudP@55w0rd"
}

variable "dbname" {
    type = string
    default = ""
}
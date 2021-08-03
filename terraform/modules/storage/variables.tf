variable "name" {
    type = string
}

variable "location" {
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

variable "rg_name" {
    type = string
}

variable "dbname" {
    type = string
    default = ""
}
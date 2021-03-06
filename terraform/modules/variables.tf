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


variable "dbname" {
    type = string
    default = ""
}
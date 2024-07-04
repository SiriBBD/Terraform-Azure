
variable "applgroup" {
  default = "appl-group"
  type = string  
}

variable "regioname" {
    type = string
    default = "West Europe"
}

variable "virtnetworkname" {
    default = "appl-network"
    type = string  
}
variable "subnet" {
  default = "subnetA"
    type = string  
}

variable "ninterface" {
   default = "nin"
    type = string  
}
variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "type_instance" {
  type    = string
  default = "t2.micro"
}

variable "allow_ports" {
  type    = list(any)
  default = ["80", "443", "8080"]
}

variable "monitoring_t" {
  type = bool
}

variable "taggs" {
  type = map(any)
  default = {
    Name        = "Serv"
    Owner       = "Artyom"
    TelNumber   = "123321"
    Environment = "development"
  }
}

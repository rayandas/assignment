variable "ami" {
    type = string 
    default = "ami-08e0ca9924195beba"
}

variable "instance_type" {
    default = "t2.nano"
}

variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_security_group_ids" {
  type = string
  description = "ID of the security group to be attached to the EC2 Instance"
}

variable "subnet_id" {
  type = string
  description = "ID of the subnet in which EC2 instance is to be deployed"
}
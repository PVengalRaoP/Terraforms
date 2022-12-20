variable "region"{
description= "AWS Deployement Region"
default="ap-south-1"
}

variable "tagname"{
description = "Tag for vpc"
default="Vengi"
}

variable "vpc_cidr"{
description = "CIDR for VPC"
default="10.2.0.0/16"
}

variable "public_subnet_cidr" {
description = "Please specify CIDR for public subnet"
default = ["10.2.0.0/24", "10.2.1.0/24"]
}

variable "private_subnet_cidr" {
default= ["10.2.2.0/24","10.2.3.0/24"]
description = "Please specify CIDR for private subnet"
}
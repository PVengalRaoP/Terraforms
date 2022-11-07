variable "region"{
description= "AWS Deployement Region"
default="ap-south-1"
}

variable "subnetIds" {
    description = "Subnet Ids"
    default = ["subnet-9b5a8ee0","subnet-7bd95437"]
  
}

variable "engine" {
    description = "RDS engine"
    default = "mysql"
}

variable "eng_version" {
    description = "Engine Version"
    default = "8.0.28"
}

variable "identifier" {
    description = "RDS Identifier"
    default = "database1"
}

variable "username" {
    description = "Master User name"
    default = "admin"
}

variable "password" {
    description = "Password for Master User"
    default = "Pa&&w06D123"
}

variable "instance" {
    description = "What is the instance class"
    default = "db.t3.micro"  
}

variable "storageType" {
   description = "Type of Storage io1 or gp2"
   default = "io1"
}

variable "allocatedstorage" {
    description = "Allocated storage, Minimum: 100 GiB. Maximum: 65,536 GiB"
    default = 100
}

variable "iops" {
    description = "For storage type io1 only, Minimum: 1,000 IOPS. Maximum: 80,000 IOPS"
    default = 1000
  
}

variable "maxallocation" {
    description = "Max storage allocation"
    default = 200
}

variable "multiaz" {
    description = "Multi az ? "
    default = false
}

variable "publicAccess" {
    description = "Public access ?"
    default = false
}

variable "port" {
    description = "Port ?"
    default = 3306
}

variable "IamDbAuthentication" {
    description = "Authenticates using the database password and user credentials through AWS IAM users and roles."
    default = false
}

variable "dbname" {
    description = "Name of initial database"
    default = "firstdb"
}

variable "backupRetentionPeriod" {
    description = "This will enable auto backup if value is not set to zero(0), [From 1 to 35days]"
    default = 7
}

variable "backupwindow" {
    description = "The daily time range (in UTC) during which RDS takes automated backups"
    default = "09:46-10:16"
}

variable "copyTagsToSnapshot" {
    default = true
    description = "Copy tags to snapshot"
}

variable "storageencryption" {
    description = "Storage encryption"
    default = false
}

variable "maintenanceWindow" {
    description = "maintenance Window"
    default = "Mon:00:00-Mon:03:00"
  
}

variable "deletionProtection" {
    description = "delete protection"
    default = false  
}

variable "finalSnapShotIdentifier" {
    description = "Final snapshot identifier"
    default = "Terraform-RDS"
  
}


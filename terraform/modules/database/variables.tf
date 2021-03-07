variable "engine" {
  description = "The database engine to use"
  default     = "postgres"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  default     = "db.t2.micro"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  default     = 10
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not."
  default     = "gp2"
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "rayanpgdb"
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "rayandas"
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  default     = "rayandas"
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  #type        = list(string)
  #default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group."
  type        = string
  default     = ""
}

variable "skip_final_snapshot" {
  type = bool
  default = true
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted."
  type        = string
  default     = null
}

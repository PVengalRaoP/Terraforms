####MySql####

#creating aws subnet group --> which specifies in which VPC our rds lands
resource "aws_db_subnet_group" "default" {
  name       = "rds-mysql-subnetgroup"
  subnet_ids = var.subnetIds
  tags = {
    Name = "My DB subnet group"
  }
}


#creation of secuirty group --> [will implement later]

# resource "aws_security_group" "sg-for-rds-mysql" {
  #Need to update
# }

resource "aws_db_instance" "mysql-instance" {
  #Engine options
  engine = var.engine
  engine_version = var.eng_version

  #Settings
  identifier = var.identifier
  username = var.username
  password = var.password

  #Instance Config
  instance_class = var.instance

  #Storage
  storage_type = var.storageType
  allocated_storage = var.allocatedstorage
  iops = var.storageType != "gp2" ? var.iops : null 
  max_allocated_storage = var.maxallocation

  #Availability & durability
  multi_az = var.multiaz

  #Connectivity
  db_subnet_group_name = aws_db_subnet_group.default.name
  publicly_accessible = var.publicAccess
  vpc_security_group_ids = ["sg-05be6d50f4681be46"]
  port = var.port

  #Database Authentication
  iam_database_authentication_enabled = var.IamDbAuthentication
  #kerberos authentication

  #Additional options
  
  #Database options
  db_name = var.dbname
  #parameter_group_name = 

  #Backup
  // backup_retention_period = var.backupRetentionPeriod #This will enable auto backup
  /*
  Creates a point-in-time snapshot of your database
  Please note that automated backups are currently supported for InnoDB storage engine only. If you are using MyISAM, refer to details here [ https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.Storage ] .
  */

  // backup_window = var.backupwindow
  copy_tags_to_snapshot = var.copyTagsToSnapshot

  #Backup replication
  #Encryption
  storage_encrypted = var.storageencryption

  #performanceinsights
  
  
  #Monitoring


  
  #Logexports
  
  #Maintenance
  maintenance_window = var.maintenanceWindow

  #Deletion protection
  deletion_protection = var.deletionProtection

  #Snapshot
  final_snapshot_identifier = var.finalSnapShotIdentifier

}
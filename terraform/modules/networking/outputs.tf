output "public_subnet" {
  value = aws_subnet.public1.id
}

output "dbsubnet_group" {
  value = aws_db_subnet_group.subnet_group.name
}

output "security_group" {
  value = aws_security_group.security.id
}
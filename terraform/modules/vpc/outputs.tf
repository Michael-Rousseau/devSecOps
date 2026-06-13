output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "public_subnet_a_id" {
  value = aws_subnet.public_a.id
}

output "public_subnet_cidrs" {
  value = [aws_subnet.public_a.cidr_block, aws_subnet.public_b.cidr_block]
}

output "private_subnet_cidrs" {
  value = [aws_subnet.private_a.cidr_block, aws_subnet.private_b.cidr_block]
}

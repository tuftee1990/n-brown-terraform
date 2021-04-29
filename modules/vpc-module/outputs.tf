output "vpc_id" {
  value = aws_vpc.nb_vpc.id
}

output "analytics_subnet_id" {
  value = aws_subnet.nb_subnet_a.id
}

output "second_subnet_id" {
  value = aws_subnet.nb_subnet_b.id
}

output "third_subnet_id" {
  value = aws_subnet.nb_subnet_c.id
}

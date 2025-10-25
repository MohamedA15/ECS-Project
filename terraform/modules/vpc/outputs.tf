output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "private_subnet_id" {
  value = aws_subnet.private[*].id
  
} 

output "route_table_id" {
  value = aws_route_table.public_rt
  

}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "nat_eip_id" {
  value = aws_eip.nat_eip[*].id
  
}


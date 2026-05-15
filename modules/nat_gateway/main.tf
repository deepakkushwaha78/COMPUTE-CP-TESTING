resource "aws_eip" "nat_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = element(var.subnets_for_nat_gw, 1)
  tags = merge(
    {
      Name = format("%s", var.nat_name)
    },
    var.tags,
  )
}

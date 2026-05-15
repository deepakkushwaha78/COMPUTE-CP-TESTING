resource "aws_subnet" "subnet" {
  count             = length(var.subnets_cidr)
  availability_zone = element(var.availability_zones, count.index)
  cidr_block        = element(var.subnets_cidr, count.index)
  vpc_id            = var.vpc_id
  tags = merge(
    {
      Name = var.subnet_name[count.index],
    },
  )
}

resource "aws_route_table_association" "route_table_association" {
  count          = length(aws_subnet.subnet.*.id)
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = var.route_table_id
}
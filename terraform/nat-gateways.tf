# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway

resource "aws_nat_gateway" "gw1" {
  # The Allocation ID of the Elastic IP address for the gateway.
  allocation_id = aws_eip.nat1.id

  # Id of subnet to put the gateway.
  subnet_id = aws_subnet.public_1.id

  tags = {
    Name = "NAT 1"
  }
}

resource "aws_nat_gateway" "gw2" {
  # The Allocation ID of the Elastic IP address for the gateway.
  allocation_id = aws_eip.nat2.id

  # Id of subnet to put the gateway.
  subnet_id = aws_subnet.public_2.id

  tags = {
    Name = "NAT 2"
  }
}
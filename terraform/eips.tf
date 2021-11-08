# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip

resource "aws_eip" "nat1" {
  # EIP may require IGW to exist prior to association.
  depends_on = [aws_internet_gateway.main]
}

resource "aws_eip" "nat2" {
  # EIP may require IGW to exist prior to association.
  depends_on = [aws_internet_gateway.main]
}

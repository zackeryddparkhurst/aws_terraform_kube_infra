resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"

  # Required for EKS. Enable/disable DNS supoort in the VPC.
  enable_dns_support = true

  # Required for EKS. Enable/disable DNS hostnames in the VPC.
  enable_dns_hostnames = true

  # Makes your instance shared on the host.
  instance_tenancy = "default"

  # Enable/disable ClassicLink DNS Support for the VPC.
  enable_classiclink = false

  # Enable/disable ClassicLink for VPC.
  enable_classiclink_dns_support = false

  # Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length.
  assign_generated_ipv6_cidr_block = false

  # A map of tags to assign to the resource.
  tags = {
    Name = "main"
  }
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id."
  sensitive   = false
}
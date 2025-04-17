
#Getting the ubuntu Image 
 data "aws_ami" "ami" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu) Owner ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server*"] # Change for different versions
  }
}

data "aws_key_pair" "key"{
  key_name = "secret"
}


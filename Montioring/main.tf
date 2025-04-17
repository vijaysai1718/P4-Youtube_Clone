resource "aws_instance" "workstation" {

instance_type = "t2.large"
ami = data.aws_ami.ami.id
tags = {
    Name = "MonitoringServer"
}
key_name = data.aws_key_pair.key.key_name
user_data = file("Installation.sh")
vpc_security_group_ids = [aws_security_group.monitor_sg.id]

root_block_device {
    volume_size = 30        # 30 GB EBS
    volume_type = "gp2"     # General Purpose SSD (can be gp3 too)
  }

}

# #creating the key pair 
# resource "aws_key_pair" "secretkey" {
#     key_name   = "secret"
#    public_key = file("E:/DevopsAws/secret_key.pub")
# }

# creating the security group and allowing required traffic
resource "aws_security_group" "monitor_sg" {

 name = "monitor_sg"
 description = "allow ssh and http traffic"
 ingress= [for port in["22","9090","9100","8080","3000"]:{
    description      = "Opening ports"
       from_port = port
    to_port = port
    protocol ="tcp"
    cidr_blocks =["0.0.0.0/0"]
   ipv6_cidr_blocks = []
   prefix_list_ids = []
   security_groups = []
   self = false
 }
    ]
   

 egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
 
}

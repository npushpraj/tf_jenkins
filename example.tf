provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "example" {
  ami           = "ami-2d39803a"
  instance_type = "t2.micro"
  key_name = "ssh-east"
  user_data = "${file("userdata.sh")}"
  security_groups = ["jenkins_allow_all"]
  tags {
        Name = "jenkins"
    }
}
resource "aws_security_group" "jenkins_allow_all" {
  name = "jenkins_allow_all"
  description = "Allow all inbound traffic"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 
#  ingress {
#	from_port = 8080
#        to_port = 8080
#        protocol = "tcp"
#        cidr_blocks = ["0.0.0.0/0"]
# }
#
#  egress {
#	from_port = 8080
#        to_port = 8080
#        protocol = "tcp"
#        cidr_blocks = ["0.0.0.0/0"]
# }
#
  ingress {
	from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
 }

  egress {
	from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
 }

  ingress {
	from_port = 443 
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
 }

  egress {
	from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
 }

  ingress {
	from_port = 4040 
        to_port = 4040
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
 }

  egress {
	from_port = 4040
        to_port = 4040
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
 }



}

resource "aws_eip" "ip" {
    instance = "${aws_instance.example.id}"
}

output "ip" {
    value = "${aws_eip.ip.public_ip}"
}
output "private_ip" {
    value = "${aws_instance.example.private_ip}"
}
output "instance_type" {
    value = "${aws_instance.example.instance_type}"
}

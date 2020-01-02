provider "aws" {
  profile = "default"
  region = "ca-central-1"
}

resource "aws_key_pair" "teamspeak_server_ssh_key" {
  key_name   = "teamspeak_server_ssh_key"
  public_key = "${file("${path.module}/tempFiles/id_teamspeak.pub")}"
}

resource "aws_security_group" "teamspeak_ports" {
  name = "teamspeak_ports"
  description = "Opens the required ports to connect to and use Teamspeak."
}

resource "aws_security_group_rule" "allow_ssh_inbound" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.teamspeak_ports.id}"
}

resource "aws_security_group_rule" "allow_voice_inbound" {
  type              = "ingress"
  from_port         = 9987
  to_port           = 9987
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.teamspeak_ports.id}"
}

resource "aws_security_group_rule" "allow_file_transfer_inbound" {
  type              = "ingress"
  from_port         = 30033 
  to_port           = 30033 
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.teamspeak_ports.id}"
}

resource "aws_security_group_rule" "allow_server_query_inbound" {
  type              = "ingress"
  from_port         = 10011
  to_port           = 10011
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.teamspeak_ports.id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.teamspeak_ports.id}"
}

resource "aws_instance" "teamspeak_server" {
  ami                         = "ami-0d0eaed20348a3389"
  instance_type               = "t3a.micro"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.teamspeak_server_ssh_key.key_name}"
  security_groups             = ["${aws_security_group.teamspeak_ports.name}"]
}

x resource "aws_instance" "instance" {
  count         = 15
  ami           = "ami-x"
  instance_type = "t2.micro"
}

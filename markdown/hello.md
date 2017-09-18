<!-- .slide: data-background="images/world.jpg" data-transition="slide" data-background-transition="fade" -->
<p class="source">
Hello World ;)</p><br><br><br><br><br>
<br><br><br><br>
[https://github.com/npalm/tf-helloworld-demo](https://github.com/npalm/tf-helloworld-demo)


!SUB
# DEMO
<img data-src="images/giphy-hackerman.gif" height="80%" width="80%">


!SUB
### Hello World
<img data-src="images/tf-helloworld.png">


!SUB
### Hello World
<pre><code>
provider "aws" {
  region = "eu-west-1"
}







</code></pre>

!SUB
### Hello World
<pre><code>
resource "aws_security_group" "web" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Environment = "${var.environment}"
  }
}
</code></pre>

!SUB
### Hello World
<pre><code>
resource "aws_instance" "web" {
  ami                    = "ami-25488752"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  user_data              = "${file("template/user_data.sh")}"

  tags {
    Name        = "${var.environment}-bastion"
    Environment = "${var.environment}"
  }
}

</code></pre>

<div class="fragment">
<i class="fa fa-star fa-1g" aria-hidden="true"></i> **Tag** your resources consistently
</div>

data "aws_ami" "image" {
  most_recent = true
  filter {
    name   = "name"
    values = ["packer-linux-aws-demo-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
  
}

output "ami_id" {
  value = "${data.aws_ami.image.id}"
}

provider "aws" {
   region = "ap-south-1"
}

resource "aws_instance" "example" {
#  ami = "ami-0bb3b3f5e2dd720e5"
  ami = "${data.aws_ami.image.id}"
  instance_type = "t2.micro"
  key_name = "viskp"

  user_data = <<-EOF
                #!bin/bash
                mkdir app
                chmod 777 app
                cd app
                git clone -b develop https://github.com/chabhilashraju/tutor.git
                chmod 777 tutor
                cd tutor
                npm install
		export PATH=$PATH:/root/.npm-global/bin
		service nginx restart
                ng serve --host=0.0.0.0 --disable-host-check
              EOF
}

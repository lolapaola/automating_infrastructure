/*
    author: Paola A. Buitrago  @lolapaola
    credit: Joel W. King  @joelwking

    usage:

      Each resource type is implemented by a provider. Resource blocks describe the infrastructure objects.
      Resource must start with a letter or underscore and can contain only letters, numbers, and dashes.


      This configuration defines aws what type of aws instance I want to provision.

    references:
      - https://www.terraform.io/docs/configuration/resources.html
      - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instance.html
      - https://gitlab.com/joelwking/terraform_aci

*/
#
#  aws_instance - Create an t2.micro Ubuntu Server 20.04 LTS instance
#  configure Ec2 instance with using the user_data parameter script
#  use remote exec proviosner to also configure the Ec2 instance
#
resource "aws_instance" "lola_terraform_instance" {
    ami = "ami-09e67e426f25ce0d7"
    instance_type  = "t2.micro"
    key_name = "aws_key"
    user_data = file("setup.sh")
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo 'This is my fancy content in my hello file' >> hello.txt",
      "sudo apt install python3 -y",
      "sudo apt install python-is-python3 -y",
      "sudo ln -sf /usr/bin/python /usr/local/bin/python"
    ]
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ansible_user} -i '${self.public_ip},' --private-key ${var.private_key_file} -e 'pub_key=${var.pub_key_file}' install_apache.yml"
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file(var.private_key_file)
    timeout = "4m"
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  },
  {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 80
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 80
  }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = file(var.pub_key_file)
}

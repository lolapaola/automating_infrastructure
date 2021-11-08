/*
    author: Paola A Buitrago @lolapaola
    credit: Joel W. King  @joelwking

    usage:

      To declare variables use the variable block in one of your .tf files, such as `variables.tf`.
      A .tfvars file is used to assign values to variables that have already been declared in .tf files.

      Input variables are used as arguments for a Terraform module. If you are familiar with Python data types,
      the Terraform varaible block allows you to specify the data type of the variable, e.g. string, number, set, etc.

      However, the default values can declared and used in the variable block. An example of this is
      the variable `aws_region`. The aws_access_key and aws_secret_key are specifed as environment variables.

      In this file, we define varibles for the aws provider.

    references:
      - https://www.terraform.io/docs/configuration/variables.html
      - https://gitlab.com/joelwking/terraform_aci


*/

#
# Variables for AWS provider
#
variable "aws_access_key" {
  description = " Access Key for AWS User"
  default = "notLolasAccessKey"
  type = string
}

variable "aws_secret_key" {
  description = " Secret Key for AWS User"
  default = "notLolasSecretKey"
  type = string
}

variable "aws_region" {
  description = "AWS Region"
  default = "us-east-1"
  type = string
}

variable "pub_key_file" {
  description = "Public Key File Location"
  default = "~/.ssh/aws_key.pub"
  type = string
}

variable "private_key_file" {
  description = "Private Key File Location"
  default = "~/.ssh/aws_key"
  type = string
}

variable "ansible_user" {
  description = "Ansible User"
  default = "ubuntu"
  type = string
}

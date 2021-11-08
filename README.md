# Infrastructure and Automation - Part II

## Terraform

[Terraform](https://www.terraform.io/intro/index.html) is IaC tool that helps build, change and version your infrastructure.

It is a ***declarative*** language in which it describes the goal of your intended infrastructure versus an ***imperative*** language like Ansible where the goal is achieve in a specific series of steps.  Because of this, terraforms ordering of the code blocks is not important.

You can have one main.tf that builds your whole infrastructure configuration or breakdown the configuration into multiple .tf files.

Terraform is written in HCL [HashiCorp Configuration Language](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md) which allows for better readability and configuration.

---

**NOTE**| JSON file syntax is also supported

---

#### Terraform Lifecycle: **Init :arrow_forward: Plan :arrow_forward: Apply :arrow_forward: Destroy**

##### Init

This step initializes the current working directory where all the terraform configuration files are located

##### Plan

This step will compared the current working configuration to its state file  and what intended changes will occur

##### Apply

This step will apply the delta of changes that is against the state file and update the current state file

##### Destroy

This step will delete the infrastructure objects managed by the terraform configuration



#### Terraform Elements

##### Providers

Terraform providers are plugins that can be inserted into the configuration that can communicate with application interfaces.  Each provider has their own arguments they accept.  To go more in-depth, Terraform's [Registry](https://registry.terraform.io/browse/providers) website a slew of providers they interact with.

Examples:

* [AWS](https://registry.terraform.io/providers/hashicorp/aws/latest)
* [Microsoft Azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Without providers, Terraform does not have the ability to mange or communicate to anything.

##### Resources

Knowing the provider to be used, terraform can use resources from that provider to perform a desired action like provision an [EC2 instance in AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance). It is written in a resource block and you can have multiple blocks to build your configuration.

##### Variables

For flexibility, terraform allows the use of input variables as parameters for configurations.  They can be set in different locations.  The file `variable.tf` is mainly used for defining and a file with the `tfvars` extension is used to set the value of the variables being defined.  This promotes code reuse and the main code does not have to be changed.



#### Demo

The example I am going to demo is provisioning an EC2 instance.  There is a EC2 example from [geekflare](https://geekflare.com/terraform-for-beginners/) that is static and straightforward.  My goal is to make this code a bit more reusable and implement the different topics discussed above and more.

# Automating Infrastructure III

## Terraform Continued

#### Configuration of Resource

[Provisioners](https://www.terraform.io/docs/language/resources/provisioners/syntax.html) are used to model actions directly on a local machine or remote machine to help configure the object being provisioned. Theses used be use as a last resort if a resource does not a mechanic to pass configuration instructions.  For example the `aws_instance` resource has a parameter called `user_data` to pass data to EC2 instance at the time of creation and available at system boot

#### Demo

In this demo, I will demonstrate how to configure the EC2 instance using the following three different methods.

[**Resource** (aws_instance:user_data)]((https://www.bogotobogo.com/DevOps/Terraform/Terraform-terraform-userdata.php))

This action allows a script file to be run at launch time.



[**Local-Exec** (Provisioner)](https://www.terraform.io/docs/language/resources/provisioners/local-exec.html)

This invoke a process on the machine that is running Terraform and not on the resource that was created.  This is similar to Ansible concept of when you delegate a task to the local host.

Ansible will be used with the local-exec provisioner.



[**Remote-Exec** (Provisioner)](https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html)

This action invokes a script on the remote resource after it is created.

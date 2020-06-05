aws_region              = "eu-central-1"
availability_zone       = "eu-central-1a"
aws_credentials         = ".aws_credentials" #edit
public_key_path         = "~/.ssh/id_rsa.pub"
private_key_path        = "~/.ssh/id_rsa"
instance_ami            = "ami-0d783e301f8b9189f" // Ant Media Server Enterprise- Low Latency 
instance_type           = "c5.xlarge"
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidr      = "10.0.1.0/24"


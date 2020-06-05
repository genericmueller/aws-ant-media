# aws-ant-media

## terraform script for setting up an ant media server on AWS

### prerequisites ###

- AWS account with IAM account present (with AmazonEC2FullAccess rights)
- locally installed terraform
- free desec.io account (https://desec.io) for dynamic DNS
- ssh private/public keypair (Linux OS: ssh-keygen -t rsa)

### steps to perform

Clone this repo
```
git clone git@github.com:genericmueller/aws-ant-media.git
```

Prepare your credentials file
```
mv .aws_credentials.sample .aws_credentials
```

Fill in your own AWS credentials (see AWS console / IAM) and save the file.

export your AWS_ACCESS_KEY_ID and your AWS_SECRET_ACCESS_KEY on the cli (the same as in the .aws_credentials file)

```
export AWS_ACCESS_KEY_ID=YOUR_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_ACCESS_KEY
```

Initialize the terraform environment
```
terraform init
```

Prepare the dynamic DNS script
```
mv dedyn.sh.sample dedyn.sh
```

Fill in your own deSec credentials and your DynDNS name (for example: foo.dedyn.io) and save the file.
```
mv terraform.tfvars.sample terraform.tfvars
```

Fire up the terraform script.
```
terraform plan -out antmediaserver
terraform apply antmediaserver
```

When the process is finished you will get an output with your public IP and the instance_id of your server. You should than also be able to access your ant media server via your dyndns name.

for example: http://mediaserver.dedyn.io:5080

Login: JamesBond\
Password: instance_id

### tear down the environmet

To completely remove the environment, use the following command and type "yes" at the prompt.

```
terraform destroy
```
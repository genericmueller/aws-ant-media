# aws-ant-media

## terraform script for setting up an ant media server on AWS

### prerequisites ###

- AWS account with IAM account present
- locally installed terraform
- free desec.io account (https://desec.io) for dynamic DNS
- ssh private/public keypair (Linux OS: ssh-keygen -t rsa)

### steps to perform

git clone git@github.com:genericmueller/aws-ant-media.git

mv .aws_credentials.sample .aws_credentials

Fill in your own AWS credentials (see AWS console / IAM) and save the file.

terraform init

vm dedyn.sh.sample dedyn.sh

Fill in your own deSec credentials and your DynDNS name (for example: foo.dedyn.io) and save the file.


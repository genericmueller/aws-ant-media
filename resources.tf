# define SSH keys
resource "aws_key_pair" "default" {
  key_name = "default"
  public_key = file(var.public_key_path)
}

# define the streaming server
resource "aws_instance" "streamingserver" {
   ami  = var.instance_ami
   instance_type = var.instance_type
   key_name = aws_key_pair.default.id
   vpc_security_group_ids = ["${aws_security_group.public.id}"]
   subnet_id = aws_subnet.public.id
   associate_public_ip_address = true
   source_dest_check = false

  tags = {
    Name = "streamingserver"
  }

  # copy the dedyn.sh script to /usr/local/bin
  provisioner "file" {
    source      = "dedyn.sh"
    destination = "/tmp/dedyn.sh"
  }

  # copy the cronjob
  provisioner "file" {
    source      = "root.cron"
    destination = "/tmp/root.cron"
  }

  # copy script, cron and start dedy.sh
  provisioner "remote-exec" {
    inline = [
     "sudo cp /tmp/dedyn.sh /usr/local/bin",
     "sudo cp /tmp/root.cron /var/spool/cron/crontabs/root",
     "bash /usr/local/bin/dedyn.sh"
    ]
   }

  # restart cron
  provisioner "remote-exec" {
    inline = [
      "sudo service cron restart",
    ]
  }

  connection {
    type = "ssh"
    host = aws_instance.streamingserver.public_ip
    private_key = file(var.private_key_path)
    agent = false
    timeout = "2m"
    user = "ubuntu"
    }

}
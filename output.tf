output "streamingserver_public_ip" {
  value = "${aws_instance.streamingserver.public_ip}"
}

output "streamingserver_instance_id" {
  value = "${element(aws_instance.streamingserver.*.id, 0)}"
}
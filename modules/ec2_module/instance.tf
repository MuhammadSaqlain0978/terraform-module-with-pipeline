



resource "aws_instance" "web" {

    instance_type = var.instance_type
    ami = var.image_id
    subnet_id = var.subnet_id
    user_data = var.user_data

    tags = {
    Name = var.instance_name
  }

}

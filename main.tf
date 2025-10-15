provider "aws" {
  region = "us-east-1"
}


module "ec2" {
    source = "./modules/ec2_module"
    image_id = "ami-052064a798f08f0d3"
    instance_type = "t2.micro"
    subnet_id=     module.vpc.subnet_id
    instance_name = "ec2-via-module"

    user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd

                systemctl start httpd
                systemctl enable httpd
                echo "<h1>from module used</h1>" > /var/www/html/index.html
                EOF
 
}



module "vpc" {
    source = "./modules/vpc_module"
    vpc_cidr = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    vpc_name = "vpc-via-MODULE"
    
}

output MYpublicIP {
    value = module.ec2.publicIP
}

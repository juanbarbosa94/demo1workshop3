provider "aws" {
  #set your region 
  region = var.region
  version = "~> 2.0"
  #access_key = "my-access-key"
  #secret_key = "my-secret-key"
}

terraform {
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    # bucket         = "<YOUR S3 BUCKET>"
    # key            = "<SOME PATH>/terraform.tfstate"
    # region         = "us-east-2"
    # dynamodb_table = "<YOUR DYNAMODB TABLE>"
    # encrypt        = true

  }
}
variable "region" {
  description = "Select the region from the following list us-east-1 - us-east-2 - us-west-1 - us-west-2"
  type = string
}

variable "images" {
  description = "choose image for any region"
  type = map
  default = {
    us-east-1 = "ami-087c17d1fe0178315"
    us-east-2 = "ami-00dfe2c7ce89a450b"
    us-west-1 = "ami-011996ff98de391d1"
    us-west-2 = "ami-0c2d06d50ce30b442"
  }
}

resource "aws_instance" "demo1wrks1" {
  ami = var.images["${var.region}"]
  instance_type = "t2.micro"
  tags = {
    Name = "demo1workshop3v1"
  }
}
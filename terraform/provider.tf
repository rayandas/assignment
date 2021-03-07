provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "rayantestbucket"
    region = "ap-south-1"
    key = "./terraform.tfstate"
    dynamodb_table = "statelock"
    encrypt = true
    }
}

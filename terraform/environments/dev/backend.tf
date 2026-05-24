terraform {
  backend "s3" {
    bucket         = "deus-dashboard-tfstate"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "deus-dashboard-tf-locks"
    encrypt        = true
  }
}

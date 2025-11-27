terraform {
  backend "s3" {

    bucket  = "abhibuckettfstate89403-bcde"
    key     = "-node/tfstate/terraform.tfstate"
    encrypt = true
    region  = "ap-south-1"
  }
}

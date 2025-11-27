terraform{
backend "s3" {
  
  bucket = "abhibuckettfstate89403-bcde"
  key = "${var.project_name}/tfstate/terraform.tfstate"
  encrypt = true
  region = "ap-south-1"
}
}
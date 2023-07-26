terraform {
  backend "s3" {
    bucket = "dembucketforterraform"
    key    = "dembucketforterraform/backend"
    region = "ap-south-1"
    profile = "vscode"
  }
}

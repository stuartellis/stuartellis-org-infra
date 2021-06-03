remote_state {
    backend = "s3"
    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }

  config = {
      bucket = "stuartellis-longhouse-dev-tfstate-eu-west-1"
      key = "${path_relative_to_include()}/terraform.tfstate"
      region = "eu-west-1"
      encrypt = true
      dynamodb_table = "stuartellis-longhouse-dev-tfstate-lock-eu-west-1" 
  }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
provider "aws" {
    region = "eu-west-1"
}
EOF
}

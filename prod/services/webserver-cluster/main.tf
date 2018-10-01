provider "aws" {
  region  = "eu-west-3"
  version = "~> 1.36"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

module "webserver_cluster" {
  source                 = "git::git@github.com:neogabe/terraform-modules.git//services/webserver-cluster?ref=v1.0.5"

  ami                    = "ami-06340c8c12baa6a09"
  server_text            = "New text"

  cluster_name           = "webserver-prod"
  db_remote_state_bucket = "terraform-state-neogabe"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.medium"
  min_size               = 2
  max_size               = 4
  enable_autoscaling     = true
  enable_new_user_data   = false // Test with 0

}

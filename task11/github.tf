resource "github_repository" "terraform-modules" {
  name = var.terraform_name
  auto_init = true
  visibility = "public"
}

resource "github_repository_file" "name" {
    repository = github_repository.terraform-modules.name
    branch = github_repository.terraform-modules.default_branch
    file = "service/main.tf"
    content = file("${var.path_to_file}/service.tf")

  
}
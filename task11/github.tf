# создаем новый репозиторий, если требуется
#resource "github_repository" "terraform-modules" {
#  name       = var.terraform_name
#  auto_init  = true
#  visibility = "public"
#}

resource "github_repository_file" "name" {
  count               = length(var.files)
  repository          = var.github_repository
  branch              = "master"
  file                = "task11/${element(var.files, count.index)}"
  content             = file("${var.path_to_file}/${element(var.files, count.index)}")
  commit_message      = "add by Terraform"
  commit_author       = "Te0s"
  commit_email        = "teos.otaku@gmail.com"
  overwrite_on_create = true

}
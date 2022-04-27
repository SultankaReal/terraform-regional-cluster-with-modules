variable "default_folder_id" { //your folder-id
  default = "<your-folder-id>" 
}

variable "default_cloud_id" { //your cloud-id
  default = "<your-cloud-id>" 
}

variable "default_token" { //your token that should be created by 'yc iam create-token'
  type    = string 
  default = "<your-token>"
}

variable "default_zone" { //your default zone
    default = "ru-central1-a"
}
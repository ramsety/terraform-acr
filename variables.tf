variable "RG_NAME" {
  description = "name of the resources group where acr will be deployed"
    type = string
    default = "eval-rg"
}

variable "ACR_NAME" {
  description = "name of the acr"
    type = string
    default = "eval-acr"
}


variable "environment_name" {
    description = "Value of the environment where acr will be deployed"
    type = string
    default = "test"
}

variable "container_registry_name" {
    description = "Value of the container registry to be created"
    type = string
    default = "test-acr"
}

variable "location" {
    description = "Value of the location where container registry to be created"
    type = string
    default = "East US"
}

variable "allowed_subnet_ids" {
    description = "Value of the location where container registry to be created"
    type = list(map)         
    default = ["10.0.0.0/24","10.1.0.0/24","10.2.0.0/24"]
}

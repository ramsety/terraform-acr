variable "RG_NAME" {
  description = "name of the resources group where acr will be deployed"
    type = string
    default = "eval-rg"
}

variable "ACR_NAME" {
  description = "name of the acr"
    type = string
    default = "evalacrmsty02"
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

variable "RG_NAME" {
  description = "Value of the environment where acr will be deployed"
    type = string
    default = "eval-rg"
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
    type = list(string)         #check the right function
    default = subnet id's        #list of 3 subnet id's to be allowed
}

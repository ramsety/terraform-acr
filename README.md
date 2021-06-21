# Terraform-Test

The following project will deploy the follow resources to the Azure cloud with the help of Azure Devops:

a.) Azure ACR

## Files

Terraform files : 

i) main.tf : This file contains the all the deployments specification about the above 2 azure resources

ii) provider.tf : This file contains the provider information i.e. the azurerm and the version info

iii) variable.tf : This file contains the variable definition used in main.tf also contains the specification for Azure pipeline TF_VAR variables which can be passed during the runtime

iv) locals.tf : additional file containing the definition of the local block variables

azure-pipelines.yml : this is azure pipeline yaml file contains the pipeline definition and and a job with the following Tasks for terraform script validation and deployment:

i) terraform install : this task will install the terraform executables on the pipeline agent

ii) 'Terraform : INIT' : this task will run the terraform initialization 

iii) 'Terraform : PLAN' : this task will run the terraform plan to dry run the configuration and check everything further gives the plan output

iv) 'Terraform : VAL & APPLY' : this final task of the job will run the terraform validate and after the successful validation runs the terraform apply to initiate the deployment of the resources on azure subscription

project-info.doc : these files contains the necessary documentation about the project



## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

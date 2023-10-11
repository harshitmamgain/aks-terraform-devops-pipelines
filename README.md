# Deploy Azure Kubernetes Cluster using Terraform and Azure DevOps Pipelines 

Deploy AKS cluster using Terraform modules and create a YAML pipeline on Azure DevOps pipelines.

# Project Details
 - The services that were used during the course of this Projects are as follows:
     - Azure Key Vault 
     - Microsoft Entra ID
     - Azure DevOps Pipelines
     - Terraform

# Steps

- Service Connection between Azure DevOps and Azure account
     - Create an Service Principal
     - Create a Service Connection

- Azure Key Vault
    - Create a a Key vault
    - Assign your user the permission to create, list and delete
    - Store the following in the Key Vault so that the pipeline can automatically fetch these details and are not stored in plaintext
    - Assign permission to the SP to get and set Key Vault

- Azure DevOps Pipeline
    - Store the code in your GitHub repository
    - Create a Pipeline and use the Repository where you have stored the Terraform files
    - Create YAML Pipeline (using akspipeline.yml) with the help Terraform CLI assistant
    - Run the pipeline
 
# Conclusion

After performing the steps above, you will have succesfully deployed a an AKS cluster using Terraform and Azure DevOps.

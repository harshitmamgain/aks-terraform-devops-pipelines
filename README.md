# Azure Kubernetes Cluster using Terraform and Azure DevOps Pipelines 

Set up AKS cluster using Terraform and secure your secrets with Azure Key Vault. Streamline your deployment with Azure DevOps Pipelines for contineous deployment.

# Project Details

* The services that were used during the course of this Projects are as follows:
  * Azure Key Vault
  * Microsoft Entra ID
  * Azure DevOps Pipelines
  * Terraform

# Steps

### Create a Azure DevOps account and create an Organization within your Azure DevOps account

  ```
  https://learn.microsoft.com/en-us/azure/devops/repos/get-started/sign-up-invite-teammates?view=azure-devops
  ```

### Setup a Service Connection in Azure DevOps to connect the YAML pipeline to the Azure Platform 

  * On Microsoft Entra ID, select **App Registration** and register an application to create a Service Principal.
  * Create a application secret for the registered application.
  * **Add role assignment** for the newly created application to create resource in Azure. 
      * *NOTE*: Make a note of the Application ID and secret value, you will use this in the next step and in the PowerShell script to give the Service Principal access to retrieve secrets from Key Vault.
  * In Azure DevOps, create a new **Service Connection** with Azure Resource Manager using service principal (manual).
      * Enter your Subscription Id, Subscription Name, Service Principal Id (Application ID), Service principal key (app secret), Tenant ID and click verify to create the Service Connection.     

### Store secrets in Azure Key Vault and assign access policy

  * Run custom PowerShell script (keyvault.ps1) to create the following:
     * **Resource group** for the key vault.
     * **Key vault** to store securely store the secrets and not in plaintext.
     * **SSH key** for passwordless login between Kubenertes agent nodes.
     * Using the **Set-AzKeyVaultSecret** cmdlet to create and store the secrets in the Key vault. 
     * Assign **Access policy** to yourself and the service principal to grant permission to fetch secrets automatically from the Key Vault using the **Set-AzKeyVaultAccessPolicy** cmdlet.
     * *NOTE*: Make the changes to the script as mentioned and execute the script in Azure PowerShell.

### Terraform template
   
   * From the **main.tf** file:
     * You will be first retrieve the data from the Azure Key Vault for the *ssh public key*, *service principal id* and *secret* that were stored in the Key vault in the previous steps.
     * Then you will create a resource group (for the AKS cluster), virtual network, subnet and the AKS cluster.
   * Enter variable assignments in the **input.auto.tfvars** file.

### Configure the Pipeline to deploy the Azure Kubernetes Service through Terraform template

  * Store the code in **Terraform** files in your choice of version control tools like **GitHub**, **Azure Repos** etc.
  * On your Azure Organization click on **Pipelines** and then **Create Pipeline**
  * Connect the version control tool where you have stored the Terraform files.
  * Create a **Starter Pipeline**, copy and paste the **YAML** script *akspipeline.yml*.
     * The **YAML** pipeline using the agent will perform the Terraform command to **validate**, **plan** and **apply** to deploy the resources to Azure.     
  * Save and run the pipeline.

### Verify the deployment

  * After the pipeline runs succesfully, make your way to the Azure portal to verfiy the deployment of the resources.
  * In your Azure CLI enter the following command to connect to the AKS cluster:
    ```
    az aks get-credentials --resource-group akscluster-rg --name akscluster
    ```
  * Verify if the **kubectl** clients works by runnign:
    ```
    kubectl get nodes
    ```
  * You should be able to see 2 nodes deployed in the cluster.

# Conclusion

After performing the steps above, you will have succesfully deployed an Azure Kubernetes Service cluster using Terraform and Azure DevOps Pipelines.

#### Parameters, make changes to the values as required

$keyvaultname = "aks-devops-kv"
$location = "eastus"
$keyvaultrg = "aks-akv-rg"
$sshkeysecret = "akssshpubkey"
$clientidkvsecretname = "spn-id"
$spnkvsecretname = "spn-secret"
$userobjectid = ### Enter the your Object ID; Microsoft Entra ID --> Users --> Select user --> Object ID or Get-AzureADUser
$spnclientsecret = ### This is the value that was noted in Step 3
$spAppID = ### App ID of the Service Principal; Microsoft Entra ID --> App Registrations --> Select App --> App ID or Get-AzureADApplication


#### Create Key Vault

New-AzResourceGroup -Name $keyvaultrg -Location $location

New-AzKeyVault -Name $keyvaultname -ResourceGroupName $keyvaultrg -Location $location

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -UserPrincipalName $userobjectid -PermissionsToSecrets get,set,delete,list


#### create an ssh key for setting up password-less login between agent nodes.

ssh-keygen  -f ~/.ssh/id_rsa_terraform


#### Add SSH Key in Azure Key vault secret

$pubkey = cat ~/.ssh/id_rsa_terraform.pub

$Secret = ConvertTo-SecureString -String $pubkey -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $sshkeysecret -SecretValue $Secret


#### Store service principal Client id in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spAppID -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $clientidkvsecretname -SecretValue $Secret


#### Store service principal Secret in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientsecret -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $spnkvsecretname -SecretValue $Secret


#### Provide Keyvault secret access to SPN using Keyvault access policy

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -ServicePrincipalName $spAppID -PermissionsToSecrets Get,Set

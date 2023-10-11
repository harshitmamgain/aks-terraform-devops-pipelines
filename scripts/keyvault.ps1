# Starter pipeline
# Start with a minimal pipeline that you can customize to build and deploy your code.
# Add steps that build, run tests, deploy, and more:
# https://aka.ms/yaml

trigger: none

pool:
  vmImage: ubuntu-latest

steps:
- task: TerraformCLI@1
  displayName: Terraform Init
  inputs:
    command: 'init'
    allowTelemetryCollection: true

- task: TerraformCLI@1
  displayName: Terraform Plan
  inputs:
    command: 'plan'
    environmentServiceName: 'AzuretoAzureDevOps'
    allowTelemetryCollection: false

- task: TerraformCLI@1
  displayName: Terraform Apply
  inputs:
    command: 'apply'
    environmentServiceName: 'AzuretoAzureDevOps'
    allowTelemetryCollection: true
# Links

## OVH
- Terraform : https://docs.ovh.com/fr/fr/docs/public-cloud/utiliser-terraform
- Glance : https://www.ovh.com/fr/g2072.debuter_avec_lapi_glance
- Nova : https://www.ovh.com/fr/g1935.debuter_avec_lapi_nova

# Requirements

## Binary download and installation

```{r, engine='bash', count_lines}
wget "https://releases.hashicorp.com/terraform/0.10.6/terraform_0.10.6_linux_386.zip"
unzip terraform_0.10.6_linux_386.zip
```

## Add-on installation

```{r, engine='bash', count_lines}
apt install python-glance python-nova
```

# Workspace initialisation

```{r, engine='bash', count_lines}
mkdir test_terraform && cd test_terraform
terraform env new test_terraform
```

Few useful commands :

```{r, engine='bash', count_lines}
terraform workspace list
```

Get & adapt terraform file (*.tf) on repository and do follow actions

```{r, engine='bash', count_lines}
terraform plan
terraform apply
```

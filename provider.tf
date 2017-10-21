# Configure le fournisseur OpenStack hébergé par OVH
provider "openstack" {
  auth_url = "https://auth.cloud.ovh.net/v3" # URL d'authentification
  domain_name = "default" # Nom de domaine - Toujours à "default" pour OVH
  alias = "ovh" # Un alias
  user_name = <username>
  tenant_name = <tenant_name>
  password = <passwd>
}

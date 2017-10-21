# Import de la clé SSH au sein d'OpenStack
resource "openstack_compute_keypair_v2" "test_keypair" {
  provider = "openstack.ovh" # Nom du fournisseur déclaré dans provider.tf
  name = "test_keypair" # Nom de la clé SSH à utiliser pour la création
  public_key = "${file("~/.ssh/id_rsa.pub")}" # Chemin vers votre clé SSH précédemment générée
}

# Création d'une machine virtuelle OpenStack
resource "openstack_compute_instance_v2" "test_terraform_instance" {
  name = "terraform_instance" # Nom de l'instance
  provider = "openstack.ovh" # Nom du fournisseur
  image_name = "Debian 9" # Nom de l'image
  flavor_name = "s1-2" # Nom du type de machine
  # Nom de la ressource openstack_compute_keypair_v2 nommé test_keypair
  key_pair = "${openstack_compute_keypair_v2.test_keypair.name}"
  network {
    name = "Ext-Net" # Ajoute le réseau public à votre instance
  }
}

# Créer une ressource de volume afin de stocker des données
resource "openstack_blockstorage_volume_v2" "volume_to_add" {
  provider = "openstack.ovh" # Nom du fournisseur
  name = "simple_volume" # Nom du volume
  size = 10 # Taille du volume en GB
}

# Ajouter le volume créé précédemment à la machine
resource "openstack_compute_volume_attach_v2" "attached" {
  # Identifiant de la ressource openstack_compute_instance_v2 nommé test_terraform_instance
  instance_id = "${openstack_compute_instance_v2.test_terraform_instance.id}"
  # Identifiant de la ressource openstack_blockstorage_volume_v2 nommé volume_to_add
  volume_id = "${openstack_blockstorage_volume_v2.volume_to_add.id}"
}

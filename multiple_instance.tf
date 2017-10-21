# Créer une variable région contenant la liste des régions d'OVH
# On l'utilisera pour itérer sur les différentes régions afin de
# démarrer une instance sur chacune d'entre elles.
variable "region" {
  type = "list"
  default = ["BHS3", "GRA3", "SBG3", "WAW1"]
}

# Création d'une paire de clé SSH
resource "openstack_compute_keypair_v2" "test_keypair_all" {
  count = "${length(var.region)}"
  provider = "openstack.ovh" # Préciser le nom du fournisseur
  name = "test_keypair_all" # Nom de la clé SSH
  public_key = "${file("~/.ssh/id_rsa.pub")}" # Chemin de votre clé SSH
  region = "${element(var.region, count.index)}"
}

# Créer une ressource qui est une machine OpenStack dans chaque région
resource "openstack_compute_instance_v2" "instances_on_all_regions" {
  # Nombre de répétitions de création d'instance
  # Ici c'est la longueur de la list nommé région
  count = "${length(var.region)}"
  provider = "openstack.ovh" # Nom du fournisseur
  name = "terraform_instances" # Nom de la machine
  flavor_name = "s1-2" # Nom du type de machine
  image_name = "Debian 9" # Nom de l'image
  # element est une fonction qui accède à l'élément à la position
  # count.index de la liste var.region. Il permet d'itérer entre les régions
  region = "${element(var.region, count.index)}"
  # Accède au nom de la variable de la ressource openstack_compute_keypair_v2 nomé test_keypair
  key_pair = "${element(openstack_compute_keypair_v2.test_keypair_all.*.name, count.index)}"
  network {
    name = "Ext-Net" # Ajoute le réseau public à votre instance
  }
}

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  cloud_id  = "b1g3me49qkcgicgvrgv2"
  folder_id = "b1g4fb7qmqpe9rvo57q2"
  zone      = "ru-central1-a"
}

# Инстанс elascicsearch
resource "yandex_compute_instance" "el" {
  name = "el-instance"
  platform_id = "standard-v1"

  resources {
    cores = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd88d018b9a937uli9bn" # Centos-7
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.elk-subnet.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
    #ssh-keys = "${file("~/.ssh/id_ed25519.pub")}"
  }  
}

# Инстанс kibana
resource "yandex_compute_instance" "kib" {
  name = "kibana-instance"
  platform_id = "standard-v1"

  resources {
    cores = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd88d018b9a937uli9bn" # Centos-7
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.elk-subnet.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }  
}

# Инстанс filebeat
resource "yandex_compute_instance" "app" {
  name = "app-instance"
  platform_id = "standard-v1"

  resources {
    cores = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd88d018b9a937uli9bn" # Centos-7
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.elk-subnet.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }  
}


resource "yandex_vpc_network" "elk-network" {
  name = "elk-net"
}

resource "yandex_vpc_subnet" "elk-subnet" {
  name       = "elk-snet"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone       = "ru-central1-a"
  network_id = "${yandex_vpc_network.elk-network.id}"
}
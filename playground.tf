locals {
  plauground_user_data = <<TFEOF
#! /bin/bash

apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# Complete fingerprint: 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
apt-key fingerprint 0EBFCD88

add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

apt-get update
apt-get install -y docker-ce

apt-get install -y python-pip && pip install awscli docker-compose

mkdir -p /opt/orbs

cat <<-EOF > /opt/orbs/docker-compose.yml
version: "3"

services:
    gamma-1:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-2:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-3:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-4:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-5:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-6:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-7:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-8:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-9:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-10:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-11:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-12:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-13:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-14:
        image: orbsnetwork/gamma:experimental
        restart: always

    gamma-15:
        image: orbsnetwork/gamma:experimental
        restart: always

    playground:
        image: orbsnetwork/playground:experimental
        ports:
            - 80:3000
        environment: 
            NODE_ENV: production
            ORBS_END_POINTS: '[{"URL":"http://gamma-1:8080","VCHAIN_ID":42},{"URL":"http://gamma-2:8080","VCHAIN_ID":42},{"URL":"http://gamma-3:8080","VCHAIN_ID":42},{"URL":"http://gamma-4:8080","VCHAIN_ID":42},{"URL":"http://gamma-5:8080","VCHAIN_ID":42},{"URL":"http://gamma-6:8080","VCHAIN_ID":42},{"URL":"http://gamma-7:8080","VCHAIN_ID":42},{"URL":"http://gamma-8:8080","VCHAIN_ID":42},{"URL":"http://gamma-9:8080","VCHAIN_ID":42},{"URL":"http://gamma-10:8080","VCHAIN_ID":42},{"URL":"http://gamma-11:8080","VCHAIN_ID":42},{"URL":"http://gamma-12:8080","VCHAIN_ID":42},{"URL":"http://gamma-13:8080","VCHAIN_ID":42},{"URL":"http://gamma-14:8080","VCHAIN_ID":42},{"URL":"http://gamma-15:8080","VCHAIN_ID":42}]'
EOF

/usr/local/bin/docker-compose -f /opt/orbs/docker-compose.yml up -d

TFEOF
}

resource "aws_instance" "plauground" {
  ami               = "${data.aws_ami.ubuntu-18_04.id}"
  count             = 1
  instance_type     = "${var.instance_type}"

  # This machine type is chosen since we need at least 16GB of RAM for mainnet
  # and sufficent amount of networking capabilities
  security_groups = ["${aws_security_group.plauground.id}"]

  key_name  = "${aws_key_pair.deployer.key_name}"
  subnet_id = "${ module.vpc.subnet-ids-public[0] }"

  user_data = "${local.plauground_user_data}"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file(var.ssh_private_keypath)}"
  }

  tags = {
    Name = "plauground-${count.index+1}"
  }
}

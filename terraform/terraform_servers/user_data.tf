locals {
  consul-server-instance-userdata = <<USERDATA
#!/bin/bash
sudo apt update -y
sudo apt install python3
sudo apt install python3-pip
sudo apt install awscli -y
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDe3eJDO2vAennWX4IDtRAU3XPHr0LGXQaKyKhbgD98woWkHp7Fy0mnxiTeN4aVZ5EuBWh5Ganyvud0giRLucVDjH/mvkhrhuCGmTnOLVswsF15O2TYlBlOO5jtSvfSqmjy1cvytQ2SQZAP+WbmasOmAs5+r45PfWFcSSD/ZOnEE0KcgB/vbdCbxQQq+FKfZnI4t5bFdMm6ZJ4SlI+MioME6jPFKb6n4qq2TJrvTbgrJDyEA+EEMX2v/3BtfS+fXP3LIvJIED1NNEMC3YNQQydWxQzz1XG48A/G7pP/1VSliP65YYHFbq9SXPezmCy1aHS9JbX+jy7JN+S1ksyVEZZ6n/2dDbedg7YuoSWn/mc9d6nmpcbAYQ+TaruiABiHdDzBx+XLk7uwSTnUli1TTaHgStohGV3vw8iqNvp7khnvnUc1dh3yU+c73oNpCpToufwAu2yLHMg1s5gzCZs1PqWqjOgWySdNEAG9NtHZvTHHh3QPcm82S2ZRvxBjr3v5dlM5qbP3+bNM6kc9ylCjygcJRb2dVkHlBBL4Avv0Dq+36iy8Tk4uKrKmdJtXvBertuTessknyb2lRzjNjyRRwSwaTHEdIUNOiZTt3ZZyRAm6h0vxFKixfERDpnCznH4DtLTwdA5HtWe+5uK/2fXWCu6c5pbLz4Zv5os1BuuJep1vRQ== ubuntu@ip-172-31-22-246" >> /home/ubuntu/.ssh/authorized_keys
chmod  600 /home/ubuntu/.ssh/authorized_keys

USERDATA
}

locals {
  elasticsearch_server_instance_userdata = <<USERDATA
#!/bin/bash
sudo apt update -y
sudo apt install python3
sudo apt install python3-pip
sudo apt install awscli -y
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDe3eJDO2vAennWX4IDtRAU3XPHr0LGXQaKyKhbgD98woWkHp7Fy0mnxiTeN4aVZ5EuBWh5Ganyvud0giRLucVDjH/mvkhrhuCGmTnOLVswsF15O2TYlBlOO5jtSvfSqmjy1cvytQ2SQZAP+WbmasOmAs5+r45PfWFcSSD/ZOnEE0KcgB/vbdCbxQQq+FKfZnI4t5bFdMm6ZJ4SlI+MioME6jPFKb6n4qq2TJrvTbgrJDyEA+EEMX2v/3BtfS+fXP3LIvJIED1NNEMC3YNQQydWxQzz1XG48A/G7pP/1VSliP65YYHFbq9SXPezmCy1aHS9JbX+jy7JN+S1ksyVEZZ6n/2dDbedg7YuoSWn/mc9d6nmpcbAYQ+TaruiABiHdDzBx+XLk7uwSTnUli1TTaHgStohGV3vw8iqNvp7khnvnUc1dh3yU+c73oNpCpToufwAu2yLHMg1s5gzCZs1PqWqjOgWySdNEAG9NtHZvTHHh3QPcm82S2ZRvxBjr3v5dlM5qbP3+bNM6kc9ylCjygcJRb2dVkHlBBL4Avv0Dq+36iy8Tk4uKrKmdJtXvBertuTessknyb2lRzjNjyRRwSwaTHEdIUNOiZTt3ZZyRAm6h0vxFKixfERDpnCznH4DtLTwdA5HtWe+5uK/2fXWCu6c5pbLz4Zv5os1BuuJep1vRQ== ubuntu@ip-172-31-22-246" >> /home/ubuntu/.ssh/authorized_keys
chmod  600 /home/ubuntu/.ssh/authorized_keys

##### Mounting Jenkins home directory (EBS Volume) #########
sudo mkdir /data -p
sudo chmod 755 /data
sudo chown ubuntu:ubuntu /data/
sudo chmod 777 /etc/fstab
sudo echo '/dev/nvme1n1 /data ext4 defaults,nofail        0       0' >> /etc/fstab
sudo sleep 60
sudo mount -a
sudo chown ubuntu:ubuntu /data/


USERDATA
}

locals {
  prometheus_server_instance_userdata = <<USERDATA
#!/bin/bash
sudo apt update -y
sudo apt install python3
sudo apt install python3-pip
sudo apt install awscli -y
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDe3eJDO2vAennWX4IDtRAU3XPHr0LGXQaKyKhbgD98woWkHp7Fy0mnxiTeN4aVZ5EuBWh5Ganyvud0giRLucVDjH/mvkhrhuCGmTnOLVswsF15O2TYlBlOO5jtSvfSqmjy1cvytQ2SQZAP+WbmasOmAs5+r45PfWFcSSD/ZOnEE0KcgB/vbdCbxQQq+FKfZnI4t5bFdMm6ZJ4SlI+MioME6jPFKb6n4qq2TJrvTbgrJDyEA+EEMX2v/3BtfS+fXP3LIvJIED1NNEMC3YNQQydWxQzz1XG48A/G7pP/1VSliP65YYHFbq9SXPezmCy1aHS9JbX+jy7JN+S1ksyVEZZ6n/2dDbedg7YuoSWn/mc9d6nmpcbAYQ+TaruiABiHdDzBx+XLk7uwSTnUli1TTaHgStohGV3vw8iqNvp7khnvnUc1dh3yU+c73oNpCpToufwAu2yLHMg1s5gzCZs1PqWqjOgWySdNEAG9NtHZvTHHh3QPcm82S2ZRvxBjr3v5dlM5qbP3+bNM6kc9ylCjygcJRb2dVkHlBBL4Avv0Dq+36iy8Tk4uKrKmdJtXvBertuTessknyb2lRzjNjyRRwSwaTHEdIUNOiZTt3ZZyRAm6h0vxFKixfERDpnCznH4DtLTwdA5HtWe+5uK/2fXWCu6c5pbLz4Zv5os1BuuJep1vRQ== ubuntu@ip-172-31-22-246" >> /home/ubuntu/.ssh/authorized_keys
chmod  600 /home/ubuntu/.ssh/authorized_keys

##### Mounting Jenkins home directory (EBS Volume) #########
sudo mkdir /data -p
sudo chmod 755 /data
sudo chown ubuntu:ubuntu /data/
sudo chmod 777 /etc/fstab
sudo echo '/dev/nvme1n1    /data    ext4    defaults,nofail        0       0' >> /etc/fstab
sudo sleep 60
sudo mount -a
sudo chown ubuntu:ubuntu /data/


USERDATA
}

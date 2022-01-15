#############
# User Data #
#############

locals {
  jenkins-slave-instance-userdata = <<USERDATA
#!/bin/bash
sudo mkdir /data -p
sudo chmod 755 /data
sudo chown ubuntu:ubuntu /data/
sudo chmod 777 /etc/fstab
sudo echo '/dev/xvdh /data ext4 defaults,nofail        0       0' >> /etc/fstab
sudo sleep 60
sudo mount -a
sudo chown ubuntu:ubuntu /data/

##### Installing Docker #########
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu
sudo sed -i $'/ExecStart=/c\\ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock\n' /lib/systemd/system/docker.service
sudo systemctl daemon-reload
sudo service docker restart
sudo docker run -d --restart=always -p 8080:8080 -p 50000:50000 -v /data/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --env JAVA_OPTS='-Djenkins.install.runSetupWizard=false' jenkins/jenkins

### Creating FS  #########
#sudo lsblk
#sudo file -s /dev/xvdh
#sudo mkfs -t ext4 /dev/xvdh
#sudo mkfs -f xfs /dev/xvdh
#sudo echo '/dev/xvdh /data ext4 defaults,nofail        0       0' >> /etc/fstab

USERDATA
}
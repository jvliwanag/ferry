Installation
===

This was tested on CentOS 7 running on GCE. HTTP traffic must be allowed.

1. Log in as a non-root user with `sudo` privileges.

2. Disable SELinux.

  `sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config`

3. Reboot then log back in.

  `sudo reboot`

4. Install Dependencies

  `sudo yum -y install wget git mysql`

5. Install Docker

  ```
  sudo yum -y install docker
  sudo service docker start
  sudo chkconfig docker on
  ```

6. Add user to docker group. Exit then log back in to take effect.

  ```
  sudo usermod -G docker $USER
  # Need to relogin to take effect
  exit
  # Log back in then try:
  docker ps
  ```

7. Install fig

  ```
  sudo wget -O /usr/local/bin/fig https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m`
  sudo chmod +x /usr/local/bin/fig

  # test
  fig -h
  ```

8. Check out code

  ```
  git clone https://github.com/jvliwanag/ferry.git
  cd ferry
  ```

9. Run setup. Choose a domain name when prompted (e.g. `hello.connecter.io`).

  ```
  ./setup.sh
  ```

10. Add your chosen domain name to the DNS server.

11. Open up cloud firewall ports for the server. 10000-20000 / udp.

12. Open Chrome and try visiting `http://<yourdomain>`.



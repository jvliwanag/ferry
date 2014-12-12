Installation
===

0. Install Dependencies

sudo yum install wget
sudo yum install git
sudo yum install mysql

1. Install Docker

```
sudo yum -y install docker
sudo service docker start
```

2. Add user to docker group

```
sudo usermod -G docker docker
# Need to relogin to take effect
# Once logged in try...

docker ps
```

3. Install fig

```
sudo wget -O /usr/bin/fig https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m`
sudo chmod +x /usr/bin/fig
```

4. Check out code

```
git clone https://github.com/jvliwanag/ferry.git
cd ferry
```

5. Run setup

```
./setup.sh
```

6. Add domain name to DNS

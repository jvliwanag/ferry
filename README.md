Installation
===

1. Install Docker

```
sudo yum -y install docker
sudo service start docker
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
sudo wget -O /usr/local/bin/fig https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m`
sudo chmod +x /usr/local/bin/fig
```

4. Check out code

```
git clone https://github.com/jvliwanag/ferry.git
cd ferry
```

5. Run set-up

```
./setup.sh
```

6. Add domain name to DNS

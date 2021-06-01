sleep 5
SERVER_NUMBER=$1
apt-get update > /dev/null
apt-get install containerd docker.io -y
docker run -d -p 80:5678 hashicorp/http-echo -text="SERVER-$SERVER_NUMBER Hello World"

echo `docker ps`

#curl <ip>

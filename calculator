yum install git docker -y
systemctl start docker
systemctl status docker
git clone https://github.com/anitalluri00/calculator.git
docker build -t calculator:v1 .
docker run -itd --name python-calculator -p 5000:5000 calculator:v1
docker logs python-calculator

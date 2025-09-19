dnf install java-17-amazon-corretto -y   # or java-21 if you prefer
dnf install wget unzip -y
wget https://services.gradle.org/distributions/gradle-8.10.2-bin.zip -P /tmp
unzip -d /opt/gradle /tmp/gradle-8.10.2-bin.zip
ln -s /opt/gradle/gradle-8.10.2 /opt/gradle/latest
echo 'export GRADLE_HOME=/opt/gradle/latest' | sudo tee /etc/profile.d/gradle.sh
echo 'export PATH=${GRADLE_HOME}/bin:${PATH}' | sudo tee -a /etc/profile.d/gradle.sh
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
gradle -v

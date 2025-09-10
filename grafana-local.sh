sudo apt update

sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget

sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# update 
sudo apt-get update
# install 
sudo apt-get install grafana

sudo /bin/systemctl status grafana-server
sudo /bin/systemctl start grafana-server

# sudo /bin/systemctl enable grafana-server.service

echo "Installed Succesfully"

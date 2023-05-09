#!/bin/bash

# Menjalankan ngrok sebagai background process
./ngrok authtoken 2PUyZzJ23a3GOHScEXRSNGesn40_2XkaAXK3TCspRW9yXorpP
./ngrok tcp 3389 &

# Menunggu ngrok selesai memulai
sleep 10

# Mendapatkan URL ngrok yang baru saja dibuat
NGROK_URL=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

# Menambahkan alamat URL ngrok ke file xrdp
echo "address=${NGROK_URL#tcp://}" | sudo tee /etc/xrdp/xrdp.ini > /dev/null

# Memulai ulang xrdp
service xrdp restart

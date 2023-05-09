FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
# Update package list dan install xrdp
RUN apt-get update && \
    apt-get install -y xrdp

# Install ngrok
RUN apt-get install -y wget unzip
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    rm ngrok-stable-linux-amd64.zip

# Menambahkan user baru dengan akses root
RUN useradd -m -s /bin/bash yanz && \
    echo 'yanz:sendalbututt' | chpasswd && \
    usermod -aG sudo yanz

# Menyalin script untuk menjalankan ngrok dan konfigurasi xrdp
RUN wget https://raw.githubusercontent.com/hrsnetworkdev/xrdpDocker/main/xrdp-ngrok.sh
RUN chmod +x xrdp-ngrok.sh
COPY xrdp-ngrok.sh /

# Menjalankan script untuk konfigurasi xrdp dan ngrok
CMD ["/bin/bash", "/xrdp-ngrok.sh"]

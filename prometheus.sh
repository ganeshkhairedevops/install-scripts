#!/bin/bash

PROMETHEUS_VERSION="2.51.2"

echo "Updating system and installing dependencies..."
sudo apt update -y
sudo apt install -y wget tar

echo "Creating Prometheus user..."
if ! id prometheus &>/dev/null; then
    sudo useradd --no-create-home --shell /bin/false prometheus
fi

echo "Creating Prometheus directories..."
sudo mkdir -p /etc/prometheus
sudo mkdir -p /etc/prometheus/data

echo "Downloading and extracting Prometheus..."
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
tar -xvzf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

echo "Moving Prometheus files to /etc/prometheus..."
sudo mv prometheus-${PROMETHEUS_VERSION}.linux-amd64/* /etc/prometheus/

echo "Setting ownership and permissions..."
sudo chown -R prometheus:prometheus /etc/prometheus

echo "Creating symlinks for Prometheus binaries..."
sudo ln -sf /etc/prometheus/prometheus /usr/local/bin/prometheus
sudo ln -sf /etc/prometheus/promtool /usr/local/bin/promtool

echo "Creating systemd service..."
cat <<EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Monitoring System
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \\
  --config.file=/etc/prometheus/prometheus.yml \\
  --storage.tsdb.path=/etc/prometheus/data \\
  --web.console.templates=/etc/prometheus/consoles \\
  --web.console.libraries=/etc/prometheus/console_libraries

Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "Starting Prometheus..."
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

echo "Prometheus installation completed!"
sudo systemctl status prometheus --no-pager

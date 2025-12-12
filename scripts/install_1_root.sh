# Description: Install Frappe and ERPNext on Ubuntu 25.10
# Part 1: Run as root (sudo su) or with sudo

# Update system
sudo apt-get update -y
sudo apt-get upgrade -y
sudo timedatectl set-timezone "Asia/Kolkata"

# Supervisor
sudo apt install supervisor -y

# Python (Updated for Ubuntu 25.10)
# 'distutils' is removed in newer python, so we remove it here.
# We use 'python3-dev' to pick up the default system version (likely 3.12 or 3.13)
sudo apt-get install python3-dev python3-setuptools python3-pip python3-venv -y

# Dependencies for PDF generation
sudo apt-get install xvfb libfontconfig wkhtmltopdf -y

# Redis
sudo apt-get install redis-server -y

# Database (MariaDB)
sudo apt-get install software-properties-common -y
sudo apt install mariadb-server mariadb-client -y
sudo apt-get install libmysqlclient-dev -y

# Configure MariaDB
# We use 'tee' because simple '>>' often fails with sudo permissions
sudo tee -a /etc/mysql/my.cnf > /dev/null <<EOT
[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

[mysql]
default-character-set = utf8mb4
EOT

# Restart SQL Service
sudo service mysql restart

# Secure Installation (Interactive Step)
# This will pause and ask you for inputs (Y/N, Password)
sudo mysql_secure_installation

# Description: Install Frappe and ERPNext on Ubuntu 25.10
# Part 2: Run as user 'frappe'

# 1. Load NVM (Ensure environment variables are loaded)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 2. Install Yarn
npm install -g yarn

# 3. Fix Node Path for Sudo (Important for production later)
# We get the exact path of the current node version safely
NODE_PATH=$(nvm which current)
sudo ln -sf $NODE_PATH /usr/local/bin/node
sudo ln -sf $(dirname $NODE_PATH)/npm /usr/local/bin/npm
sudo ln -sf $(dirname $NODE_PATH)/yarn /usr/local/bin/yarn

# 4. Install Frappe Bench
# on Ubuntu 25.10, we MUST use --user (no sudo)
pip3 install --user frappe-bench

# Add local bin to PATH so 'bench' command works
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# 5. Initialize Bench
cd ~
# This creates the directory 'kb_bench'.
bench init kb_bench --frappe-branch version-15

# 6. Create New Site
cd ~/kb_bench
# Note: You will be prompted for your MariaDB root password here
bench new-site pramodone --admin-password "admin"

# 7. Download Apps
bench get-app erpnext --branch version-15
bench get-app hrms --branch version-15

echo "Part 2 Complete! Site 'pramodone' is created."

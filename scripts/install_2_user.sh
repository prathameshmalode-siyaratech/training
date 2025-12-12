# Description: Install Frappe and ERPNext on Ubuntu 25.10
# Part 2: Run as user 'frappe'

# --- 1. Load NVM (Essential fix so 'npm' command works) ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# --- 2. Install Yarn ---
npm install -g yarn

# --- 3. Symlink Node (Updated to be safer) ---
# We use 'nvm which current' to get the exact path instead of 'ls' which can break
NODE_PATH=$(nvm which current)
sudo ln -sf $NODE_PATH /usr/local/bin/node
sudo ln -sf $(dirname $NODE_PATH)/npm /usr/local/bin/npm
sudo ln -sf $(dirname $NODE_PATH)/yarn /usr/local/bin/yarn

# --- 4. Install Frappe Bench (Essential Fix) ---
# 'sudo pip3' is blocked on Ubuntu 25.10. We use '--user' instead.
pip3 install --user frappe-bench

# --- 5. Fix 'bench command not found' (Essential Fix) ---
export PATH=$HOME/.local/bin:$PATH
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

# --- 6. Init bench ---
cd ~
# This creates the 'erp' folder
bench init kb_bench --frappe-branch version-15

# --- 7. Create new site ---
cd ~/kb_bench
# You will be asked for the MariaDB root password here
bench new-site pramodone

# --- 8. Install ERPNext ---
bench get-app erpnext --branch version-15

# --- 9. Install HRMS ---
bench get-app hrms --branch version-15

echo "Installation Complete!"

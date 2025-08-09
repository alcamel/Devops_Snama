# Ansible LAMP Stack Deployment

## Overview

This Ansible project provides automated deployment of a LAMP (Linux, Apache, MySQL/MariaDB, PHP) stack on target servers. The project includes two main playbooks:

1. `lamp_setup.yml` - Installs and configures a complete LAMP stack
2. `lamp_remove.yml` - Removes the LAMP stack components (uninstall)

## Requirements

- Ansible 2.9+
- Target servers running a supported Linux distribution (Ubuntu/Debian or RHEL/CentOS)
- SSH access to target servers with sudo privileges

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd ansible-lamp-deployment
   ```

2. Install Ansible if not already present:
   ```bash
   pip install ansible
   ```

## Configuration

1. Edit the `inventory.ini` file to specify your target servers:
   ```
   [webservers]
   server1.example.com
   server2.example.com
   ```

2. Modify variables in `group_vars/all.yml` as needed:
   ```yaml
   # Web Server Configuration
   apache_user: www-data
   apache_group: www-data
   
   # Database Configuration
   mysql_root_password: secure_password
   mysql_databases:
     - name: example_db
   mysql_users:
     - name: db_user
       password: user_password
       priv: "example_db.*:ALL"
   
   # PHP Configuration
   php_modules:
     - php-cli
     - php-mysql
     - php-curl
   ```

## Usage

### Deploy LAMP Stack
```bash
ansible-playbook -i inventory.ini lamp_setup.yml
```

### Remove LAMP Stack
```bash
ansible-playbook -i inventory.ini lamp_remove.yml
```

### Check Server Status
```bash
ansible webservers -i inventory.ini -m ping
```

## Playbook Details

### lamp_setup.yml
- Updates system packages
- Installs and configures Apache web server
- Installs and secures MySQL/MariaDB
- Creates specified databases and users
- Installs PHP and configured modules
- Configures firewall (if enabled)
- Verifies installation

### lamp_remove.yml
- Stops and removes Apache
- Stops and removes MySQL/MariaDB
- Removes PHP and related packages
- Cleans up configuration files
- Optionally removes databases (configurable)

## Variables

Key customizable variables are located in `group_vars/all.yml`:

- `apache_packages`: List of Apache packages to install
- `mysql_packages`: List of MySQL packages to install
- `php_modules`: List of PHP modules to install
- `firewall_settings`: Configure firewall rules
- `remove_databases`: Boolean to control database removal in lamp_remove.yml

## License

[MIT License](LICENSE)

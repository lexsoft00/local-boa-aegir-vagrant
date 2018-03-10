# -*- mode: ruby -*-
# vi: set ft=ruby :
unless Vagrant.has_plugin?("vagrant-vbguest")
  raise "The vagrant plugin vagrant-vbguest is not installed!\nFirst execute command 'vagrant plugin install vagrant-vbguest' to install the plugin."
end

unless Vagrant.has_plugin?("vagrant-hostsupdater")
  raise "The vagrant plugin vagrant-hostsupdater is not installed!\nFirst execute command 'vagrant plugin install vagrant-hostsupdater' to install the plugin."
end

unless Vagrant.has_plugin?("vagrant-auto_network")
  raise "The vagrant plugin vagrant-auto_network is not installed!\nFirst execute command 'vagrant plugin install vagrant-auto_network' to install the plugin."
end
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.

  config.vm.box = "lexsoft/boa"
  config.vm.box_version = "1.0"
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.

  config.vm.box_check_update = false
  config.vbguest.auto_update = false

  # Disables the vagrant generated key.
  # Uncomment if you only want access via user's key.

  config.ssh.insert_key = true
  config.ssh.username = "root"
  config.ssh.password = 'vagrant'


  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  config.vm.network "forwarded_port", guest: 80, host: 8088
  config.vm.network "forwarded_port", guest: 3306, host: 3308

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # Example of local ip: 192.168.44.42
  
  config.vm.network "private_network", ip: "192.168.47.47"
  # plugin https://github.com/cogitatio/vagrant-hostsupdater

  # Copy ssh key to root
  id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")
  config.vm.provision "copy ssh public key", type: "shell",
  inline: "echo \"#{id_rsa_pub}\" >> /root/.ssh/authorized_keys"
  # Run Boa Installer
  config.vm.provision 'shell', path: "scripts/install_boa_master.sh"
  # Run Xdebug Installer
  config.vm.provision 'shell', path: "scripts/install_xdebug.sh"
  # Change Memory Limit to 1024M
  config.vm.provision 'shell', path: "scripts/memory_limit.sh", run: 'always'
  # Provider-specific configuration so you can fine-tune various backing providers for Vagrant.
  config.vm.provider "virtualbox" do |vb|
    vb.name = "Aegir BOA 47.47"
    vb.memory = "3072"
    vb.cpus = 3
  end
end

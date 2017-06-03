require 'json'

VAGRANTFILE_API_VERSION ||= "2"

vagrantDir = "vagrant"
provisionDir = "provision"

defaultProvider = "virtualbox"
defaultBox = "ubuntu/trusty64"
defaultHostName= "vagrant"

# load settings
settings = JSON.parse(File.read('config.json'))  

# Set The VM Provider
ENV['VAGRANT_DEFAULT_PROVIDER'] = settings["provider"] ||= defaultProvider

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    # disable check update
    config.vm.box_check_update = false

    # Prevent TTY Errors
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # Configure The Box
    config.vm.box = settings["box"] ||= defaultBox
    config.vm.hostname = settings["hostname"] ||= defaultHostName

    # Configure A Private Network IP
    config.vm.network :private_network, ip: settings["ip"] ||= "192.168.99.99"

    # Configure Additional Networks
    if settings.has_key?("networks")
      settings["networks"].each do |network|
        config.vm.network network["type"], ip: network["ip"], bridge: network["bridge"] ||= nil
      end
    end

    # Configure A Few VirtualBox Settings
    config.vm.provider "virtualbox" do |vb|
      vb.name = settings["name"] ||= "vagrant-vm"
      vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
      vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    end

     # Standardize Ports Naming Schema
    if (settings.has_key?("ports"))
        settings["ports"].each do |port|
            port["guest"] ||= port["to"]
            port["host"] ||= port["send"]
            port["protocol"] ||= "tcp"
        end
    else
        settings["ports"] = []
    end

    # Add Custom Ports
    if settings.has_key?("ports")
      settings["ports"].each do |port|
        config.vm.network "forwarded_port", guest: port["guest"], host: port["host"], protocol: port["protocol"], auto_correct: true
      end
    end

    # Configure The Public Key For SSH Access
    if settings.include? 'authorize'
      config.vm.provision "shell" do |s|
        s.inline = "echo $1 | grep -xq \"$1\" /home/vagrant/.ssh/authorized_keys || echo $1 | tee -a /home/vagrant/.ssh/authorized_keys"
        s.args = [File.read(File.expand_path(settings["authorize"]))]
      end
    end

    # Register All Of The Configured Shared Folders
    if settings.include? 'folders'
      settings["folders"].each do |folder|
        mount_opts = []

        if (folder["writable"] == "yes")
            mount_opts = ["dmode=775","fmode=775"]
        end

        config.vm.synced_folder folder["map"], folder["to"], owner: folder["owner"], group: folder["group"], type: folder["type"] ||= nil, mount_options: mount_opts
      end
    end

    # run provisions
    if settings.include? 'provisions'
      settings["provisions"].each do |provision|
        config.vm.provision "shell" do |s|
          s.path = provisionDir + "/" + provision + ".sh"
        end
      end
    end

    #setup site vhost
    if settings.include? 'sites'
      settings["sites"].each do |site|
        config.vm.provision "shell" do |s|
          s.path = provisionDir + "/setup-vhosts.sh"
          s.args = [site["map"], site["to"], site["port"] ||= "80", site["ssl"] ||= "443"]
        end
      end
    end

    # run script after booted
    config.vm.provision "shell", path: "booted.sh"
end

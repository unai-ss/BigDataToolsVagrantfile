#
VAGRANTFILE_API_VERSION = "2"

# define hostname
NAME = "ol7-vagrant"

unless Vagrant.has_plugin?("vagrant-reload")
  puts 'Installing vagrant-reload Plugin...'
  system('vagrant plugin install vagrant-reload')
end

unless Vagrant.has_plugin?("vagrant-proxyconf")
  puts 'Installing vagrant-proxyconf Plugin...'
  system('vagrant plugin install vagrant-proxyconf')
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "Spark" do |app|
    app.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    app.vm.box_version = "17.11.24"
    app.vm.define "Spark"
    app.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.208"
    app.vm.network "private_network", ip: "172.16.1.3"
#    app.vm.synced_folder "./",  "/tmp/sync"
    app.vm.box_url = "\n"
    app.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "Spark"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    app.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        app.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        app.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        app.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    app.vm.hostname = "Spark"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 2220

    # Provision everything on the first run
    app.vm.provision "shell", path: "scripts/java_1_8.sh"
    app.vm.provision "shell", path: "scripts/installSpark.sh"
#    app.vm.provision :reload
    app.vm.provision "shell", inline: "echo 'INSTALLER Spark: Installation complete, Oracle Linux 7 ready to use!'"
  end
  config.vm.define "HBase" do |hbs|
    hbs.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    hbs.vm.box_version = "17.11.24"
    hbs.vm.define "HBase"
    hbs.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.206"
    hbs.vm.network "private_network", ip: "172.16.1.1"
#    hbs.vm.synced_folder "./",  "/tmp/sync"
    hbs.vm.box_url = "\n"
    hbs.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "HBase"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    hbs.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        hbs.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        hbs.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        hbs.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    hbs.vm.hostname = "HBase"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 222
    # Provision everything on the first run
    hbs.vm.provision "shell", path: "scripts/java_1_8.sh"
    hbs.vm.provision "shell", path: "scripts/installHBS.sh"
#    hbs.vm.provision :reload
    hbs.vm.provision "shell", inline: "echo 'INSTALLER HBS: Installation complete, Oracle Linux 7 ready to use!'"
  end

  config.vm.define "Kafka" do |kfk|
    kfk.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    kfk.vm.box_version = "17.11.24"
    kfk.vm.define "Kafka"
    kfk.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.207"
    kfk.vm.network "private_network", ip: "172.16.1.2"
#    kfk.vm.synced_folder "./",  "/tmp/sync"
    kfk.vm.box_url = "\n"
    kfk.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "Kafka"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    kfk.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        kfk.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        kfk.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        kfk.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    kfk.vm.hostname = "Kafka"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 2220

    # Provision everything on the first run
    #kfk.vm.provision "file", source: "~/github/BigDataOracleSparkHBase/jre-8u181-linux-x64.rpm", destination: "/tmp"
    #kfk.vm.provision "file", source: "./scripts/zookeeper.service", destination: "/tmp"
    kfk.vm.provision "shell", path: "scripts/java_1_8.sh"
    kfk.vm.provision "shell", path: "scripts/installKafka.sh"
    # kfk.vm.provision :reload
    kfk.vm.provision "shell", inline: "echo 'INSTALLER Kafka: Installation complete, Oracle Linux 7 ready to use!'"
  end
end

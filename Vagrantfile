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
      v.customize ["modifyvm", :id, "--memory", 256]
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
      v.customize ["modifyvm", :id, "--memory", 256]
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
      v.customize ["modifyvm", :id, "--memory", 256]
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

  config.vm.define "HDPnn" do |nn|
    nn.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    nn.vm.box_version = "17.11.24"
    nn.vm.define "HDPnn"
    nn.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.209"
    nn.vm.network "private_network", ip: "172.16.1.4"
#    nn.vm.synced_folder "./",  "/tmp/sync"
    nn.vm.box_url = "\n"
    nn.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "HDPnn"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    nn.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        nn.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        nn.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        nn.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    nn.vm.hostname = "hdpnn"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 2220

    # Provision everything on the first run
    #nn.vm.provision "file", source: "~/github/BigDataOracleSparkHBase/jre-8u181-linux-x64.rpm", destination: "/tmp"
    #nn.vm.provision "file", source: "./scripts/zookeeper.service", destination: "/tmp"
    nn.vm.provision "shell", path: "scripts/java_1_8.sh"
    nn.vm.provision "shell", path: "scripts/installHDPnn.sh"
    nn.vm.provision "shell", path: "scripts/installHBSdistributed.sh"
    nn.vm.provision "shell", path: "scripts/zookeeper.sh"
    # nn.vm.provision :reload
    nn.vm.provision "shell", inline: "echo 'INSTALLER HDPnn: Installation complete, Oracle Linux 7 ready to use!'"
  end

  config.vm.define "HDPdn1" do |dn1|
    dn1.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    dn1.vm.box_version = "17.11.24"
    dn1.vm.define "HDPdn1"
    dn1.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.210"
    dn1.vm.network "private_network", ip: "172.16.1.5"
#    dn1.vm.synced_folder "./",  "/tmp/sync"
    dn1.vm.box_url = "\n"
    dn1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "HDPdn1"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    dn1.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        dn1.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        dn1.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        dn1.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    dn1.vm.hostname = "hdpdn1"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 2220

    # Provision everything on the first run
    #dn1.vm.provision "file", source: "~/github/BigDataOracleSparkHBase/jre-8u181-linux-x64.rpm", destination: "/tmp"
    #dn1.vm.provision "file", source: "./scripts/zookeeper.service", destination: "/tmp"
    dn1.vm.provision "shell", path: "scripts/java_1_8.sh"
    dn1.vm.provision "shell", path: "scripts/installHDPdn1.sh"
    dn1.vm.provision "shell", path: "scripts/installHBSdistributed.sh"
    dn1.vm.provision "shell", path: "scripts/zookeeper.sh"
    # dn1.vm.provision :reload
    dn1.vm.provision "shell", inline: "echo 'INSTALLER HDPdn1: Installation complete, Oracle Linux 7 ready to use!'"
  end

  config.vm.define "HDPdn2" do |dn2|
    dn2.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    dn2.vm.box_version = "17.11.24"
    dn2.vm.define "HDPdn2"
    dn2.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.211"
    dn2.vm.network "private_network", ip: "172.16.1.6"
  #    dn2.vm.synced_folder "./",  "/tmp/sync"
    dn2.vm.box_url = "\n"
    dn2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "HDPdn2"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    dn2.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        dn2.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        dn2.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        dn2.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    dn2.vm.hostname = "hdpdn2"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 2220

    # Provision everything on the first run
    #dn2.vm.provision "file", source: "~/github/BigDataOracleSparkHBase/jre-8u181-linux-x64.rpm", destination: "/tmp"
    #dn2.vm.provision "file", source: "./scripts/zookeeper.service", destination: "/tmp"
    dn2.vm.provision "shell", path: "scripts/java_1_8.sh"
    dn2.vm.provision "shell", path: "scripts/installHDPdn2.sh"
    dn2.vm.provision "shell", path: "scripts/installHBSdistributed.sh"
    dn2.vm.provision "shell", path: "scripts/zookeeper.sh"
    # dn2.vm.provision :reload
    dn2.vm.provision "shell", inline: "echo 'INSTALLER HDPdn2: Installation complete, Oracle Linux 7 ready to use!'"
  end
  config.vm.define "keycloack" do |keycloack|
    keycloack.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    keycloack.vm.box_version = "17.11.24"
    keycloack.vm.define "HDPkeycloack"
    keycloack.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.212"
    keycloack.vm.network "private_network", ip: "172.16.1.7"
  #    keycloack.vm.synced_folder "./",  "/tmp/sync"
    keycloack.vm.box_url = "\n"
    keycloack.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "HDPkeycloack"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    keycloack.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        keycloack.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        keycloack.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        keycloack.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    keycloack.vm.hostname = "hdpkeycloack"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 2220

    # Provision everything on the first run
    #keycloack.vm.provision "file", source: "~/github/BigDataOracleSparkHBase/jre-8u181-linux-x64.rpm", destination: "/tmp"
    #keycloack.vm.provision "file", source: "./scripts/zookeeper.service", destination: "/tmp"
    keycloack.vm.provision "shell", path: "scripts/java_1_8.sh"
    keycloack.vm.provision "shell", path: "scripts/installHDPKeycloack.sh"
    # keycloack.vm.provision :reload
    keycloack.vm.provision "shell", inline: "echo 'INSTALLER freeipa: Installation complete, Oracle Linux 7 ready to use!'"
  end
  config.vm.define "freeipa" do |freeipa|
    freeipa.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    freeipa.vm.box_version = "17.11.24"
    freeipa.vm.define "freeipa"
    freeipa.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.213"
    freeipa.vm.network "private_network", ip: "172.16.1.8"
  #    freeipa.vm.synced_folder "./",  "/tmp/sync"
    freeipa.vm.box_url = "\n"
    freeipa.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "freeipa"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    freeipa.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        freeipa.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        freeipa.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        freeipa.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    freeipa.vm.hostname = "freeipa"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 2220

    # Provision everything on the first run
    #freeipa.vm.provision "file", source: "~/github/BigDataOracleSparkHBase/jre-8u181-linux-x64.rpm", destination: "/tmp"
    #freeipa.vm.provision "file", source: "./scripts/zookeeper.service", destination: "/tmp"
#    freeipa.vm.provision "shell", path: "scripts/java_1_8.sh"
    freeipa.vm.provision "shell", path: "scripts/installHDPfreeipa.sh"
    # freeipa.vm.provision :reload
    freeipa.vm.provision "shell", inline: "echo 'INSTALLER freeipa: Installation complete, Oracle Linux 7 ready to use!'"
  end

  config.vm.define "hbaseDistr" do |hbaseDistr|
    hbaseDistr.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    hbaseDistr.vm.box_version = "17.11.24"
    hbaseDistr.vm.define "hbaseDistr"
    hbaseDistr.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.214"
    hbaseDistr.vm.network "private_network", ip: "172.16.1.9"
  #    hbaseDistr.vm.synced_folder "./",  "/tmp/sync"
    hbaseDistr.vm.box_url = "\n"
    hbaseDistr.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "hbaseDistr"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    hbaseDistr.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        hbaseDistr.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        hbaseDistr.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        hbaseDistr.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    hbaseDistr.vm.hostname = "hbaseDistr"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 2220

    # Provision everything on the first run
    #hbaseDistr.vm.provision "file", source: "~/github/BigDataOracleSparkHBase/jre-8u181-linux-x64.rpm", destination: "/tmp"
    #hbaseDistr.vm.provision "file", source: "./scripts/zookeeper.service", destination: "/tmp"
    hbaseDistr.vm.provision "shell", path: "scripts/java_1_8.sh"
    hbaseDistr.vm.provision "shell", path: "scripts/instalHadoopStandalone.sh"
    #hbaseDistr.vm.provision "shell", path: "scripts/installHBSdistributed.sh"
    #hbaseDistr.vm.provision "shell", path: "scripts/zookeeperstandalone.sh"
    #hbaseDistr.vm.provision "shell", path: "scripts/geomesa.sh"
    hbaseDistr.vm.provision "shell", inline: "echo 'INSTALLER hbaseDistr: Installation complete, Oracle Linux 7 ready to use!'"
  end
end

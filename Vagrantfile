# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :otusWeb => {
        :box_name => "centos/7",
        :ip_addr => '192.168.11.150'
  },
  :otusLog => {
        :box_name => "centos/7",
        :ip_addr => '192.168.11.151'
  }
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

      config.vm.define boxname do |box|

          box.vm.box = boxconfig[:box_name]
          box.vm.host_name = boxname.to_s

          box.vm.network "private_network", ip: boxconfig[:ip_addr]

          case boxname.to_s
            when "otusLog"
              config.vm.network "forwarded_port", guest: 5601, host: 5601
              config.vm.network "forwarded_port", guest: 5044, host: 5044
          end

          box.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "4096"]
          end
          
          box.vm.provision "shell", inline: <<-SHELL
            mkdir -p ~root/.ssh
            cp ~vagrant/.ssh/auth* ~root/.ssh
          SHELL

          case boxname.to_s
            when "otusWeb"
              box.vm.provision "shell", inline: <<-SHELL
                yum install epel-release -y
                yum install nginx -y
                systemctl start nginx
          SHELL

            when "otusLog"
              box.vm.provision "shell", path: "elasticsearch-provision.sh"
              box.vm.provision "shell", path: "kibana-provision.sh"
            end
      end
  end
end	

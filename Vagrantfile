Vagrant.configure("2") do |config|
    
    config.vm.box = "slavrd/xenial64"
    
    # set VM specs
    config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
  
    config.vm.provision :shell, :path => "scripts/provision.sh"
  
  end
  
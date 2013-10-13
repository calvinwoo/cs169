Setting up SSH:


1. Select your vm inside VirtualBox Manager.
2. Settings > Network > Port Forwarding 

3. add a new rule with "name => ssh, protocol => TCP, Host Port => 3022, Guest Port => 22", and everything else BLANK.
4. INSIDE your vm, install the ssh server with "sudo apt-get install openssh-server"
5. SSH Command: ssh -p 3022 saasbook@127.0.0.1
6. If you didn't change, the password is "saasbook".


Setting up files mounting:


1. install Homebrew(http://brew.sh), if you haven't.
2. brew install sshfs
3. follow the instruction from "brew info fuse4x-kext"
4. Mount Command: sshfs -p 3022 saasbook@127.0.0.1:path/you/want local/path/you/want
5. If you didn't change, the password is "saasbook".

***************
In addition to the SSH and Mount introduced above, we could also port forward web request from host to the vm, so the result would be: running rails server inside vm, and accessing the server from a browser in host.

 

Request forward:

1. Select your vm inside VirtualBox Manager.

2. Settings > Network > Port Forwarding 

3. add a new rule with "name => rails, protocol => TCP, Host Port => 3021, Guest Port => 3000", and everything else BLANK.

4. Start web server inside vm, and access it with url http://localhost:3021 from host.

 

*5 the "Guest Port" should be the same port used by the web server, by default it is 3000. If the web server runs on other port (say 2999), then Guest Port should be 2999.

 

*6 the port in the url should be the "Host Port", please use a port not occupied by other process in the host env.

 

*7 you will find the speed is very SLOW if using webrick (command "rails server"), the solution is: in the vm, in the file: /home/saasbook/.rvm/rubies/ruby-1.9.3-p448/lib/ruby/1.9.1/webrick/config.rb , change ":DoNotReverseLookup => nil" to ":DoNotReverseLookup => true". By doing so we stop one of webrick's default behavior, which is reverse DNS lookup for every web request. It is very slow if server is remote or vm.


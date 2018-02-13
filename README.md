## Before Installing
1. Read the Basic Steps bellow.
2. Have a ssh key into your home directory. Boa Installer is going to change the root password and remove all access, you need a ssh key to get into the server after install.
3. Change the email 'hostmaster@aegir.local' in scripts/install_boa_master.sh file to your email.
```
boa in-stable local hostmaster@aegir.local mini
``` 
## To Start the installer
```
vagrant up
``` 
## After the installer finish 
Copy the link with the reset password into your browser and reset the password. If you forget, you can have it resend to the email from the scripts/install_boa_master.sh file

Loggin to the server with
```
ssh root@192.168.46.46
...
and run barracuda up-stable 

``` 
You should receve an email with the o1 details including ftp logging. If you did not get the email you need to reset the o1.ftp user password. Logging as root and reset the password with the command:
```
passwd o1.ftp
``` 
You can then log into the server using o1.ftp and copy the ssh key to the ~/.ssh/authorized_keys.
Don't forget to change permissions of the .ssh folder and file after inserting the ssh key.
```
chmod 600 ~/.ssh/authorized_keys and chmod 700 ~/.ssh
``` 
Check out **[Quick Start](https://www.drupal.org/project/quick_start)** Distribution, works really good with Aegir Hosting.

## Basic steps
1. Read all the instructions here before starting.
2. Do follow instructions from Docs: **[Installing BOA locally](https://github.com/omega8cc/boa/blob/master/docs/INSTALL.txt#L86)**. Do not try other options. I did it and I regret it! If you want to use the _same octopus name_ with the live server be careful here as you have to us this name on the installation commands.
3. Run installer only with **up-stable** option. Hope you have the same option on the live server (if you need synchronized servers). Eg `boa in-stable local my@email`.
4. Use **[Debian 8 Jessie 64x](https://atlas.hashicorp.com/debian/boxes/jessie64)** vagrant box (see the latest BOA Recommended). This must be as more as it can be a vanilla box. No ruby, no puppet, completely vanilla. Do not run updates on `vagrant up`.
5. Use at least 2GB RAM for the vm.
6. Important. SSH user must be **root** after installing BOA! If you use default user **vagrant** you may have errors because BOA does not allow other users to access folders such as /tmp. These folders are used when you run `vagrant up`. So initially run `vagrant up` as user vagrant (default). Login into the vm and change the root password. 
7. Do NOT use [Vagrant Synced folders](http://docs.vagrantup.com/v2/synced-folders/basic_usage.html). You could use **nfs** with **vagrant-bindfs** so you can change owner/permissions but I recommend you to not sync files at all with Vagrant. You may have a too many problems with permissions and owner of folders. Use **sftp** instead. If you insist to use nfs you should only sync the folders of /modules, /themes, /libraries of each project and not the folders of group www-data.
8. Add the BOA entries to your **hosts** file (eg for Debian, /etc/hosts). You may also use a vagrant plugin like https://github.com/cogitatio/vagrant-hostsupdater to do this automatically.
```
# Local BOA running on host ip 192.168.46.46
192.168.46.46 aegir.local
192.168.46.46 sub.aegir.local
192.168.46.46 o1.sub.aegir.local
192.168.46.46 chive.aegir.local
```
## Optional steps
1. Disable **changing passwords** after every update. See how to at https://github.com/omega8cc/boa/blob/master/docs/ctrl/system.ctrl.
2. Disable [CSF (firewall)](https://github.com/omega8cc/boa/blob/master/docs/NOTES.txt) from [.barracuda.cnf _XTRAS_LIST](https://github.com/omega8cc/boa/blob/master/docs/cnf/barracuda.cnf#L28) if exists there. It will not be enabled by default.
3. **Disable backups** on all of your local Aegir Octopus user-accounts and websites. Default vm size is 40GB and you may run out of space.
4. Change local BOA timezone (eg using command `tzselect` or `dpkg-reconfigure tzdata` as root) so local server reports match your local time.

## Common Issues
1) **DNS after System Updates/Upgrades**.

After system updates/upgrades local BOA may loose the DNS settings for Aegir master as also as for the additional software. If you have errors like:

```
BOA [09:10:40] ==> UPGRADE A: FATAL ERROR: DNS looks broken for aegir.local
BOA [09:10:40] ==> UPGRADE A: FATAL ERROR: Aborting AegirSetupA installer NOW!
```
or
```
BOA [09:11:44] ==> ERROR: o1.sub.aegir.local doesn't point to your IP: 127.0.1.1
BOA [09:11:44] ==> Please make sure you have a valid A record in your DNS
BOA [09:11:44] ==> It is also possible that DNS change didn't propagate yet
```

add a DNS entry at the BOA **/etc/hosts** file (assuming you use a Debian vagrant box):

```
127.0.1.1 aegir.local o1.sub.aegir.local chive.aegir.local
```

2) **403 error on Chive domain** (https://chive.aegir.local)

If you get an access denied error (403) while trying to access Chive domain on local BOA you may need to alter the **chive vhost configuration file** at ```/var/aegir/config/server_master/nginx/vhost.d/chive.aegir.local``` and add an ```allow all;``` entry.
Notice that in order to access Chive you must be logged into the local BOA with ssh otherwise you will get a 403 error anyway (See more at https://omega8.cc/how-to-use-chive-manager-323).



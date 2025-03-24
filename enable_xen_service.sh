sudo /etc/init.d/xencommons start    
sudo /etc/init.d/xendomains start    
sudo /etc/init.d/xen-watchdog start    
sudo /etc/init.d/xendriverdomain start

awk '/menuentry/ && /class/ {count++; print count-1"****"$0 }'      /boot/grub/grub.cfg | grep -i "Xen"

# update grub with the apropriate index (in my case 3)
sudo sed -i 's/GRUB_DEFAULT=[0-11]/GRUB_DEFAULT=3/' /etc/default/grub
sudo update-grub

sudo reboot

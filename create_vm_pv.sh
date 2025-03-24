export vm_name='basevm'
export nic='eno1'
export root='/tmp'
export path='VMs'
export disk_size=10720
export mac='aa:00:00:00:00:14'

vm_number=$(ls -l $path | wc -l)

if [ $vm_number -gt 1 ]
then	
    rm $HOME/$path/"${vm_name}.img"
fi
#brctl addbr xenbr0
#brctl addif xenbr0 $nic
#dhclient xenbr0
#ifconfig $nic 0.0.0.0

cd $root/$path

dd if=/dev/zero of=$root/$path/"${vm_name}.img" bs=1M count=$disk_size

wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/xen/initrd.gz
wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/xen/vmlinuz

echo "
kernel=\"$root/$path/vmlinuz\"
ramdisk=\"$root/$path/initrd.gz\"
memory=\"2048\"
vcpus=1
name=\"$vm_name\"
disk=[ 'file: $root/$path/$vm_name.img,ioemu:hda,w' ]
vif=[ 'bridge=xenbr0,mac=$mac' ]
">"${vm_name}.cfg"

xl create -c "${vm_name}.cfg"

echo "
memory="2048"
vcpus=1
name=\"$vm_name\"
disk=[ 'file: $root/$path/$vm_name.img,ioemu:hda,w' ]
vif=[ 'bridge=xenbr0,mac=$mac' ]
bootloader=\"/usr/local/bin/pygrub\"
">"${vm_name}.cfg"

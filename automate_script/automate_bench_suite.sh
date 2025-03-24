#! /bin/bash

# Step 1
# Check the ip address in the file mac_ip_address file
# Or from the front-end, run
#g5k-subnets -im >> mac_ip_address 

# This will get all ip and mac address available for the subnets and for each VMs

# Step 2
# copy mac_ip_address in the working directory (/tmp/VMs_without_mba/automate_script). 

# Get the number of vm you need to run

# Show script help
show_help() {
    echo "Usage : $0 [options]"
    echo "Setup base environment for benchmarks app"
    echo "Options :"
    echo "  -b, --background_VMs    <value>    Defines the number of background VMs that should be running"
    echo "  -c, --host_cpu_load     <value>    Defines the host CPU saturation or usage before launching the target app"
    echo "  -m, --host_memory_load  <value>    Defines the host memory load or usage before launching the target app"
    echo "  -h, --help                         Show this help message and exit"
    exit 0
}



# Arguments

# Define expected options
OPTS=$(getopt -o "b:c:m:h" -l "background_VMs:,host_cpu_load:,host_memory_load:,help" -- "$@")
if [ $? != 0 ]; then
    echo "Erreur lors de l'analyse des options" >&2
    exit 1
fi

# Initialize default values
background_VMs=5
host_cpu_load=2
host_memory_load=4096


# Browse options
eval set -- "$OPTS"
while true; do
    case "$1" in
        -b|--background_VMs)
            background_VMs="$2"
            shift 2
            ;;
        -c|--host_cpu_load)
            host_cpu_load="$2"
            shift 2
            ;;
         -m|--host_memory_load)
            host_memory_load="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            ;;
        --)
            shift
            break
            ;;
    esac
done

# background_VMs=$1
# background_VMs=$((background_VMs))
# host_cpu_load=$2
# host_memory_load=$3

# Configure the network bridge so that the default interface can be used as a virtual switch.
./setup_network_interface_host.sh



# Install ansible and configure the inventory file that will contain the IP address of each guest VM in the hosts.yml file.

./setup_inventory_ansible.sh $background_VMs 

# Generate an ssh key to connect to virtual machines via ssh. Do not give a password during the generation process.

ssh-keygen

# Lauch the VMs


./launch_multiple_vm.sh $background_VMs $host_cpu_load $host_memory_load

# Get the number of VMs running, as some VMs may not start.

number_running_vms=$(xl list | awk 'NR > 2 {print $1}'| wc -l)
number_running_vms=$(($number_running_vms))

#number_running_vms=$((xl list | awk 'NR > 2 {print $1}'))

# Launch VMs that have not yet been launched
base_vm_name=basevm
vm_conf_dir=vm
launched_vm_list_file=launched_vm

xl list | awk 'NR > 2 {print $1}' > $launched_vm_list_file

#number_running_vms=$((number_running_vms-1))

while [ "$number_running_vms" -lt "$background_VMs" ]; 
do

    for((i=1;i<=background_VMs;i++)); 
    do

        if grep -q $base_vm_name$i $launched_vm_list_file; 
        then

            #xl create $vm_conf_dir/$base_vm_name$i.cfg
            continue

            else
                xl create $vm_conf_dir/$base_vm_name$i.cfg

        fi
    done

    number_running_vms=$(xl list | awk 'NR > 2 {print $1}'| wc -l)
    number_running_vms=$(($number_running_vms))
    echo $number_running_vms
    
    xl list | awk 'NR > 2 {print $1}' > $launched_vm_list_file


done

# Copy host ssh key to each VM. 
./copie_host_ssh_to_vms.sh $background_VMs



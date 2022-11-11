# Active Directory Lab

The lab environment was hosted entirely on QEMU/KVM and included two Windows Server virtual machines acting as domain controllers and DHCP/DNS servers. The virtual machines are connected via a virtual switch with a pfSense virtual machine acting as a firewall and a router to connect to other potential networks.

I have one primary domain controller with another domain controller set up and replicated for redundancy.

There is a Windows 10 Pro virtual machine that is connected to the domain and has its user account and computer configured in Active Directory in addition to a Red Hat Enterprise Linux virtual machine that is connected to the domain through SSSD.

There are two PowerShell scripts included in this repo:
 - The UserManagement script can create new users, edit the names and passwords of currently existing users, add users to groups, print the attributes of a specific user, and delete users.
 - The GroupManagement script can create new groups with specific group scopes, print the attributes of a group, edit the name of groups, and delete groups.

## Setup

In virt-manager, I configured the Windows Server machines to have 2048 MB of memory allocated, two CPU cores allotted, and 80 GB of storage. The Windows 10 Pro virtual machine has 4096 MB of memory allocated, two CPU cores allotted, and 60 GB of storage. The pfSense firewall has 1024 MB of memory allocated, 1 CPU core allotted, and 20 GB of storage. The Red Hat Enterprise Linux virtual machine has 1536 MB of memory allocated, two CPU cores allotted, and 40 GB of storage.

I have configured two virtual switches with one virtual switch acting as the LAN network and the other virtual switch acting as the WAN network. The Windows server, Windows 10 Pro, and Red Hat Enterprise Linux virtual machines are connected only to the LAN network while the pfSense firewall is connected to both the LAN and WAN networks. This was done to allow connectivity to the WAN from the LAN. I plan on expanding this lab further in the future with additional domains in the WAN.

I added DHCP, DNS, and Active Directory as roles to my primary domain controller and configured static IP addresses for my secondary domain controller and the pfSense firewall. In addition, I also assigned the pfSense IP address as the default gateway to allow connectivity to the WAN. I was able to confirm this by successfully pinging a virtual machine connected to the WAN. The Windows 10 Pro and Red Hat Enterprise Linux virtual machines have IP addresses that are automatically assigned through DHCP.

## PowerShell scripting

I wrote the PowerShell scripts to gain a deeper understanding of PowerShell itself and automation through scripting. I am now able to create new users and groups as well as edit some basic properties through the use of my scripts. 

I implemented a rudimentary menu system to make the user interface more friendly to use. In the future, I plan on having option parameters in my menu function to increase the reusability of the code.

## Obstacles

- I encountered an obstacle when trying to install pfSense on a UEFI-based virtual machine. Automatic partitioning did not work initially when I tried to install pfSense. To solve this, I configured the virtual machine to use BIOS instead of UEFI.
- I encountered another obstacle when attempting to ping from the LAN to the WAN only on my Red Hat Enterprise Linux virtual machine. I was also unable to ping the firewall. To solve this, I had to reinstall Red Hat Enterprise Linux. 

## Lessons learned

I am now able to emulate an enterprise network with a primary domain controller and an additional replicated domain controller for redundancy through the use of QEMU/KVM. I also learned more about how to use PowerShell for the automation and management of Active Directory objects.
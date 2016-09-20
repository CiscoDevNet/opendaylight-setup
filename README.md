# Opendaylight-Setup
## Intro
This directory contains setup scripts for ODL, and is particularly designed to be work with [Cisco dCloud](https://dcloud.cisco.com).  The goal of this repository is to provide handy scripts and detailed guide for the attendees of ODL Summit 2016 BGPCEP Tutorial.

This project is forked from [CiscoDevNet](https://github.com/CiscoDevNet/opendaylight-setup).  However, some files are removed for demo purpose.

## BGP / PCEP Tutorial for ODL Summit 2016

To check the guide for BGP / PCEP Tutorial, you can browse the [tutorial directory](./docs/tutorial).  The tutorial are written with Markdown.  You can read the tutorials on GitHub directly, or open the markdown files locally with a Markdown reader.

## Vagrant
 
The repository also contains a subdirectory *vagrant* which contains a `Vagrantfile` and `bootstrap.sh` script.  Please read the [vagrant section](./docs/tutorial/prepare-vm.md#vagrant_vm) to learn more about it.

If you have [Vagrant](https://www.vagrantup.com/downloads.html) and VirtualBox or VMWare Workstation/Fusion installed you can do a "vagrant up" from that directory and a VirtualBox VM will be created consisting of:

* Ubuntu 14.04
* git
* vim
* wireshark
* all other required software mentioned above
* this repository

> **NOTE** The Vagrantfile is currently configured to allocate 2 vCPUs and 4GB of RAM to the VM.   If your machine only has 4GB of RAM then you may wish to allocate 2GB of RAM.  Likewise if you only have 2 CPU cores you may wish to allocate 1 vCPU.   Equally if you want to use a different hypervisor you will need to edit the Vagrantfile.

## Scripts Included

**config-odl** sets up logging/features for ODL

**download-odl** download ODL distro file from OpenDayLight office site.  If the distro file is already downloaded, it will skip

**unpack-odl** unpacks the .tar.gz file.  Creates a new subdirectory for the ODL distro.

**setup-odl** automatically install release ODL distro. It's a combination of *download-odl* and *unpack-odl*

**start-vpn** connects to dCloud VPN.  Takes *vpn\_crendential* to read required credential.  

**stop-vpn** disconnects from dCloud VPN

**start-odl** cleans out data from previous runs and starts ODL

**stop-odl** stops ODL

**delete-odl** deletes the ODL distribution; it will stop the ODL if it is running

**tail-log** shortcut to access karaf log

**check-vpn-status** check VPN status

**karaf-client** shortcut to access karaf console

## Additional Files

**parameters** parameters - encoded as environment vars:

* DISTRO (name of ODL distribution)
* ODL_USER
* ODL_PASS
* FEATURES (list of features to add to ODL's default set)

**log4j.conf** log4j configuration, used to override ODL's default log4j config

**nodes** list of router nodes exist in dCloud (each line consists of a node name which indicating site name and node IP address)

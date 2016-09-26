# Prepare Your Controller

This guide will is created to help you prepare a Linux environment that is ODL and tutorial ready.

## Setup Controller VM

There are several options for creating the Controller VM. Please pick
the one which is best suited for your environment

  
| Option | Pre-requisites | Pros | Cons |
|--------------------------------------|--------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| [Preconfigured VM from USB stick](#use-preconfigured-vm-from-usb-stick) | Hypervisor (e.g. Virtual Box) installed on your laptop | Controller and setup scripts are installed on this VM, so once you import and start the VM, you are good to go | <ul><li> USB stick availability </li><li> May take time to copy VM image from USB stick to laptop </li><li> Need free resources on laptop to start new VM </li></ul> |
| [Vagrant to launch preconfigured VM](#use-vagrant-to-launch-pre-configured-vm) | Vagrant and Hypervisor (e.g. Virtual Box) installed on your laptop | If you have the pre-requisites and are familiar,with using Vagrant, this option provides an easy way to get the Controller VM,ready | <ul><li>vagrant up may take time to download/config the VM and Controller </li><li> Need free resources on laptop to start new VM </li></ul> |
| [Vanilla VM with manual configuration](#use-any-vanilla-vm-and-configure-manually) | Access to any recent version of Ubuntu or CentOS VM | Don’t need to spin-up a new VM, so no additional resources needed on laptop | <ul><li>May take time to download/config the VM and Controller </li><li> Environment may be different than reference VM causing some issues </li></ul> |

### <a name="use-preconfigured-vm-from-usb-stick">Use preconfigured VM from USB stick</a>

1.  If you are physically attending the ODL Summit 2016 - BGPCEP tutorial session, a USB stick with preconfigured VM image are available. Please get it from one of the instructors or ask around

2.  Mount the USB stick and copy the preconfigured VM image **ODLSummit.ova**

3.  Once the copy is done, unmount the stick and pass it around to
    others who need it

	> **Note** The USB sticks are limited in number – so once you are done
	> copying the image to your laptop, PLEASE pass them around. If no one
	> near you seems to be wanting it, please give it to one of the
	> instructors so that we can give it to people in different part of room
	> or those who may come late. Thanks for your co-operation!

1.  Copy the VM image to a local folder

2.  Import the image in [Virtual Box](https://www.virtualbox.org/wiki/Downloads) or [VMWare Player](https://www.vmware.com/products/player/playerpro-evaluation.html) (recommended)

	 > The VM image is exported from VMWare Fusion, so there are may be some settings not compatible with Virtual Box.  Double check your VM setting before you start it.

3.  Boot-up the imported VM and login into it using below credentials:

    Username: `odlsummit`

    Password: `odlsummit`

4.  This repository has already been cloned to `~/ODL` directory in the VM. A shortcut is created on the desktop as well.

5.  Update the `~/ODL` following the [guide here](#pull-the-latest-tutorial-guide).

6.  Open `~/ODL` folder in terminal and unpack ODL distribution with command `bin/unpack-odl beryllium`.

	> **Optionally** You can use Boron version with command `bin/unpack-odl boron` if you want to test Boron.  In the tutorial, we are mainly playing with Beryllium. 
	
### <a name="use-vagrant-to-launch-pre-configured-vm">Use Vagrant to launch pre-configured VM</a>

1.  This method requires [Vagrant](https://www.vagrantup.com/downloads.html) and [Virtual Box](https://www.virtualbox.org/wiki/Downloads) to be pre-installed on your laptop. Install them if you don’t have them already

2.  Copy *vagrant* folder from [this repository](../../vagrant) to a local folder on your laptop

3.  Open a terminal and cd to the local folder directory

4.  Execute `vagrant up` command which will create a new VM under Virtual Box and run basic configuration commands on it.  A Ubuntu 14.04 will be spinned up by default.

5.  Connect to the VM using `vagrant ssh` command, or use the GUI directly.

4.  This repository has already been cloned to *~/ODL* directory in the VM. A shortcut is created on the desktop as well.

7.  You will need to install Postman on your VM following the guide [here](./config-postman.md).

### <a name="use-any-vanilla-vm-and-configure-manually">Use any vanilla VM and configure manually</a>

1.  You need to prepare a Linux VM to host the ODL Controller.  **NOTE** The script provided by this repository are tested on **Ubuntu 14.04/16.04**.  It is not guaranteed that it will also works well on other distribution of Linux.
   
    > * If you do not want to use Ubuntu, remember ODL **may or may not** work properly with other versions of operating system, so try them at your own risk.
    
    > * Minimum specs are 2 CPU cores, 4 GB RAM and 20 GB of free
    disk space

2.  Login to your VM and install git package using appropriate commands
    for your platform

    For Ubuntu, use:

    `sudo apt-get install git`

3.  Clone this repository to your workspace with command
    `git clone https://github.com/kevinxw/opendaylight-setup ODL`
    
4.  Switch to the repository directory with command `cd ODL`.

4.  Set up the environment with script `bin/setup-env`.

	> **NOTE** The script is using `apt-get` to install packages, so you will need to tweak the script if you are using CentOS VM.
    
5.  Run script `bin/download-distro beryllium` to fetch the Beryllium SR3, which will be used for this tutorial.
	
	> If you are physically attending the tutorial, you should be able to find the distribution package in the provided USB stick.  You can copy them to your VM directly in case the downloading speed is not ideal.
	
	> There will be one **beryllium.tar.gz** and one **boron.tar.gz** file in the USB stick.  Copy both of them to the `distro-image` directory under the repository which you just cloned.  If there is no `distro-image` directory, you can create one with command `mkdir distro-image`
	
	> By copying the distro image from USB stick directly, you do not need to run `bin/download-distro` anymore.
	
	> Optionally, you can run `bin/download-distro boron` in order to test Boron release.  But only one ODL release can be unpacked at one time.
	
6.  After the ODL distro is downloaded, you will need to run command `bin/unpack-odl beryllium` to unpack the ODL to `distribution` folder.

	> Optionally, you can run `bin/unpack-odl boron` if you have downloaded ODL Boron release instead.

7.  You will need to install Postman on your VM following the guide [here](./config-postman.md).

## <a name="#pull-the-latest-tutorial-guide">Pull The Latest Tutorial Guide</a>

Before starting the tutorial, it is recommended pull the latest scrpits and docs from GitHub.
	
Go to the repository directory (if you are using provided VM or VM spinned up with Vagrant, the repository is cloned to `~/ODL`) and do a `git pull` to pull the latest scripts.

You will also want to re-import the Postman collection following the guide [here](./config-postman.md).

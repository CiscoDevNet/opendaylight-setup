# opendaylight-setup
This directory contains setup scripts for ODL.

Start with a Linux host or VM with git installed (at a minimum).  Ubuntu 14.04 is recommended.  You can also choose to use other version of Linux if you wish.
However, you may want to turn a few scripts such as bin/setup-env to make them work on your version of Linux.

Installation Instructions:

1.  Clone this repo:

  git clone https://github.com/kevinxw/opendaylight-setup.git ODL

2.  Download the appropriate OpenDaylight distribution file (.tar.gz) from https://www.opendaylight.org/downloads (or other location) to images directory:

  Example: (Assumes you are downloading the "Beryllium-SR3" release.)

  wget -P images https://nexus.opendaylight.org/content/repositories/public/org/opendaylight/integration/distribution-karaf/0.4.3-Beryllium-SR3/distribution-karaf-0.4.3-Beryllium-SR3.tar.gz

    Optionally, you can use the script provided to download default ODL version:

    * to download the latest release version (recommended):
    bin/download_distro release

    * to download the lastest snapshot version:
    bin/download_distro snapshot

3.  Unpack ODL using

  bin/unpack-odl

  NOTICE You should only have one distribution image under images directory before doing this step.

4.  Optionally edit the parameters file to change the set of features installed at ODL startup.

5.  Optionally edit the log4j.conf file to change the set of additional logging activated at ODL startup.
 
6.  Set up ODL using (this loads key features and logging configs)

  bin/setup-odl

  You want to do this step everytime you changed the ODL settings in step 4 and step 5
   
7. Change vpn\_credential file to reflect your dCloud credential
	
	* site is one of rtp, lon, sng or chi
	* username and password can be found in your dCloud session details

	(note that your unix account will need sudo privileges)

  Then run bin/start\_vpn to start the VPN session

13. Start ODL using

  bin/start-odl

14.  You can use bin/check\_vpn\_status to get the VPN tunnel interface information. Use the IP of the tunnel to configure your router.
  After connecting to VPN, you can reach the router by using the command

  source ./parameters && telnet $BGP\_PEER

  You can find a list of all other routers avaiable in the nodes file

## Vagrant
 
The repository also contains a subdirectory "vagrant" which contains a Vagrantfile and bootstrap.sh script.

If you have Vagrant and VirtualBox or VMWare Workstation/Fusion installed you can do a "vagrant up" from that directory and a VirtualBox VM will be created consisting of:

* Ubuntu 14.04
* git
* zip
* openconnect
* java 8 (JRE only)
* this repository

Note that the Vagrantfile is currently configured to allocate 2 vCPUs and 8GB of RAM to the VM.   If your machine only has 8GB of RAM then you may wish to allocate 4GB of RAM.  Likewise if you only have 2 CPU cores you may wish to allocate 1 vCPU.   Equally if you want to use a different hypervisor you will need to edit the Vagrantfile.

### Scripts are:

**unpack-odl** unpacks the .tar.gz file.  Creates a new subdirectory for the ODL distro.

**setup-odl** sets up logging/features for ODL

**start-vpn** connects to dCloud VPN.  Takes vpn\_crendential to read required credential.  

**stop-vpn** disconnects from dCloud VPN

**start-odl** cleans out data from previous runs and starts ODL

**stop-odl** stops ODL

**config-odl** sets up NETCONF nodes, BGP etc. - uses scripts from the python subdirectory (plus in the dCloud case REST calls to dCloud APIs)

**delete-odl** deletes the ODL distribution

### Additional files are:

**parameters** parameters - encoded as environment vars:

* DISTRO (name of ODL distribution)
* BGP_PEER (IP address of BGP peer)
* BGP_NODE (NETCONF name of BGP peer)
* BGP\_NEXT_HOP (next-hop from BGP peer towards ODL)
* LOCAL_AS
* REMOTE_AS
* ODL_USER
* ODL_PASS
* NETCONF_PORT
* NETCONF_USER
* NETCONF_PASS
* DCLOUD (YES or NO)
* FEATURES (list of features to add to ODL's default set)

**logs** extra logs to activate

**nodes** list of NETCONF nodes to mount (each line consists of a node name and node IP address)

### Python scripts are:

**put-node.py** mounts a node

**is-node-connected.py** checks if a node is mounted

**put-bgp-rib.py** configures the ODL BGP RIB

**put-app-rib.py** configures the ODL App RIB

**put-bgp-peer.py** configures a BGP peer in ODL

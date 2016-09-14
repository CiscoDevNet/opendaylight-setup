# Setup Network Environment

This tutorial is to help you set up the network environment, so you can peer your OpenDayLight controller with virtual routers.

## Network Diagram & Components

Topology of network that we shall be putting together for this tutorial
is depicted below. It comprises of OpenDaylight Controller VM in local
computing environment connected to Cisco Virtual Internet Routing Lab
(VIRL) based network simulation running in Cisco dCloud environment,
over Anyconnect VPN

![Network Topology](./images/dcloud/topology.png)

![Componets](./images/image2.png)

## Start Cisco dCloud environment

Follow below steps to launch the network simulation

### Create an account and login into Cisco dCloud

1.  Open <https://dcloud.cisco.com/> in your browser and click on
    **Login** button
    
	![](./images/image3.png)
	
2.  If you already have a Cisco account, login using that and start [scheduling a ODL lab](#schedule)
	![](./images/image4.png)
	
	> Optionally click on **Register Now** button to get a free account
    
	> Enter required details and create new account. Login to dCloud
    portal using the new account details

	> ![](./images/image5.png)

### <a name="schedule">Find and schedule the OpenDaylight lab</a>

1.  Navigate to **Dashboard** **My Sessions** and click on **find
    content**

	![](./images/image6.png)

2.  Search Catalog for “OpenDaylight Beryllium SR3 with Apps with 8 Nodes v1”. Then click on **Schedule** button of the lab displayed

	![](./images/dcloud/dcloud-catalog.png)
	
4.  Click on **Now** button. By default, the scheduled duration will be 4 hours. Adjust the end time for the desired duration **(min. 5 hours recommended. The max. time your can schedule is 5 days)**. Go to bottom of page and click on **Next**

	![](./images/dcloud/dcloud-schedule.png)

5.  Enter the drop-down values appropriately and click on **Schedule**

	![](./images/image10.png)

6.  The session should start within few minutes

	![](./images/image11.png)

7.  Click on **View** button to see session details

	![](./images/image12.png)

8.  Click on **Details** tab and note down the Anyconnect details, which will be used when connecting Controller VM to the dCloud environment

	![](./images/image13.png)
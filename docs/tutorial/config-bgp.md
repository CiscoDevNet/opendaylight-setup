# Configure BGP on ODL
## Install BGP Feature on ODL

To install BGP feature, you need to enter karaf client first, then run the following command:

`feature:install odl-bgpcep-bgp`

If you are using the default *parameters* files provided by this project, the *odl-bgpcep-bgp* feature will be installed by default.

## Verify BGP Feature
After installing BGP feature, you should be able to see the bgp feature listed in the "installed feature" list.  You can simply verify it with command:

`feature:list -i | grep odl-bgpcep-bgp`

You should be able to see all the BGP related modules get installed.

![Verify BGP via feature list](./images/bgp/verify-bgp-feature.png)

Besides, you can also verify if BGP feature is functioning properly by accessing the BGP RESTCONF interface.  Simply checking if BGP RIB is returning the correct topology will be enough.

![Verify BGP via RESTCONF](./images/bgp/verify-bgp-restconf.png) 

## Change BGP Configurations
To add/edit BGP peers, you will need to change a few BGP configuration files.  These files are managed by the config subsystem of ODL.  They are loaded when the ODL is started.
 
### Change 41-bgp-config-example.xml

`etc/opendaylight/karaf/41-bgp-example.xml`

`gedit distribution/odl/etc/opendaylight/karaf/41-bgp-example.xml >/dev/null 2>&1 &`

#### Update BGP Peer

#### Update BGP Application Peer

### Restart OpenDayLight
To let ODL reload the config xml files, you will have to restart OpenDayLight.  You can restart ODL by running the two scripts provided by the project:

```
./bin/stop-odl
./bin/start-odl
```
### Debug

```
log:set DEBUG org.opendaylight.bgpcep.bgp
log:set DEBUG org.opendaylight.protocol.bgp
```

### Peer with XRv in dCloud Lab


![Login to BGP Peer](./images/bgp/telnet-xrv.png)

![Change XRv Config](./images/bgp/change-xrv-config.png)

```
 neighbor 198.18.1.80
  remote-as 65504
  update-source MgmtEth0/0/CPU0/0
  address-family ipv4 unicast
   route-reflector-client
  !
  address-family link-state link-state
   route-reflector-client
  !       
 !
```

198.18.1.80 is the IP of the OpenDayLight controller hosted in Cisco dCloud.  As we are using our own controller for the tutorial, we want to replace the IP with our own controller's IP.

```
configure terminal
router bgp 65504
 no neighbor 198.18.1.80
 
 neighbor 1.2.3.4
  remote-as 65504
  update-source MgmtEth0/0/CPU0/0
  address-family ipv4 unicast
   route-reflector-client
  !
  address-family link-state link-state
   route-reflector-client
  !       
 !
commit
```

Replace the **1.2.3.4** with your local controller's IP (the VPN tunnel's IP)

`./bin/check-vpn-status`

## Verify BGP RIB Information

Karaf log:

```
2016-09-10 00:16:38,109 | INFO  | oupCloseable-2-1 | StrictBGPPeerRegistry            | 236 - org.opendaylight.bgpcep.bgp-rib-impl - 0.5.3.Beryllium-SR3 | BGP Open message session parameters differ, session still accepted.
2016-09-10 00:16:38,117 | INFO  | oupCloseable-2-1 | BGPSessionImpl                   | 236 - org.opendaylight.bgpcep.bgp-rib-impl - 0.5.3.Beryllium-SR3 | BGP HoldTimer new value: 180
2016-09-10 00:16:38,152 | INFO  | oupCloseable-2-1 | BGPPeer                          | 236 - org.opendaylight.bgpcep.bgp-rib-impl - 0.5.3.Beryllium-SR3 | Session with peer 198.18.1.37 went up with tables: [BgpTableTypeImpl [getAfi()=class org.opendaylight.yang.gen.v1.urn.opendaylight.params.xml.ns.yang.bgp.types.rev130919.Ipv4AddressFamily, getSafi()=class org.opendaylight.yang.gen.v1.urn.opendaylight.params.xml.ns.yang.bgp.types.rev130919.UnicastSubsequentAddressFamily], BgpTableTypeImpl [getAfi()=class org.opendaylight.yang.gen.v1.urn.opendaylight.params.xml.ns.yang.bgp.linkstate.rev150210.LinkstateAddressFamily, getSafi()=class org.opendaylight.yang.gen.v1.urn.opendaylight.params.xml.ns.yang.bgp.linkstate.rev150210.LinkstateSubsequentAddressFamily]]
2016-09-10 00:16:38,285 | INFO  | oupCloseable-2-1 | AbstractBGPSessionNegotiator     | 236 - org.opendaylight.bgpcep.bgp-rib-impl - 0.5.3.Beryllium-SR3 | BGP Session with peer [id: 0xfdcbed33, L:/10.16.22.180:37480 - R:/198.18.1.37:179] established successfully.
2016-09-10 00:16:45,640 | INFO  | oupCloseable-2-1 | BGPSynchronization               | 236 - org.opendaylight.bgpcep.bgp-rib-impl - 0.5.3.Beryllium-SR3 | BGP Synchronization finished for table TablesKey [_afi=class org.opendaylight.yang.gen.v1.urn.opendaylight.params.xml.ns.yang.bgp.linkstate.rev150210.LinkstateAddressFamily, _safi=class org.opendaylight.yang.gen.v1.urn.opendaylight.params.xml.ns.yang.bgp.linkstate.rev150210.LinkstateSubsequentAddressFamily] 
2016-09-10 00:16:46,041 | INFO  | oupCloseable-2-1 | BGPSynchronization               | 236 - org.opendaylight.bgpcep.bgp-rib-impl - 0.5.3.Beryllium-SR3 | BGP Synchronization finished for table TablesKey [_afi=class org.opendaylight.yang.gen.v1.urn.opendaylight.params.xml.ns.yang.bgp.types.rev130919.Ipv4AddressFamily, _safi=class org.opendaylight.yang.gen.v1.urn.opendaylight.params.xml.ns.yang.bgp.types.rev130919.UnicastSubsequentAddressFamily] 
```

Restconf response (the response could be big, so actual text response is not pasted here):

![BGP RIB Restconf after Sync](./images/bgp/rib-after-sync.png)

## Inject Route
### Inject Unicast Route
* Inject IPv4 unicast routes

![Inject IPv4 Unicast Route](./images/bgp/insert-ipv4-route.png)

![Display Injected IPv4 Unicast Route](./images/bgp/display-ipv4-route.png)

* Inject IPv6 unicast routes
![Inject IPv6 Unicast Route](./images/bgp/insert-ipv6-route.png)

![Display Injected IPv6 Unicast Route](./images/bgp/display-ipv6-route.png)

### Delete Injected Route

# Configure BGP on ODL
This part of the tutorial we will introduce how to use ODL to set up BGP session with a router.

## Prerequisite
### Install BGP Feature on ODL

To install BGP feature, you need to enter karaf client with command `bin/karaf-client` first, then run the following command:

`feature:install odl-bgpcep-bgp`

> If you are using the default *parameters* files provided by this project, the *odl-bgpcep-bgp* feature will be installed by default.

### Verify BGP Feature
After installing BGP feature, you should be able to see the bgp feature listed in the "installed feature" list.  You can simply verify it with command:

`feature:list -i | grep odl-bgpcep-bgp`

You should be able to see all the BGP related modules get installed.

![Verify BGP via feature list](./images/bgp/verify-bgp-feature.png)

Besides, you can also verify if BGP feature is functioning properly by accessing the BGP RESTCONF interface.  Simply checking if BGP RIB is returning the correct topology will be enough.

> You can find the corresponding RESTCONF request in provided Postman collection.

![Verify BGP via RESTCONF](./images/bgp/verify-bgp-restconf.png) 

### Debug
In case you want to observe the internals of BGP feature, you can turn on the DEBUG option in karaf console to see more detailed karaf log output with BGP debug information:

```
log:set DEBUG org.opendaylight.bgpcep.bgp
log:set DEBUG org.opendaylight.protocol.bgp
```

## Start to Play with BGP in ODL
Now that BGP feature installed in ODL, we can start to play with it.

* [Exercise with ExaBGP](./config-bgp-exabgp.md)

* [Exercise with XRv in Cisco dCloud Lab](./config-bgp-xrv.md)
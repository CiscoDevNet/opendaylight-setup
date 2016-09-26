# Configure BGP feature with OpenConfig

Since Beryllium, it is possible to configure BGP via [OpenConfig](http://www.openconfig.net/) without changing 41-bgp-example.xml.  If you have changed 41-bgp-example.xml before using OpenConfig, it is fine.  OpenConfig will load the configuration from it by default.

OpenConfig is implemented with the same BGP RIB model, so there isn't much difference between configuring BGP feature via OpenConfig and configuring BGP via 41-bgp-example.xml

## Beryllium OpenConfig

In Beryllium, the OpenConfig is backed by the Config Sub-System in ODL.  It means, if you push a change via OpenConfig on Beryllium, there will be a file named **controller.currentconfig.xml** get generated under `etc/opendaylight/current`.  It is basically an uber config file with all the configuration merged into one.  Once the file is generated, the changes in xml file such as **41-bgp-example.xml** file will not be loaded any more.  Be sure to clear the file if you want to configure xml file again.

Refer to [Beryllium User Guide](https://wiki.opendaylight.org/view/BGP_LS_PCEP:Beryllium_User_Guide#OpenConfig_BGP) for more details about configuring ODL via OpenConfig in Beryllium.

## Boron OpenConfig

In Boron, OpenConfig is backed be ODL config datastore.  And more features are availabed through OpenConfig.

Please refer to the [Boron User Guide](https://logs.opendaylight.org/releng/jenkins092/docs-verify-rtd-carbon/246/archives/docs/_build/html/user-guide/bgp-user-guide.html) here for more details about how to configuring ODL via OpenConfig in Boron.


# ExaBGP
[ExaBGP](https://github.com/Exa-Networks/exabgp) is a handy tool for testing and debugging BGP feature.  You can use it to simulate a BGP-capable router.

## Testing BGP with ExaBGP

We provide a collection of exabgp configuration examples so that you can start to use it immedately.

Command example:

```
env exabgp.tcp.port=1790 exabgp exabgp-config/boron/flowspec-vpn-ipv6.cfg
```

Here we are adding an environment variable here to specify the BGP tcp port ExaBGP should listen on.  Because the default BGP protocol port is 179.  However, as ODL is running with non-root privilege by default, it cannot listen on system ports where port number is less than 1024.  So ODL is using 1790 as BGP port by default.


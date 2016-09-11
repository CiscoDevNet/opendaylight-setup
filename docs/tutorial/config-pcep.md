# Setup PCEP

## Configure Cisco XRv in dCloud Lab

![Configure PCEP](./images/pcep/config-pcep.png)

```
 pce
  peer ipv4 198.18.1.80
  !
  segment-routing
  stateful-client
   instantiation
   cisco-extension
  !
 !
```


```
mpls traffic-eng
 pce
  no peer ipv4 198.18.1.80
  peer ipv4 1.2.3.4
  !
  stateful-client
    no cisco-extension
 !
!
```

Replace 1.2.3.4 with your local controller's IP

`commit` the change

After the change, you should be able to see the following configuration with command `show running-config mpls traffic-eng` (the **1.2.3.4** should be your controller's IP instead)

```
mpls traffic-eng
 interface GigabitEthernet0/0/0/0
 !
 interface GigabitEthernet0/0/0/1
 !
 interface GigabitEthernet0/0/0/2
 !
 interface GigabitEthernet0/0/0/3
 !
 interface GigabitEthernet0/0/0/4
 !
 pce
  peer ipv4 1.2.3.4
  !
  segment-routing
  stateful-client
   instantiation
  !
 !
 auto-tunnel pcc
  tunnel-id min 1 max 99
 !
 reoptimize timers delay installation 0
!
```

## Verify PCC is Connected to Controller

```
2016-09-10 01:26:49,756 | INFO  | oupCloseable-2-3 | PCEPSessionNegotiator            | 288 - org.opendaylight.bgpcep.pcep-impl - 0.5.3.Beryllium-SR3 | Replacing bootstrap negotiator for channel [id: 0xe72db829, L:/10.16.22.180:4189 - R:/198.18.1.37:26749]
2016-09-10 01:26:49,760 | INFO  | oupCloseable-2-3 | AbstractPCEPSessionNegotiator    | 288 - org.opendaylight.bgpcep.pcep-impl - 0.5.3.Beryllium-SR3 | PCEP session with [id: 0xe72db829, L:/10.16.22.180:4189 - R:/198.18.1.37:26749] started, sent proposal Open [_deadTimer=120, _keepalive=30, _sessionId=0, _tlvs=Tlvs [augmentation=[Tlvs1 [_stateful=Stateful [_lspUpdateCapability=true, augmentation=[Stateful1 [_initiation=true], Stateful1 [_deltaLspSyncCapability=true, _includeDbVersion=true, _triggeredInitialSync=true, _triggeredResync=true]]]], Tlvs1 [_srPceCapability=SrPceCapability [_msd=0, augmentation=[]]]]], augmentation=[]]
2016-09-10 01:26:49,850 | INFO  | oupCloseable-2-3 | AbstractPCEPSessionNegotiator    | 288 - org.opendaylight.bgpcep.pcep-impl - 0.5.3.Beryllium-SR3 | PCEP peer [id: 0xe72db829, L:/10.16.22.180:4189 - R:/198.18.1.37:26749] completed negotiation
2016-09-10 01:26:49,850 | INFO  | oupCloseable-2-3 | PCEPSessionImpl                  | 288 - org.opendaylight.bgpcep.pcep-impl - 0.5.3.Beryllium-SR3 | Session /10.16.22.180:4189[0] <-> /198.18.1.37:26749[1] started
2016-09-10 01:26:49,865 | INFO  | oupCloseable-2-3 | AbstractTopologySessionListener  | 301 - org.opendaylight.bgpcep.pcep-topology-provider - 0.5.3.Beryllium-SR3 | Session with /198.18.1.37 attached to topology node KeyedInstanceIdentifier{targetType=interface org.opendaylight.yang.gen.v1.urn.tbd.params.xml.ns.yang.network.topology.rev131021.network.topology.topology.Node, path=[org.opendaylight.yang.gen.v1.urn.tbd.params.xml.ns.yang.network.topology.rev131021.NetworkTopology, org.opendaylight.yang.gen.v1.urn.tbd.params.xml.ns.yang.network.topology.rev131021.network.topology.Topology[key=TopologyKey [_topologyId=Uri [_value=pcep-topology]]], org.opendaylight.yang.gen.v1.urn.tbd.params.xml.ns.yang.network.topology.rev131021.network.topology.topology.Node[key=NodeKey [_nodeId=Uri [_value=pcc://198.18.1.37]]]]}
```

![PCEP Topology](./images/pcep/pcep-topology.png)

> Note the **node-id** will be shown as **192.19.1.30**, which is the Loopback0 address of the XRv.  You can configure XRv to overwrite the node-id with command: `mpls traffic-eng pce peer source ipv4 198.18.1.37`

## Create PCE-initiated LSP

`telnet $ROUTER_NODE_POR`

## Create PCC-initiated LSP

```
interface tunnel-te100
 ipv4 unnumbered Loopback0
 signalled-name foo
 autoroute announce
 !
 destination 198.19.1.26
 path-option 1 dynamic
!
```

`show mpls traffic-eng tunnels`


```
Name: tunnel-te100  Destination: 198.19.1.26  Ifhandle:0x580 
  Signalled-Name: foo
  Status:
    Admin:    up Oper:   up   Path:  valid   Signalling: connected

    path option 1,  type dynamic  (Basis for Setup, path weight 20)
    G-PID: 0x0800 (derived from egress interface properties)
    Bandwidth Requested: 0 kbps  CT0
    Creation Time: Sun Sep 11 08:15:24 2016 (00:00:10 ago)
  Config Parameters:
    Bandwidth:        0 kbps (CT0) Priority:  7  7 Affinity: 0x0/0xffff
    Metric Type: TE (default)
    Path Selection:
      Tiebreaker: Min-fill (default)
    Hop-limit: disabled
    Cost-limit: disabled
    Path-invalidation timeout: 10000 msec (default), Action: Tear (default)
    AutoRoute:  enabled  LockDown: disabled   Policy class: not set
    Forward class: 0 (default)
    Forwarding-Adjacency: disabled
    Loadshare:          0 equal loadshares
    Auto-bw: disabled
    Fast Reroute: Disabled, Protection Desired: None
    Path Protection: Not Enabled
    BFD Fast Detection: Disabled
    Reoptimization after affinity failure: Enabled
    Soft Preemption: Disabled
  History:
    Tunnel has been up for: 00:00:09 (since Sun Sep 11 08:15:25 UTC 2016)
    Current LSP:
      Uptime: 00:00:09 (since Sun Sep 11 08:15:25 UTC 2016)

  Path info (IS-IS pce-poc level-2):
  Node hop count: 2
  Hop0: 56.0.0.29
  Hop1: 54.0.0.26
  Hop2: 198.19.1.26
Displayed 1 (of 1) heads, 0 (of 0) midpoints, 0 (of 0) tails
Displayed 1 up, 0 down, 0 recovering, 0 recovered heads
RP/0/0/CPU0:sjc#
```

### Enable LSP Delegation
You can enable the LSP delegation to controller with the command:

```
interface tunnel-te100
 pce
  delegation
 !
```

After the change, the configuration should looks like this:

```
RP/0/0/CPU0:sjc#show running-config interface tunnel-te 100
Sun Sep 11 08:23:16.236 UTC
interface tunnel-te100
 ipv4 unnumbered Loopback0
 signalled-name foo
 autoroute announce
 !
 destination 198.19.1.26
 path-option 1 dynamic
 pce
  delegation
 !
!
```

```
RP/0/0/CPU0:sjc#show mpls traffic-eng tunnels 
Sun Sep 11 08:25:13.636 UTC


Name: tunnel-te100  Destination: 198.19.1.26  Ifhandle:0x580 
  Signalled-Name: foo
  Status:
    Admin:    up Oper:   up   Path:  valid   Signalling: connected

    path option 10, (verbatim) type explicit (autopcc_te100) (Basis for Setup, path weight 0)
    G-PID: 0x0800 (derived from egress interface properties)
    Bandwidth Requested: 0 kbps  CT0
    Creation Time: Sun Sep 11 08:15:24 2016 (00:09:50 ago)
  Config Parameters:
    Bandwidth:        0 kbps (CT0) Priority:  7  7 Affinity: 0x0/0xffff
    Metric Type: TE (default)
    Path Selection:
      Tiebreaker: Min-fill (default)
    Hop-limit: disabled
    Cost-limit: disabled
    Path-invalidation timeout: 10000 msec (default), Action: Tear (default)
    AutoRoute:  enabled  LockDown: disabled   Policy class: not set
    Forward class: 0 (default)
    Forwarding-Adjacency: disabled
    Loadshare:          0 equal loadshares
    Auto-bw: disabled
    Fast Reroute: Disabled, Protection Desired: None
    Path Protection: Not Enabled
    BFD Fast Detection: Disabled
    Reoptimization after affinity failure: Enabled
    Soft Preemption: Disabled
  PCE Delegation: 
    Symbolic name: foo
    PCEP ID: 101
    Delegated to: 10.16.22.180
  History:
    Tunnel has been up for: 00:09:49 (since Sun Sep 11 08:15:25 UTC 2016)
    Current LSP:
      Uptime: 00:02:26 (since Sun Sep 11 08:22:48 UTC 2016)
    Prior LSP:
      ID: 2 Path Option: 10
      Removal Trigger: reoptimization completed

  Path info (PCE controlled):
  Hop0: 56.0.0.29
  Hop1: 54.0.0.26
  Hop2: 198.19.1.26
Displayed 1 (of 1) heads, 0 (of 0) midpoints, 0 (of 0) tails
Displayed 1 up, 0 down, 0 recovering, 0 recovered heads

```

You should be able to see the section **PCE Delegation**, and the **Delegated to** field points to your controller.

The **Path info** at the bottom also shows **PCE controlled**.

![PCC init LSP](./images/pcep/pcep-topology-pcc-init-1.png)

![PCC init LSP](./images/pcep/pcep-topology-pcc-init-1.png)

### Update LSP Information



### Revoke LSP Delegation

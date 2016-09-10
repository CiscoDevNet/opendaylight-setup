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
configure terminal
mpls traffic-eng
 pce
  no peer ipv4 198.18.1.80
  peer source ipv4 198.18.1.37
  peer ipv4 1.2.3.4
  !
  stateful-client
    no cisco-extension
 !
commit
```


Replace 1.2.3.4 with your local controller's IP

## Verify PCEP Is Working

```
2016-09-10 01:26:49,756 | INFO  | oupCloseable-2-3 | PCEPSessionNegotiator            | 288 - org.opendaylight.bgpcep.pcep-impl - 0.5.3.Beryllium-SR3 | Replacing bootstrap negotiator for channel [id: 0xe72db829, L:/10.16.22.180:4189 - R:/198.18.1.37:26749]
2016-09-10 01:26:49,760 | INFO  | oupCloseable-2-3 | AbstractPCEPSessionNegotiator    | 288 - org.opendaylight.bgpcep.pcep-impl - 0.5.3.Beryllium-SR3 | PCEP session with [id: 0xe72db829, L:/10.16.22.180:4189 - R:/198.18.1.37:26749] started, sent proposal Open [_deadTimer=120, _keepalive=30, _sessionId=0, _tlvs=Tlvs [augmentation=[Tlvs1 [_stateful=Stateful [_lspUpdateCapability=true, augmentation=[Stateful1 [_initiation=true], Stateful1 [_deltaLspSyncCapability=true, _includeDbVersion=true, _triggeredInitialSync=true, _triggeredResync=true]]]], Tlvs1 [_srPceCapability=SrPceCapability [_msd=0, augmentation=[]]]]], augmentation=[]]
2016-09-10 01:26:49,850 | INFO  | oupCloseable-2-3 | AbstractPCEPSessionNegotiator    | 288 - org.opendaylight.bgpcep.pcep-impl - 0.5.3.Beryllium-SR3 | PCEP peer [id: 0xe72db829, L:/10.16.22.180:4189 - R:/198.18.1.37:26749] completed negotiation
2016-09-10 01:26:49,850 | INFO  | oupCloseable-2-3 | PCEPSessionImpl                  | 288 - org.opendaylight.bgpcep.pcep-impl - 0.5.3.Beryllium-SR3 | Session /10.16.22.180:4189[0] <-> /198.18.1.37:26749[1] started
2016-09-10 01:26:49,865 | INFO  | oupCloseable-2-3 | AbstractTopologySessionListener  | 301 - org.opendaylight.bgpcep.pcep-topology-provider - 0.5.3.Beryllium-SR3 | Session with /198.18.1.37 attached to topology node KeyedInstanceIdentifier{targetType=interface org.opendaylight.yang.gen.v1.urn.tbd.params.xml.ns.yang.network.topology.rev131021.network.topology.topology.Node, path=[org.opendaylight.yang.gen.v1.urn.tbd.params.xml.ns.yang.network.topology.rev131021.NetworkTopology, org.opendaylight.yang.gen.v1.urn.tbd.params.xml.ns.yang.network.topology.rev131021.network.topology.Topology[key=TopologyKey [_topologyId=Uri [_value=pcep-topology]]], org.opendaylight.yang.gen.v1.urn.tbd.params.xml.ns.yang.network.topology.rev131021.network.topology.topology.Node[key=NodeKey [_nodeId=Uri [_value=pcc://198.18.1.37]]]]}
```

![PCEP Topology](./images/pcep/pcep-topology.png)
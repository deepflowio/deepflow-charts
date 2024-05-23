# DeepFlow Agent Helm Charts


This repository contains [Helm](https://helm.sh/) charts for DeepFlow Agent project.

## Usage

### Prerequisites

- Kubernetes 1.16+
- Helm 3+

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add deepflow https://deepflowio.github.io/deepflow
helm repo udpate deepflow
```

## Helm Charts

You can then run `helm search repo deepflow-agent` to see the charts.

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Installing the Chart

To install the chart with the release name `deepflow-agent`:

```console
helm install deepflow-agent -n deepflow deepflow/deepflow-agent --create-namespace
```

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete deepflow-agent -n deepflow
```

The command removes all the Kubernetes components associated with the chart and deletes the release.



## Main values block usage:

### Common

```yaml
deepflowServerNodeIPS:
  - deepflow-server # The IP address of the Deepflow server node
deepflowK8sClusterID: e70999ed-fdff-4277-be3c-4a3fceae215f # The ID of the Deepflow Kubernetes cluster
agentGroupID: 1 # The ID of the agent group
controllerPort: 443 # The port of the kubernetes apiserver 
clusterNAME: worker # # The name of the cluster
```


### Affinity:

The affinity of component. Combine `global.affinity` by 'OR'.

- podAntiAffinityLabelSelector: affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution

  ```yaml
  podAntiAffinityLabelSelector: 
      - labelSelector:
        - key: app #your label key
          operator: In # In、NotIn、Exists、 DoesNotExist
          values: deepflow #your label value, Multiple values separated by commas
        - key: component 
          operator: In
          values: deepflow-server,deepflowys
        topologyKey: "kubernetes.io/hostname"
  ```

- podAntiAffinityTermLabelSelector: affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution

  ```yaml
  podAntiAffinityLabelSelector: 
      - labelSelector:
        - key: app # your label key
          operator: In # In、NotIn、Exists、 DoesNotExist
          values: deepflow # your label value, Multiple values separated by commas
        - key: component 
          operator: In
          values: deepflow-server,deepflowys
        topologyKey: "kubernetes.io/hostname"
  ```

- podAffinityLabelSelector: affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution

  ```yaml
    podAffinityLabelSelector:
      - labelSelector:
        - key: app
          operator: In
          values: deepflow
        - key: component
          operator: In
          values: clickhouse
        topologyKey: "kubernetes.io/hostname"
  ```

- podAffinityTermLabelSelector: affinity.podAffinity.preferredDuringSchedulingIgnoredDuringExecution

  ```yaml
    podAffinityTermLabelSelector:
      - topologyKey: kubernetes.io/hostname
        weight: 10
        labelSelector:
          - key: app
            operator: In
            values: deepflow,deepflowys
  ```

- nodeAffinityLabelSelector: affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution

  ```yaml
    nodeAffinityLabelSelector:
      - matchExpressions:
          - key: app
            operator: In
            values: deepflow,deepflowys
  ```

- nodeAffinityTermLabelSelector: affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution

  ```yaml
    nodeAffinityTermLabelSelector:
      - weight: 10
        matchExpressions:
        - key: app
          operator: In
          values: deepflow,deepflowys
  ```
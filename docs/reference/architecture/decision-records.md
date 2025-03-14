# Decision records

These are the records of design decisions for future reference in order to understand why things are the way they are.
They are not permanent, we can change them in the future if better alternatives become available.

??? Template

    ## Description of the the change

    **Context**

    CHANGEME

    **Decision**

    CHANGEME

    **Consequences**

    - CHANGEME

## How to create Kubernetes Cluster

**Context**

I've tried k3s, kubespray, Talos.
Talos has a good (enough) balance between stability and new features.

**Decision**

Use Talos as the base OS.

**Consequences**

`¯\_(ツ)_/¯`

## Storage class

**Context**

There are a lot storage component in Kubernetes ecosystem.

**Decision**

Use NFS provisioner.

**Consequences**

`¯\_(ツ)_/¯`

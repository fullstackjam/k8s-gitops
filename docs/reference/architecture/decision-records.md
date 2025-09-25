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

I've tried different Kubernetes distributions including kubespray and Talos.
For a homelab environment that needs full control over Kubernetes components and configuration, kubespray provides the best balance between flexibility and maintainability.

**Decision**

Use kubespray to provision a standard Kubernetes cluster on Fedora Server.

**Consequences**

- Full control over Kubernetes components and their versions
- Production-ready configuration with high availability support
- Easy to customize and extend with additional components
- Well-tested and widely used in production environments
- Good integration with infrastructure automation tools
- Requires more resources compared to lightweight distributions

## Storage class

**Context**

There are many storage solutions in the Kubernetes ecosystem, including NFS provisioner, Ceph, GlusterFS, and cloud-native solutions.
For a homelab environment, we need a solution that provides both reliability and scalability.

**Decision**

Use Rook Ceph as the storage solution.

**Consequences**

- Provides both block and object storage capabilities
- Self-healing and highly available
- Scales well with cluster growth
- Industry-standard storage solution
- Supports both ReadWriteOnce (RWO) and ReadWriteMany (RWX) access modes
- Can be easily backed up and restored

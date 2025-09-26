# Applications Directory

This directory contains standalone ArgoCD Application configurations that are managed by a dedicated ApplicationSet.

## Structure

- `pulsehub-application.yaml` - PulseHub application with Image Updater annotations
- `*-application.yaml` - Other standalone applications

## Management

These applications are automatically discovered and managed by the `standalone-apps` ApplicationSet, which:
- Uses `files` generator instead of `directories`
- Does NOT apply any template - uses file content directly
- Allows complete control over Application configuration

## Naming Convention

- Use descriptive names: `{app-name}-application.yaml`
- Ensure the `metadata.name` matches the filename (without extension)
- Place Image Updater annotations directly in the Application metadata

## Example

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
  namespace: argocd
  annotations:
    argocd-image-updater.argoproj.io/image-list: my-app=myregistry/my-app
    argocd-image-updater.argoproj.io/write-back-method: argocd
    argocd-image-updater.argoproj.io/update-strategy: newest-build
spec:
  project: default
  source:
    repoURL: https://github.com/myorg/myapp
    targetRevision: main
    path: helm/myapp
  destination:
    name: in-cluster
    namespace: my-app
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    retry:
      limit: 10
      backoff:
        duration: 1m
        factor: 2
        maxDuration: 16m
    syncOptions:
      - CreateNamespace=true
      - ApplyOutOfSyncOnly=true
      - ServerSideApply=true
```

## Benefits

- **No Template Override**: Application files are used as-is
- **Full Control**: Complete control over sync policies, namespaces, etc.
- **Flexibility**: Each application can have different configurations
- **Automatic Management**: Still managed by ArgoCD ApplicationSet

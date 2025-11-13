# Velero

Velero 是 Kubernetes 的备份和迁移工具。

## 📁 文件结构

```
velero/
├── Chart.yaml       # Helm chart 依赖
├── values.yaml      # Velero 配置
├── namespace.yaml   # 命名空间
└── README.md        # 本文件
```

## 🚀 部署

通过 ArgoCD 自动部署，配置已包含在 ApplicationSet 中。

## ⚙️ 基本配置

- **版本**: Velero v1.15.0
- **存储**: AWS S3 兼容
- **插件**: AWS 插件
- **监控**: Metrics 启用

## 📚 文档

- [Velero 官方文档](https://velero.io/docs/)
# Updating documentation (this website)

This project uses the [Diátaxis](https://diataxis.fr) technical documentation framework.
The website is generated using [Material for MkDocs](https://squidfunk.github.io/mkdocs-material) and can be viewed at [k8s-gitops.fullstackjam.com](https://k8s-gitops.fullstackjam.com).

There are 4 main parts:

- [Getting started (tutorials)](https://diataxis.fr/tutorials): learning-oriented
- [Concepts (explanation)](https://diataxis.fr/explanation): understanding-oriented
- [How-to guides](https://diataxis.fr/how-to-guides): goal-oriented
- [Reference](https://diataxis.fr/reference): information-oriented

## Local development

To edit and view locally, run:

```sh
make tools
mkdocs serve
```

Then visit [localhost:8000](http://localhost:8000)

# Using this repository

To install a Helm chart from this repository first add the repository:

```
helm repo add lsstsqre https://lsst-sqre.github.io/charts/
helm repo update
```

## Installing charts

Use the `helm install` command to install the charts:

```
helm install lsstsqre/mychart --name myrelease
```

See the [Helm Documentation](https://github.com/helm/helm/tree/master/docs) for more information.

# Adding a new chart to this repository

This command will create  a [collection of files](https://github.com/helm/helm/blob/master/docs/charts.md#the-chart-file-structure) that defines your chart:

```
helm create mychart
```

## Templates

Helm finds the YAML definitions for your Kubernetes objects in the `templates/` directory. Helm runs each file in this directory through a Go template rendering engine.

## Values

The `values.yaml` file defines the defaults for each template variable.

## Documentation

Another useful file in the `templates/` directory is the `NOTES.txt` file. It is a templated, plaintext file that gets printed out after the chart is successfully deployed.


# Debugging your chart

As you develop your chart, it’s a good idea to run it through the linter to ensure you’re following best practices and that your templates are well-formed:

```
helm lint mychart
```

A convenient command to debug your new chart is:

```
helm install --dry-run --debug mychart
```

# Packaging your chart

This command will create a `tgz` package for the chart in the current directory.
```
helm package mychart
```

# Updating the index

The `index.yaml` file contains information about each chart in the repository. After you create your chart update the index file with the command:

```
helm repo index .
```

# Pushing your changes

Before pushing your changes to this repository, you can test things out locally with the `helm serve` command, which starts a local server.

```
helm serve
Regenerating index. This may take a moment.
Now serving you on 127.0.0.1:8879
```

Make sure the local repository is in the list of Helm repositories.

```
helm repo add local http://127.0.0.1:8879
helm repo update local
helm install local/mychart --name mychart
```

⎈ Happy Helming!⎈

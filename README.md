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
cd charts
helm create mychart
```

Be sure to do this in the `charts` subdirectory, since only charts in that directory will be released and uploaded to the repository.

## Templates

Helm finds the YAML definitions for your Kubernetes objects in the `templates/` directory.
Helm runs each file in this directory through a Go template rendering engine.

## Values

The `values.yaml` file defines the defaults for each template variable.

## Documentation

If you place a file named `NOTES.txt` in the `templates/` directory of a chart, it will be printed out after the chart is successfully deployed.
This file is templated using the same template engine as other resources in that directory.
It should produce plain text information.

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

Your chart will be packaged and released automatically once the chart has been merged into the `master` branch.
This is done via a GitHub Action configured in `.github/workflows/release.yaml`.
The release will then be automatically added to the repository index at https://lsst-sqre.github.io/charts/.

⎈ Happy Helming! ⎈

"""Check that chart versions have been updated."""

from __future__ import annotations

from pathlib import Path

import requests
import yaml
from git import DiffIndex, Repo
from semver import VersionInfo

REPOSITORY_URL = "https://lsst-sqre.github.io/charts/index.yaml"
"""The URL for the Helm repository index of currently-published charts."""


def test_versions(tmp_path: Path) -> None:
    """Check that all modified charts have an updated version number.

    For automatic publication of new Helm charts to work, we have to remember
    to update the version number of a chart whenever we make changes to it.
    This test verifies that by verifying there have been no Git commits that
    change the contents of a chart since the last tagged release if the
    version of the chart matches the last released version.

    This check is done with Git rather than by comparing the contents of the
    package since helm package makes changes to files when packaging (such as
    canonicalizing Chart.yaml).
    """
    root_path = Path(__file__).parent.parent
    charts_path = root_path / "charts"
    repo = Repo(str(root_path))

    r = requests.get(REPOSITORY_URL)
    assert r.status_code == requests.codes.ok
    index = yaml.safe_load(r.text)

    # Only check charts that have been published.
    published_charts = set(index["entries"].keys())
    current_charts = set((p.name for p in charts_path.iterdir()))
    charts_to_check = published_charts & current_charts

    errors = []
    for chart in charts_to_check:
        published = max(
            index["entries"][chart],
            key=lambda e: VersionInfo.parse(e["version"]),
        )

        # If the version number in the current repository is later than the
        # latest published version, differences are allowed.
        with (charts_path / chart / "Chart.yaml").open() as f:
            metadata = yaml.safe_load(f)
            current = VersionInfo.parse(metadata["version"])
            latest = VersionInfo.parse(published["version"])
            if current > latest:
                continue

        # Otherwise, construct the tag of the previous release and look for
        # any changes in Git since that release.
        tag = f"{chart}-{published['version']}"
        if not any((t.name == tag for t in repo.tags)):
            continue
        diff = repo.head.commit.diff(tag, paths=[f"charts/{chart}"])
        for change_type in DiffIndex.change_type:
            if any(diff.iter_change_type(change_type)):
                msg = f"Chart {chart} has changed but has same version"
                errors.append(msg)
                break

    assert "" == "\n".join(errors)

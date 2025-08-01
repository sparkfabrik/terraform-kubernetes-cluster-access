# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres
to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.0] - 2025-07-29

[Compare with previous version](https://github.com/sparkfabrik/terraform-kubernetes-cluster-access/compare/0.4.0...0.5.0)

### Changed

- Remove `pods/exec` and `pods/portforward` permission from the `developer` cluster role.

## [0.4.0] - 2025-07-01

[Compare with previous version](https://github.com/sparkfabrik/terraform-kubernetes-cluster-access/compare/0.3.0...0.4.0)

### Changed

- Update developer and admin cluster roles to include permissions for `ingresses` and `ingresses/status` resources.

## [0.3.0] - 2024-01-25

[Compare with previous version](https://github.com/sparkfabrik/terraform-kubernetes-cluster-access/compare/0.2.0...0.3.0)

### Added

- Add Horizontal Pod Autoscaler (HPA) permissions to the `developer` cluster role.

## [0.2.0] - 2024-01-04

[Compare with previous version](https://github.com/sparkfabrik/terraform-kubernetes-cluster-access/compare/0.1.0...0.2.0)

### Added

- Add possibility to specify if developer and/or admin groups should list and get information about the namespaces.

## [0.1.0] - 2023-11-16

- First release.

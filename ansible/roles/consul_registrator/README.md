registrator
==================

Ansible role to run registrator docker container.


## Requirements

- Docker host


## Example

```
- hosts: mydocker-host

  vars:
    registrator_service_registry_backend: consul
    registrator_service_registry_host: <consul_host_fqdn|ip>
    registrator_service_registry_port: 8500

  roles:
    - wunzeco.registrator
```


## Testing

To run this role's integration tests

```
kitchen test
```


## Dependencies
none

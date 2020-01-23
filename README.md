# Ansible for TIaaS

Install and configure [TIaaS](https://github.com/usegalaxy-eu/tiaas2).

Requirements
------------

RHEL / Centos7 / Centos6 / Debian & Ubuntu I guess

Role Variables
--------------

```
tiaas_galaxy_db_url: postgres
tiaas_galaxy_idsecret: ""

tiaas_dir: /opt/tiaas
tiaas_user: tiaas
tiaas_group: tiaas
tiaas_version: master
```

Dependencies
------------

Using the Galaxy playbook

Example Playbook
----------------

```
---
- name: UseGalaxy.eu
  hosts: galaxy
  become: true
  become_user: root
  vars:
    tiaas_galaxy_db_url: postgres
    tiaas_galaxy_idsecret: "{{ galaxy_id_secret }}"
    tiaas_dir: /opt/tiaas
    tiaas_user: root
    tiaas_group: root
    tiaas_version: master
  roles:
    - usegalaxy-eu.tiaas
```

License
-------

GPL3

Author Information
------------------

[Helena Rasche](https://github.com/hexylena)

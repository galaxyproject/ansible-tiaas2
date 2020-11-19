# Ansible for TIaaS

Install and configure [TIaaS](https://github.com/usegalaxy-eu/tiaas2).

Requirements
------------

RHEL / Centos7 / Centos6 / Debian & Ubuntu I guess


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
    postgresql_objects_privileges:
    # Allow read-only access users, sessions, and jobs
    - database: galaxy
      roles: tiaas
      objs: galaxy_user,galaxy_session,job
      type: table
      privs: SELECT
    # Permit creating new groups, roles, and associating users to both
    - database: galaxy
      roles: tiaas
      objs: user_group_association,galaxy_group,role,group_role_association
      type: table
      privs: SELECT,INSERT
    # Permit updating the sequences, required to insert into the above tables.
    - database: galaxy
      roles: tiaas
      objs: role_id_seq,galaxy_group_id_seq,group_role_association_id_seq,user_group_association_id_seq
      type: sequence
      privs: USAGE,SELECT

    # TIaaS setup
    tiaas_dir: /opt/tiaas
    tiaas_user: tiaas
    tiaas_group: tiaas
    tiaas_version: master
    tiaas_galaxy_stylesheet: "{{ galaxy_server }}/static/style/base.css"
  roles:
    - natefoo.postgresql_objects
    - usegalaxy-eu.tiaas
```

Your NGINX configuration needs to include something like, none of this is configurable, the role is extremely opinionated 🙃

```
    location /tiaas {
        uwsgi_pass 127.0.0.1:5000;
        uwsgi_param UWSGI_SCHEME $scheme;
        include uwsgi_params;
    }

    location /tiaas/static {
        alias {{ tiaas_dir }}/static;
    }

    location /join-training {
        uwsgi_pass 127.0.0.1:5000;
        uwsgi_param UWSGI_SCHEME $scheme;
        include uwsgi_params;
    }

```

License
-------

GPL3

Author Information
------------------

[Helena Rasche](https://github.com/hexylena)

# Ansible for TIaaS [![Gitter](https://badges.gitter.im/galaxyproject/training-material.svg)](https://gitter.im/galaxyproject/tiaas?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Install and configure [TIaaS](https://github.com/usegalaxy-eu/tiaas2).

Requirements
------------

RHEL / Centos7 / Centos6 / Debian & Ubuntu I guess


Dependencies
------------

Using the Galaxy playbook

---

## Migrating to the new TIaaS

**(October 2022)**

The new TIaaS allows you to customise the site's text content with simple HTML templates. To see what can be customized, check out `galaxyproject.tiaas2/files/html`. The updated Ansible role allows you to override these templates with your own custom content (optional, see steps 2-3).

1. Grab the **updated** Ansible role from `galaxyproject.tiaas2`
2. [Optional] Set the Ansible var `tiaas_templates_dir` to point to a `files` directory containing your TIaaS templates. This directory **must** have the correct structure. Copy the directory from`galaxyproject.tiaas2/files/html` to your `files` directory. Don't use `templates` - we tried that but Jinja chews up the Django template tags. You can then edit these HTML templates to customize your deployment:

  ```yaml
  # vars.yml
  tiaas_templates_dir: tiaas/html
  ```

  ```
  <playbook>/files/tiaas/html/
  ├── about
  │   ├── 1_intro.html
  │   ├── 2_why_tiaas_funding.txt
  │   ├── 3_eligibility.html
  │   └── 4_how_does_it_work.html
  ├── calendar
  │   └── intro.html
  ├── footer.html
  └── register
      ├── 1_intro.html
      ├── 2_about_the_course.html
      ├── 3_resource_usage.html
      ├── 4_advertising.html
      ├── 5_conclusion.html
      └── 6_thanks.html
  ```

3. [Optional] If the above templates reference any static files you can add
these files by setting the Ansible var `tiaas_extra_static_dir`. This should
point to a directory containing your static files. For example, the image in the
default `footer.html` references a static file located at
  `{{ tiaas_extra_static_dir }}/footer/galaxyproject.png`:

  ```html
  <!-- footer.html -->
  <img src="{% static 'footer/galaxyproject.png' %}" />
  ```

4. [optional] There are two more new variables that can be set:
  - `tiaas_show_advertising`: show/hide advertising statement (default `false`)
  - `tiaas_retain_contact_require_consent`: ask for consent to retain contact (default `false`)
    information for additional time

5. One variable has been renamed for clarity:
  - `retain_extra_time` -> `tiaas_retain_contact_extra_months`

6. You should remove these variables from your playbook:
  - `tiaas_version`
  - `tiaas_repo`
  - `tiaas_listen_url`

7. In the nginx conf template, replace your tiaas routes with this variable:
  - `{{ tiaas_nginx_routes }}`

## Using TCP sockets

By default, this role assumes the TIaaS app and the Nginx proxy are running on the same machine, communicating using a Unix socket.

If you prefer to use a TCP socket with the two processes on different machines, you can use a configuration like that;

  ```yaml
    tiaas_socket: 0.0.0.0:5000
    tiaas_socket_bind: "{{ tiaas_socket }}"
    tiaas_socket_listen: "192.168.0.256:5000"  # ip of the machine running tiaas
    tiaas_extra_args: '--forwarded-allow-ips="192.168.0.257"'  # ip of the nginx proxy machine
  ```

---

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
    # Permit disassociating training roles from groups after trainings end
    - database: galaxy
      roles: tiaas
      objs: group_role_association
      type: table
      privs: DELETE
    # Permit updating the sequences, required to insert into the above tables
    - database: galaxy
      roles: tiaas
      objs: role_id_seq,galaxy_group_id_seq,group_role_association_id_seq,user_group_association_id_seq
      type: sequence
      privs: USAGE,SELECT

    # TIaaS setup
    tiaas_dir: /opt/tiaas
    tiaas_user: tiaas
    tiaas_group: tiaas
    tiaas_version: main
    tiaas_galaxy_stylesheet: "{{ galaxy_server_dir }}/static/style/base.css"
  roles:
    - natefoo.postgresql_objects
    - usegalaxy-eu.tiaas
```

Your NGINX configuration needs to include something like this, as we provide default configured routes:

```
    {{ tiaas_nginx_routes }}
```

If you want to reconfigure that, please examine the role, and consider contributing your route template (e.g. for Traefik or Apache2) into the TIaaS role so we can keep them updated.

License
-------

GPL3

Author Information
------------------

[Helena Rasche](https://github.com/hexylena)

#!/bin/bash
. {{ tiaas_dir }}/venv/bin/activate
cd {{ tiaas_dir }}/code/
exec uwsgi --http {{ tiaas_listen_url | default("127.0.0.1:5000") }} --module tiaas.wsgi

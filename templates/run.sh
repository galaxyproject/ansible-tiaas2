#!/bin/bash
. {{ tiaas_venv_dir }}/bin/activate
cd {{ tiaas_dir }}/code/
export PYTHONPATH={{ tiaas_dir }}:$PYTHONPATH
exec uwsgi --socket {{ tiaas_listen_url | default("127.0.0.1:5000") }} --module tiaas.wsgi

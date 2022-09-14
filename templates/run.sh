#!/bin/bash
. {{ tiaas_venv_dir }}/bin/activate
cd {{ tiaas_dir }}/code/
export PYTHONPATH={{ tiaas_dir }}:$PYTHONPATH
exec gunicorn --bind {{ tiaas_listen_url | default("127.0.0.1:5000") }} tiaas.wsgi {% if tiaas_statsd_host %}--statsd-host {{ tiaas_statsd_host }} --statsd-prefix {{ tiaas_statsd_prefix }}{% endif %}

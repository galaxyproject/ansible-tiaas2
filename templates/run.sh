#!/bin/bash
. {{ tiaas_dir }}/venv/bin/activate
exec gunicorn --workers {{ tiaas_workers | default("4") }} --bind {{ tiaas_listen_url | default("127.0.0.1:5000") }} app:app

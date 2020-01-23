GALAXY_SECRET = "{{ id_secret }}"
TIAAS_OWNER = '{{ tiaas_info.owner }}'
TIAAS_EMAIL = '{{ tiaas_info.owner_email }}'
TIAAS_OWNER_SITE = '{{ tiaas_info.owner_site }}'
TIAAS_DOMAIN = '{{ tiaas_info.domain }}'

DEBUG = False

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': {{ tiaas_dir }}/config/db.sqlite3
    },
    'galaxy': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': '{{ tiaas_galaxy_db_name }}',
        'USER': '{{ tiaas_galaxy_db_user }}',
        'PASSWORD': '{{ tiaas_galaxy_db_pass }}',
        'HOST': '{{ tiaas_galaxy_db_host }}',
        'PORT': '{{ tiaas_galaxy_db_port }}',
    }
}

{{ tiaas_other_config }}

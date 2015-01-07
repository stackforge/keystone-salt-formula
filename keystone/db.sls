{%- set name="keystone" %}

{{ name }}-db:
{% if salt["pillar.get"]("keystone:db:driver") == 'postgresql' %}
  pkg.installed:
    - name: python-psycopg2
  postgres_user.present:
    - name: {{ name }}
    - password: {{ salt["pillar.get"](name + ":db:password") }}
  postgres_database.present:
    - name: {{ name }}
    - owner: {{ name }}
{% else %}
  mysql_database.present:
    - name: {{ name }}
  mysql_user.present:
    - name: {{ name }}
    - host: "{{ salt["pillar.get"](name + ":db:host","%") }}"
    - password: {{ salt["pillar.get"](name + ":db:password") }}
  mysql_grants.present:
    - host: "{{ salt["pillar.get"](name + ":db:host","%") }}"
    - grant: all privileges
    - database: "{{ name }}.*"
    - user: {{ name }}
{% endif %}

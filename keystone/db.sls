{%- set name="keystone" %}

{{ name }}-db:
  mysql_database.present:
    - name: {{ name }}
  mysql_user.present:
    - name: {{ name }}
    - host: "{{ salt["pillar.get"](name + ":mysql:host","%") }}"
    - password: {{ salt["pillar.get"](name + ":mysql:password") }}
  mysql_grants.present:
    - host: "{{ salt["pillar.get"](name + ":mysql:host","%") }}"
    - grant: all privileges
    - database: "{{ name }}.*"
    - user: {{ name }}

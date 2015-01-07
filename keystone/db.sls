{%- set name="keystone" %}

{{ name }}-db:
{% if keystone.db.driver == 'postgresql' %}
  postgresql_user.present:
    - name: {{ name }}
    - password: {{ salt["pillar.get"](name + ":db:password") }}
  postgresql_database.present:
    - name: {{ name }}
    - owner: {{ name }}
{% else %}
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
{% endif %}

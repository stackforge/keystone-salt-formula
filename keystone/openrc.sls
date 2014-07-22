{%- from "keystone/map.jinja" import keystone_config with context %}
/root/openrc:
  file.managed:
    - contents: |
        export OS_TENANT_NAME=admin
        export OS_USERNAME=admin
        export OS_PASSWORD={{ salt['pillar.get']('keystone:keystone:admin:password') }}
        export OS_AUTH_URL=http://{{ salt["pillar.get"]("keystone:internal_ip") }}:5000/v2.0/
        export SERVICE_TOKEN='{{ keystone_config.DEFAULT.admin_token }}'
        export SERVICE_ENDPOINT=http://{{ salt["pillar.get"]("keystone:admin_ip") }}:35357/v2.0/
    - template: jinja

{%- from "keystone/map.jinja" import keystone with context %}

/tmp/wait-port.sh:
  file.managed:
    - source: salt://keystone/files/wait-port.sh
    - template: jinja

wait-keystone-port:
  cmd.run:
    - name: /bin/bash /tmp/wait-port.sh 30 {{ salt["pillar.get"]("keystone:admin_ip") }} 35357
    - stateful: True
    - require:
      - file: /tmp/wait-port.sh
    - require_in:
      - keystone: keystone_default_tenants
      - keystone: keystone_default_roles
      - keystone: keystone_keystone_endpoint
      - keystone: keystone_keystone_endpoint

keystone_default_tenants:
  keystone.tenant_present:
    - names:
      - admin
      - service

keystone_default_roles:
  keystone.role_present:
    - names:
      - admin

keystone_admin_user:
  keystone.user_present:
    - name: admin
    - password: {{ salt['pillar.get']('keystone:keystone:admin:password') }}
    - email: {{ salt['pillar.get']('keystone:keystone:admin:email') }}
    - tenant: admin
    - enable: True
    - roles:
      - admin:
        - admin

keystone_keystone_service:
  keystone.service_present:
    - name: keystone
    - service_type: identity
    - description: Openstack Identity Service

keystone_keystone_endpoint:
  keystone.endpoint_present:
    - name: keystone
    - publicurl: http://{{ salt["pillar.get"]("keystone:public_ip") }}:5000/v2.0
    - internalurl: http://{{ salt["pillar.get"]("keystone:internal_ip") }}:5000/v2.0
    - adminurl: http://{{ salt["pillar.get"]("keystone:admin_ip") }}:35357/v2.0

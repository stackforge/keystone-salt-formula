================
Keystone Formula
================

Install and configure the Openstack Keystone service

.. note::
    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``keystone``
------------

Install the keystone and enable the service.

``keystone.db``
---------------

Create the db for keystone service.

``keystone.keystone``
---------------------

Init the tenants, roles, service, endpoint and admin account.

``keystone.server``
-------------------

Install the keystone and enable the service

``keystone.openrc``
-------------------

Add the openrc file

``keystone.client``
-------------------

Add the python-keystoneclient package.

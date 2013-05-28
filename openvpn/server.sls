# Copyright 2012-2013 Hewlett-Packard Development Company, L.P.
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
include:
  - openvpn

/etc/openvpn/dh.pem:
  file:
    - exists

/etc/openvpn/server.conf:
  file.managed:
    - source: salt://openvpn/server.conf
    - template: jinja
    - watch_in:
      - service: openvpn

/etc/openvpn/static:
  file:
    - directory

{% for cn, ip in pillar['openvpn']['clients'].iteritems() %}
/etc/openvpn/static/{{ cn }}:
  file.managed:
    - source: salt://openvpn/static
    - template: jinja
    - context: { ip: {{ ip }} }

{% endfor %}

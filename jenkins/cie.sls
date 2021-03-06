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
  - jenkins.slave

/home/jenkins/.ssh/id_rsa:
  file.managed:
    - user: jenkins
    - group: jenkins
    - mode: 0600
    - require:
      - user: jenkins
    - contents: |
{{ pillar['jenkins_cie_private_key']|indent(8, true) }}

/home/jenkins/.ssh/id_rsa.pub:
  file.managed:
    - user: jenkins
    - group: jenkins
    - mode: 0644
    - require:
      - user: jenkins
    - contents: |
{{ pillar['jenkins_cie_public_key']|indent(8, true) }}

/etc/sudoers.d/20-jenkins:
  file.managed:
    - user: root
    - group: root
    - mode: 0440
    - source: salt://jenkins/sudoers

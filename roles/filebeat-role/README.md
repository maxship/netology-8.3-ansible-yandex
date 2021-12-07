Filebeat role
=========

Роль для установки filebeat на хостах с ОС: Debian, Ubuntu, CentOS, RHEL.

Requirements
------------

Поддерживаются только ОС семейств debian и EL.

Role Variables
--------------

| Variable name | Default | Description |
|-----------------------|----------|-------------------------|
| filebeat_version | "7.14.0" | Параметр, который определяет какой версии filebeat будет установлена |

Example Playbook
----------------
```
# requirements.yml
---
- src: git@github.com:maxship/filebeat-role.git
  scm: git
  version: "2.0.0"
  name: filebeat-role

# site.yml
---
- name: Install Filebeat 
  hosts: all
  roles:
    - filebeat-role
  tags: filebeat
```
License
-------

MIT
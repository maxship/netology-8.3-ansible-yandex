### 8.3 Работа с YandexCloud в Ansible + 8.4 Ansible Roles (ветка ROLES)

Плейбук устанавливает elasticsearch + kibana + filebeats на 3 группы контролируемых хостов: `elasticsearch`, `kibana`, `app`. Для соединения используется ssh, предполагается наличие [сгенерированного](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) на управляющей ноде публичного ключа (расположен в директории `~/.ssh/`).

Для развертывания ВМ в YandexCloud использовался Terraform, все настройки провайдера и создаваемых ресурсов прописаны в файле `terraform/main.tf`. Данные, используемые для подключение к хостам по ssh хранятся на управляющем хосте в `terraform/meta.txt` в виде:

```yml
#cloud-config
users:
  - name: <имя пользователя>
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - <содержимое публичного ключа>
```

---

Создал 2 репозитория [kibana-role](https://github.com/maxship/kibana-role) и [filebeat-role](https://github.com/maxship/filebeat-role).


IP адреса управляемых хостов прописаны в файле `hosts.yml`.

Для каждого сервиса сделан отдельный play в файле `site.yml`, все tasks помечены тегами `elastic`, `kibana`, `filebeats`, соответственно.

Для всех сервисов используется способ установки ПО с помощью менеджера пакетов из файлов формата `.rpm`.

Минимально необходимые настройки для запуска сервисов находятся в файлах шаблонов `elasticsearch.yml.j2`, `kibana.yml.j2`, `filebeat.yml.j2`.







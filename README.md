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

Роли загружены в репозитории Github: [kibana-role](https://github.com/maxship/kibana-role) и [filebeat-role](https://github.com/maxship/filebeat-role).


IP адреса управляемых хостов прописаны в файле `inventory/elk/hosts.yml`.

Используемые роли, требующие предварительной загрузки, прописаны в `requirements.yml`. Пример команды для загрузки ролей в директорию `roles`:

```sh
$ ansible-galaxy install -r requirements.yml -p roles
```

Для каждого сервиса сделан отдельный play в файле `site.yml`, `roles` помечены тегами `elastic`, `kibana`, `filebeats`, соответственно.


ПО устанавливается на управляемые хосты с помощью менеджеров пакетов `yim` или `apt`, в зависимости от установленной на них ОС. Поддерживаемые ОС перечислены в `<role>/vars/main.yml`. 








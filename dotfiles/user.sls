{% from "dotfiles/map.jinja" import dotfiles with context %}

{% set user = dotfiles.user %}

{% if user %}
ensure_user_{{ user.name }}:
  user.present:
    - name: {{ user.name }}
    - shell: {{ user.shell }}
    - home: {{ user.home }}
    - groups:
    {% for group in user.groups %}
      - {{ group }}
    {% endfor %}
{% endif %}

{% if user.ssh.auth_keys %}
install_{{ user.name }}_ssh_key:
  ssh_auth.present:
    - user: {{ user.name }}
    - source: {{ user.ssh.auth_keys }}
    - config: '%h/.ssh/authorized_keys'
{% endif %}

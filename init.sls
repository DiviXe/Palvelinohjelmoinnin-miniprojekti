install_eclipse:
  cmd.run:
    - name: sudo snap install --classic eclipse
    - unless: snap list eclipse

install_java:
  pkg.installed:
    - name: openjdk-17-jdk

install_postman:
  cmd.run:
    - name: sudo snap install postman
    - unless: snap list postman

install_notepadqq:
  pkg.installed:
    - name: notepadqq

install_vscode:
  cmd.run:
    - name: sudo snap install --classic code
    - unless: snap list code

configure_eclipse:
  file.managed:
    - name: /etc/eclipse.ini
    - source: salt://programmerenvironment/eclipse.ini

install_eclipse:
  cmd.run:
    - name: sudo snap install --classic eclipse

install_java:
  pkg.installed:
    - name: openjdk-17-jdk

install_postman:
  cmd.run:
   - name: sudo snap install postman

install_notepadqq:
  pkg.installed:
    - name: notepadqq

install_vscode:
  cmd.run:
    - name: sudo snap install --classic code

configure_eclipse:
  file.managed:
    - name: /etc/eclipse.ini
    - source: salt://programmerenvironment/eclipse.ini

copy_hello_salt:
  file.managed:
    - name: /usr/local/bin/HelloSalt.class
    - source: salt://programmerenvironment/HelloSalt.class
    - mode: "0755"

example_hello_salt:
  cmd.run:
    - name: java -cp /usr/local/bin HelloSalt

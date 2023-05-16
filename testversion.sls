# copy the hello_salt file on minions
copy_hello_salt:
  file.managed:
    - name: /usr/local/bin/HelloSalt.class
    - source: salt://programmerenvironment/HelloSalt.class
    - mode: "0755"

# Certified OpenStack Administrator

These are the course materials, augmented with my notes.

Items missing from the course, that may be on the exam:

* Manage Nova host consoles (rdp, spice, tty)

```
root@controller:~# nova help | fgrep console
console-log                 Get console log output of a server.
get-rdp-console             Get a rdp console to a server.
get-serial-console          Get a serial console to a server.
get-spice-console           Get a spice console to a server.
get-vnc-console             Get a vnc console to a server.
```

* Analyze discrepancies in reported volume sizes

```
http://docs.openstack.org/admin-guide/ts-eql-volume-size.html
```

* Troubleshoot network issues for a tenant network (enter namespace, run
  tcpdump, etc)

## Details


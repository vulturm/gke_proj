## High level design

* Description:
    - We have a generic API service storing users that needs to be deployed in k8s.
    - App built up on Golang and using MySQL as data storage.

---
* Considerations:
    - Golang application:
        - will get it's configuration from environment variables.
        - stateless application.
    - Persistence:
        - Is assured by MySQL RDS engine.
        - PV needs to be claimed and mounted for data persistence.


---
* Deployment flow:
    - Persistance layer:
        - Is being configured first, as this is a prerequsite for the app.
        - PV claim is configured so that it can only be mounted once.
        - MySQL pod is being started using mysql56 docker image with it's `/var/lib/mysql` configured to persist.
    - Golang application:
        - Is compiled as a single statically linked binary without dependencies.
        - Bundled inside a docker image and pushed in GKE image registry.
        - Application pod is configured to use the aforementioned image.



---
* Interractions:
    |PVolume /var/lib/mysql| --> [MySQL Pod TCP 3306] <-- (Service TCP 3306)  <-------------- [App Pod TCP 8080] <-- (Service TCP 80)   <---- [CURL Client/HTTP Calls]

---
* Validation/Tests: 
```
/ # curl --header "Content-Type: application/json" --request POST --data '{"name":"test user 2","age":40}' http://localhost:8080/user
{"id":2,"name":"test user 2","age":40}/ # 
/ # curl --header "Content-Type: application/json" --request POST --data '{"name":"test user 3","age":43}' http://localhost:8080/user
/ # 
/ # 
/ # curl --header "Content-Type: application/json" http://localhost:8080/users
[{"id":1,"name":"test user","age":30},{"id":2,"name":"test user 2","age":40},{"id":3,"name":"test user 3","age":43}]/ # 
/ # curl --header "Content-Type: application/json" http://localhost:8080/user/3
{"id":3,"name":"test user 3","age":43}/ # 
/ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if24: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1460 qdisc noqueue state UP 
    link/ether 0a:58:0a:00:01:15 brd ff:ff:ff:ff:ff:ff
    inet 10.0.1.21/24 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::5832:22ff:fef2:fe30/64 scope link 
       valid_lft forever preferred_lft forever

/ # dmesg 
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.4.111+ (chrome-bot@build12-m2.golo.chromium.org) (gcc version 4.9.x 20150123 (prerelease) (4.9.2_cos_gg_4.9.2-r175-0c5a656a1322e137fa4a251f2ccc6c4022918c0a_4.9.2-r175) ) #1 SMP Fri Aug 10 11:48:29 PDT 2018
[    0.000000] Command line: BOOT_IMAGE=/syslinux/vmlinuz.A init=/usr/lib/systemd/systemd boot=local rootwait ro noresume noswap loglevel=7 noinitrd console=ttyS0 vsyscall=emulate security=apparmor systemd.unified_cgroup_hierarchy=false systemd.legacy_systemd_cgroup_controller=true dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=1 i915.modeset=1 cros_efi root=/dev/dm-0 "dm=1 vroot none ro 1,0 2539520 verity payload=PARTUUID=D849B9BF-F8A5-674F-853E-1293C60A0E50 hashtree=PARTUUID=D849B9BF-F8A5-674F-853E-1293C60A0E50 hashstart=2539520 alg=sha1 root_hexdigest=11f4ef1c066f1ec7b365ce46f6abbfc706d26bd5 salt=0e6efb73ec21091ef6bc72d4af44908e743a59d0101e8f2eab434329f5c2d0b1"
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfffcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfffd000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffbc000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[    0.000000] Hypervisor detected: KVM

```

---
## **License and Authors**

Maintainer:       'Mihai Vultur'<br>
License:          'GPL v3'<br>

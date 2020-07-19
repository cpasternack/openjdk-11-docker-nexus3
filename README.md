## Sonatype Nexus3, openJDK-11

This is a fork of Sonatype's Nexus3 repository manager. This is not intended to be a drop-in replacement, but a tool
that may be useful if you are running openJDK-11, and/or Ansible on CentOS8. You probably don't require Sonatype's
support, because this is a DIY support affair.


## What's changed:

1) CentOS8 base image
2) openJDK-11-headless replaces openJDK-8 (or Oracle JDK 8)
3) Ansible (locally) replaces Chef Solo runtime
4) Some of the nexus files to support openJDK > 9


## Why things have changed:

1) Integration with Jenkins on openJDK-11 with the Nexus repository plugin.
2) The Chef specs were way out of date
3) Nexus3 is a stand-alone instance with not too much integration.
4) For me, Nexus3 runs behind a reverse proxy, and very little integration outside of Jenkins


## What to do to get it working:

- Pull Sonatype/Nexus3 image from Docker Hub
- Copy out files required for ansible/roles/nexus3/files
- Patch files with patches in patches/
- set variables in ansible/roles/nexus3/vars
- build, push to local repo (you are bootstrapping a nexus3 repo with another nexus3 repo, right?)
- replace running nexus3
- test like heck

## What doesn't work:

????? 
Caveat Emptor

## Contributing:

Don't. Please. Ask Sonatype nicely to complete their migration from Java 8 to Java 11.

Fork if you want to hack away.

## License

Apache 2.0, and copyright Sonatype Inc.

Derivative works noted in files

# Prerequisites

## Fork this repository

Because [this project](https://github.com/fullstackjam/k8s-gitops) applies GitOps practices,
it's the source of truth for _my_ homelab, so you'll need to fork it to make it yours:

[Fork fullstackjam/k8s-gitops](https://github.com/fullstackjam/k8s-gitops/fork){ .md-button }

By using this project you agree to [the license](../../reference/license.md).


!!! summary "License TL;DR"

     - This project is free to use for any purpose, but it comes with no warranty
     - You must use the same [GPLv3 license](https://www.gnu.org/licenses/gpl-3.0.en.html)  in `LICENSE.md`
     - You must keep the copy right notice and/or include an acknowledgement
     - Your project must remain open-source

## Hardware requirements

### Initial controller

!!! info

    The initial controller is the machine used to bootstrap the cluster, we only need it once, you can use your laptop or desktop

- A Linux machine that can run Docker (because the `host` networking driver used for PXE boot [only supports Linux](https://docs.docker.com/network/host/), you can use a Linux virtual machine with bridged networking if you're on macOS or Windows).

### Servers

Any modern `x86_64` computer(s) should work, you can use old PCs, laptops or servers.

!!! info

    This is the requirements for _each_ node

| Component  | Minimum                                                                                                      | Recommended                                                                                  |
| :--        | :--                                                                                                          | :--                                                                                          |
| CPU        | 2 cores                                                                                                      | 4 cores                                                                                      |
| RAM        | 8 GB                                                                                                         | 16 GB                                                                                        |
| Hard drive | 128 GB                                                                                                       | 512 GB (depending on your storage usage, the base installation will not use more than 128GB) |
| Node count | 1 | 3 or more for high availability                                                              |

### Network setup

- All servers must be connected to the same **wired** network with the initial controller
- You have the access to change DNS config (on your router or at your domain registrar)

## Domain

Buying a domain is highly recommended.

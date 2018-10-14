[//]: # (Describe the project's purpose.)


## gke_proj - Golang APP

* The `gke_proj` project goal is to automate the provisioning of a golang app in GKE.


---
* Cloud prerequisites:
    - Google cloud account with kubernetes cluster.

---
* Software prereq (installed by the project):
    - The project will install locally the following prereq:
        - kubectl
        - docker
        - golang

---
* Software prereq(needed to be installed manually):
    - `gcloud cli` from google cloud sdk is also required.
        - More info: https://cloud.google.com/sdk/docs/quickstart-linux

---
* Assumptions:
    - The project assumes that `gcloud` is already present and configured to communicate with google account.
    - `kubectl` configured to authenticate to the kubernetes cluster
    - `Docker` configured to use google container registry.

---
* User configuration:
    - `PROJECT_NAME` variable in `Makefile` has to be modified to correspond with the project name from GKE.

---
* Usage:
    - `make all` - Completes all required steps to deploy `golang app`, `mysql instance`, `services` and `PV`.
    - `make prereq` - Assures prerequisites are in place. Will install them if not. Sudo password is required for this.
    - `make mysql` - Creates DB instance and seeds data into it.
    - `make deploy` - Builds `golang` app, bundles it in a docker image, push in registry, and deploy in `k8s`.

* *Note: this should be executed from a username that has sudo privileges. Sudo access will be required to install prerequisites.*

---
## **License and Authors**

Maintainer:       'Mihai Vultur'<br>
License:          'GPL v3'<br>

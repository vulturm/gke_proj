### Pros and Cons

* PROS: 
    - The automation scripts implement the necessary bits that would permit a developer to start the service in GKE with as few as possible actions.
        - It takes care of the prerequisites installation and it creates the required kubernetes entities for our stateful and stateless pods.
    - The source code, configuration files and automation scripts were organised in a intuitive directory layout.
    - `Alpine Linux` was used in order to make the deployment image thin and unbloated.
    - Ansible community developed playbooks were leveraged in order to leverage community effort and avoid maintenance burden.
    - `GNU Make` was used as it is present on most distros and allows creating simple argumented commands with minimum of code.
    - PV was configured to only be possible to be mounted once so that other pod couldn't corrupt the data.
    - Choosen solution is generic enough that could be easily adapted/developed to handle the deployment of more complex stateful and stateless applications in k8s.
    - Source code was versioned using SCM, in order to facilitate collaboration and history tracking.
    - The entire workflow is `idempotent`.

* CONS:
    - Too many technologies for such a simple application:
        - In order to implement the automation, the Infra dev would have to have knowledge of: docker/containers, kubernetes/kubectl cli, GKE/gcloud cli, GNU make, ansible, bash.
        - But, the choosen solution is generic enough so that it could be used for more complex projects (see the corresonding note from `PROS`).


---
## **License and Authors**

Maintainer:       'Mihai Vultur'<br>
License:          'GPL v3'<br>

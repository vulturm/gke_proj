## Possible improvement ideas:

* Infra:
    - Creation of KGE project and kubernetes cluster.
    - Automation for the installation of gcloud cli.
    - Possibly replace kubectl invocations with ansible resources.
    - Configuration of kubectl and docker to integrate with gcloud cli.
    - Automatic detection of `PROJECT_NAME` variable.
    - Check if `prerequsites` are already installed and not ask for sudo if not required.

* DevOps/CI:
    - Implement per environment specific configuration.
    - Use of Secrets/Encrypted credentials to implement separation of duties.
    - Artefact/image promotion from one environment to another.
    - Deploy validation.
    - Implement automatic scaling.
    - Create CI pipeline using Jenkins or similar.

* App/Dev:
    - Create small test harness.
    - Stop using environment variables to pass in configuration to application.
    - Implement schema migration/versioning.

---
## **License and Authors**

Maintainer:       'Mihai Vultur'<br>
License:          'GPL v3'<br>

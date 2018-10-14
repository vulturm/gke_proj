[//]: # (Describe the project's purpose.)


## gke_proj - Golang APP

The `gke_proj` project goal is to automate the provisioning of a golang app in GKE.



Cloud prerequisites:
Google cloud account with kubernetes cluster.


Software prereq (installed by the project):
The project will install locally the following prereq:
- kubectl
- docker
- golang

Software prereq(needed to be installed manually):
gcloud from google cloud sdk is also required, but due to lack of time, installation of this package wasn't automated.
More info: https://cloud.google.com/sdk/docs/quickstart-linux


Assumptions:
* The project assumes that gcloud is already present and configured to communicate with google account.
* kubectl configured to authenticate to the kubernetes cluster
* Google Container Registry API is enabled in Cloud Console at https://console.cloud.google.com/apis/api/containerregistry.googleapis.com/overview?project=example-cluster-1 before performing this operation.
* Docker configured to use google container registry.

`PROJECT_NAME` variable in `Makefile` has to be modified to correspond with the project name from GKE.



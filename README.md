<p align="center">
  <img src="https://raw.githubusercontent.com/PKief/vscode-material-icon-theme/ec559a9f6bfd399b82bb44393651661b08aaf7ba/icons/folder-markdown-open.svg" width="100" alt="project-logo">
</p>
<p align="center">
    <h1 align="center">K8S_GITLAB</h1>
</p>
<p align="center">
    <em>Unlock DevOps magic, deploy effortlessly with k8s_gitlab.</em>
</p>
<p align="center">
	<img src="https://img.shields.io/github/license/magicalbob/k8s_gitlab?style=default&logo=opensourceinitiative&logoColor=white&color=0080ff" alt="license">
	<img src="https://img.shields.io/github/last-commit/magicalbob/k8s_gitlab?style=default&logo=git&logoColor=white&color=0080ff" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/magicalbob/k8s_gitlab?style=default&color=0080ff" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/magicalbob/k8s_gitlab?style=default&color=0080ff" alt="repo-language-count">
<p>
<p align="center">
	<!-- default option, no dependency badges. -->
</p>

<br><!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary><br>

- [ Overview](#-overview)
- [ Features](#-features)
- [ Repository Structure](#-repository-structure)
- [ Modules](#-modules)
- [ Getting Started](#-getting-started)
  - [ Installation](#-installation)
  - [ Usage](#-usage)
  - [ Tests](#-tests)
- [ Project Roadmap](#-project-roadmap)
- [ Contributing](#-contributing)
- [ License](#-license)
- [ Acknowledgments](#-acknowledgments)
</details>
<hr>

##  Overview

The k8s_gitlab project orchestrates the deployment of GitLab on Kubernetes, streamlining the setup process and ensuring seamless access to GitLab services. It includes scripts to create the necessary Kubernetes resources, manage persistent storage for PostgreSQL, and handle port forwarding for user-friendly access. By automating deployment tasks and optimizing resource utilization, k8s_gitlab simplifies the integration of GitLab into Kubernetes environments, enhancing scalability and developer productivity.

---

##  Features

|    |   Feature         | Description |
|----|-------------------|---------------------------------------------------------------|
| ⚙️  | **Architecture**  | The project follows a Kubernetes-based architecture for deploying GitLab. It includes configurations for PostgreSQL, Kubernetes Kind cluster, services for HTTP and SSH traffic, and persistent volumes to store data. |
| 🔩 | **Code Quality**  | The codebase demonstrates good quality with clear structure and naming conventions. Proper comments and documentation help in understanding the code easily. |
| 📄 | **Documentation** | The project includes detailed documentation for setting up and deploying GitLab on Kubernetes. It covers various aspects like cluster configuration, service deployment, and persistent volume management. |
| 🔌 | **Integrations**  | Key integrations include Kubernetes for orchestration, PostgreSQL for data storage, and systemd units for port forwarding. External dependencies include necessary Kubernetes resources and services. |
| 🧩 | **Modularity**    | The codebase is modular with separate files for different components like deployment configurations, storage classes, and installation scripts. This modularity enhances reusability and maintainability. |
| 🧪 | **Testing**       | Testing frameworks and tools are not explicitly mentioned in the provided details. Additional information is needed to determine the testing approach used in the project. |
| ⚡️  | **Performance**   | The project focuses on efficient resource usage by defining resource requirements for GitLab containers and ensuring smooth operation with persistent volumes. However, detailed performance metrics are not provided. |
| 🛡️ | **Security**      | Security measures like access control and data protection are not explicitly discussed in the provided details. Additional information is needed to evaluate the security aspects of the project. |
| 📦 | **Dependencies**  | Key external libraries and dependencies include services, templates, shell scripts, and configurations related to Kubernetes, GitLab, and PostgreSQL. These dependencies are essential for the project's functionality. |
| 🚀 | **Scalability**   | The project demonstrates scalability by leveraging Kubernetes for container orchestration. It can potentially handle increased traffic and load by scaling resources and containers as required. |

---

##  Repository Structure

```sh
└── k8s_gitlab/
    ├── gitlab.deploy.yml
    ├── gitlab.postgres.pv.kind.yml.template
    ├── gitlab.postgres.pv.linux.yml.template
    ├── gitlab.postgres.yml
    ├── init-gitlab.sh
    ├── install-gitlab.sh
    ├── kind-config.yml.template
    ├── local-storage-class.yml
    ├── postgres-data
    │   └── .keep.in.git
    └── systemd
        ├── port8022.service
        └── port8080.service
```

---

##  Modules

<details closed><summary>.</summary>

| File                                                                                                                                | Summary                                                                                                                                                                                                                               |
| ---                                                                                                                                 | ---                                                                                                                                                                                                                                   |
| [init-gitlab.sh](https://github.com/magicalbob/k8s_gitlab/blob/master/init-gitlab.sh)                                               | Creates GitLab namespace, deploys GitLab, waits for successful deployment, ensures GitLab is running on port 80, and forwards deployment for access. Manages port-forwarding to GitLab deployment with automatic relaunch on failure. |
| [gitlab.postgres.yml](https://github.com/magicalbob/k8s_gitlab/blob/master/gitlab.postgres.yml)                                     | Defines PostgreSQL deployment for GitLab, including PersistentVolumeClaim, Deployment, Service, and ConfigMap. Manages storage, environment variables, container configuration, and networking aspects for the PostgreSQL database.   |
| [gitlab.deploy.yml](https://github.com/magicalbob/k8s_gitlab/blob/master/gitlab.deploy.yml)                                         | Deploys GitLab application with a single pod and services for HTTP and SSH traffic. Specifies resource requirements and configuration settings for GitLab container.                                                                  |
| [kind-config.yml.template](https://github.com/magicalbob/k8s_gitlab/blob/master/kind-config.yml.template)                           | Defines Kubernetes Kind cluster configuration with a custom mount for Postgres data in the `postgres-data` directory.                                                                                                                 |
| [gitlab.postgres.pv.kind.yml.template](https://github.com/magicalbob/k8s_gitlab/blob/master/gitlab.postgres.pv.kind.yml.template)   | Defines a template for a PersistentVolume in Kubernetes to store GitLab PostgreSQL data with a capacity of 10Gi, ReadWriteOnce access mode, and local-storage storage class. Supports nodeAffinity based on the specified node name.  |
| [gitlab.postgres.pv.linux.yml.template](https://github.com/magicalbob/k8s_gitlab/blob/master/gitlab.postgres.pv.linux.yml.template) | Defines persistent volume for GitLabs PostgreSQL data, specifying 10Gi storage, Retain policy, ReadWriteOnce access, and local storage class. Utilizes node affinity to connect to a specific Kubernetes node matching the hostname.  |
| [local-storage-class.yml](https://github.com/magicalbob/k8s_gitlab/blob/master/local-storage-class.yml)                             | Implements a StorageClass configuration named local-storage to enable immediate volume binding. Essential for efficient storage provisioning in the Kubernetes environment of the k8s_gitlab repository.                              |
| [install-gitlab.sh](https://github.com/magicalbob/k8s_gitlab/blob/master/install-gitlab.sh)                                         | Determines Kubernetes cluster availability, creates Kind cluster if needed, installs components, sets up storage, deploys GitLab services, ensuring smooth operation with persistent volumes.                                         |

</details>

<details closed><summary>postgres-data</summary>

| File                                                                                            | Summary                                                                                 |
| ---                                                                                             | ---                                                                                     |
| [.keep.in.git](https://github.com/magicalbob/k8s_gitlab/blob/master/postgres-data/.keep.in.git) | Maintains directory structure integrity by ensuring tracking of empty directory in Git. |

</details>

<details closed><summary>systemd</summary>

| File                                                                                              | Summary                                                                                                                                                                                                |
| ---                                                                                               | ---                                                                                                                                                                                                    |
| [port8022.service](https://github.com/magicalbob/k8s_gitlab/blob/master/systemd/port8022.service) | Enables port forwarding for 8022 to GitLab via Kubectl, ensuring seamless network connectivity and user-friendly access for multi-user targets.                                                        |
| [port8080.service](https://github.com/magicalbob/k8s_gitlab/blob/master/systemd/port8080.service) | Enables port forwarding for GitLab service to local machine on port 8080. systemd unit ensures automatic restart on failure. Facilitates easy access to GitLab services running in Kubernetes cluster. |

</details>

---

##  Getting Started

**System Requirements:**

* **None**: `version x.y.z`

###  Installation

<h4>From <code>source</code></h4>

> 1. Clone the k8s_gitlab repository:
>
> ```console
> $ git clone https://github.com/magicalbob/k8s_gitlab
> ```
>
> 2. Change to the project directory:
> ```console
> $ cd k8s_gitlab
> ```
>
> 3. Install the dependencies:
> ```console
> $ > INSERT-INSTALL-COMMANDS
> ```

###  Usage

<h4>From <code>source</code></h4>

> Run k8s_gitlab using the command below:
> ```console
> $ > INSERT-RUN-COMMANDS
> ```

###  Tests

> Run the test suite using the command below:
> ```console
> $ > INSERT-TEST-COMMANDS
> ```

---

##  Project Roadmap

- [X] `► INSERT-TASK-1`
- [ ] `► INSERT-TASK-2`
- [ ] `► ...`

---

##  Contributing

Contributions are welcome! Here are several ways you can contribute:

- **[Report Issues](https://github.com/magicalbob/k8s_gitlab/issues)**: Submit bugs found or log feature requests for the `k8s_gitlab` project.
- **[Submit Pull Requests](https://github.com/magicalbob/k8s_gitlab/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.
- **[Join the Discussions](https://github.com/magicalbob/k8s_gitlab/discussions)**: Share your insights, provide feedback, or ask questions.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your github account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/magicalbob/k8s_gitlab
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to github**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details closed>
<summary>Contributor Graph</summary>
<br>
<p align="center">
   <a href="https://github.com{/magicalbob/k8s_gitlab/}graphs/contributors">
      <img src="https://contrib.rocks/image?repo=magicalbob/k8s_gitlab">
   </a>
</p>
</details>

---

##  License

This project is protected under the [SELECT-A-LICENSE](https://choosealicense.com/licenses) License. For more details, refer to the [LICENSE](https://choosealicense.com/licenses/) file.

---

##  Acknowledgments

- List any resources, contributors, inspiration, etc. here.

[**Return**](#-overview)

---

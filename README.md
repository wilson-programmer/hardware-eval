# hardware-eval
## Assessing the impact of Intel hardware features on xen and the KVM hypervisor 


### Overview

**HaEvol** is a benchmark suite designed to facilitate analysis of the impact of features integrated by Intel into their hardware (CPU, NIC, etc.) on the performance of two of the most widespread hypervisors on the market, namely Xen and KVM. To simulate the conditions of a cloud platform, experiments were carried out on [Grid'5000](https://www.grid5000.fr/w/Grid5000:Home) which is a large-scale and flexible testbed for experiment-driven research in all areas of computer science, with a focus on parallel and distributed computing including Cloud, HPC and Big Data and AI.

### How to proceed 

- List all the features integrated by Intel on their processors to improve the performance of virtualization systems since 2007.
- Acquire all hypervisor versions from the one in which the first hardware feature (EPT) was integrated.
- extract a correspondence between Xen and KVM hypervisor versions, from which each Intel feature has been taken into account by the hypervisor
- Target the Intel processors that support each hardware feature
- Determine a set of micro and macro benchmarks to be run on each version of each hypervisor (just over 100 versions for Xen)
- Analyze results

### HaEvol functionalities

To facilitate our study, we developed the HaEvol tool.

**HaEvol allows:**

1. For each hardware feature, you can obtain a list of all Intel server processors that support it.
2. For each hardware feature, you can obtain a list of the Xen versions on which it is supported.
3. Automatically create and deploy multiple VMs on a server.
4. Launch benchmarks (Apche Bench, Unix Bench, FIO, Redis, etc.) in each VM.
5. Retrieve benchmark results.
6. Analyze these results.
 

**NB**: To better assess the impact, we run each benchmark several times in each VM.

The different scenarios can represent:
    
- **Variation in the number of VMs**
- **Variation in the CPU load of each VM**
- **Variation in the amount of memory allocated to each VM** 
- **The number of applications to run in a VM**

All these parameters are supplied as parameters to our tool. 

### Hardware feature

In this study, we consider the hardware features introduced by Intel since 2007 to enhance virtualization functionalities. The study does not deal with network-related features (VMDQ and SRIOV). 

| Feature | Meaning                          |
|---------|----------------------------------|
| **EPT**     | Extended Page Tables             |
| **VMDQ**    | Virtual Machine Device Queues    |
| **VPID**    | Virtual Processor Identification |
| **SRIOV**   | Single Root I/O Virtualization   |
| **PML**     | Page Modification Logging        |
| **CMT**     | Cache Monitoring Technology      |
| **CAT**     | Cache Allocation Technology      |
| **CDP**     | Code Data and prioritization     |
| **MBM**     | Memory Bandwidth Monitoring      |
| **MBA**     | Memory Bandwidth Allocation      |
| **SPP**     | Sub Page Protection              |

<!-- ## Pré-réquis

Afin de pouvoir exécuter les différents scénarios de **HaEvol**, il faut s'assuser de la présence de:
- mongodb
- pymongo
-->


<!-- ## Get Intel processors

Nous avons collecter l'ensemble des processeurs Intel afin de pouvoir filtrer pour chaque feature les processeurs qui la supporte. Ce travail préliminaire nous a également permis de pouvoir sélectionner sur [Grid'5000](https://www.grid5000.fr/w/Grid5000:Home) l'ensemble des processeurs Intel compatibles à chaque feature. 
Le notebook [Scrape Intel Ark.ipynb](https://gitlab.inria.fr/WIDE/hardware_evol_hypervisor/-/blob/main/Scrape%20Intel%20Ark.ipynb) contient le code nécessaire à la collecte, le netoyage des données sur les processeurs Intel. Il contient également la liste des processeurs pour chaque feature matérielle.  -->


    

<!-- 
## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.inria.fr/WIDE/hardware_evol_hypervisor.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.inria.fr/WIDE/hardware_evol_hypervisor/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Set auto-merge](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thanks to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README

Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
-->




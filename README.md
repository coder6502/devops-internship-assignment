# devops-internship-assignment
# Cloud-Native DevOps & Microservices Deployment Project

This project demonstrates how to take a modern web application, wrap it inside a secure container, automate its testing and deployment, and manage it inside a cloud Kubernetes environment. It covers the full lifecycle of a modern software application.

---

## Architectural Workflow Overview

Here is how the entire system connects together:

[ Developer Commit/Merge ] ---> [ GitHub Actions CI Pipeline ] ---> [ DockerHub Registry ]
                                                                             |
                                                                             v
[ Centralized Observability ] <--- [ Amazon EKS Cluster ] <----------- [ CD Deployment ]
(CloudWatch / Prometheus)           (2x App Replicas)

---

## Part 1: Advanced Version Control (Git Strategy)

### 1. The Core Difference: `git fetch` vs `git pull`
* **`git fetch`**: This is like checking the mailbox. It downloads the latest changes and updates from the remote repository (GitHub) to your local computer, but it **does not** touch or change any of your current working files. It is 100% safe to run at any time.
* **`git pull`**: This is like opening the mail and immediately applying it. It runs `git fetch` to grab the changes, and then immediately runs `git merge` to force those changes into your active local code. If someone else changed the same file, this can cause a conflict right away.

### 2. How to Resolve Git Merge Conflicts
A merge conflict happens when two people modify the exact same line of code in the same file. Git gets confused and stops the merge, asking a human to decide which line to keep.
**How to fix it:**
1. Run `git status` to see exactly which files are broken.
2. Open the conflicted file. You will see markers like `<<<<<<<` (your changes) and `>>>>>>>` (their changes) separated by `=======`.
3. Read the lines, delete the version you don't want, and keep the good code.
4. Delete the mechanical markers entirely.
5. Save the file, run `git add <filename>`, and type `git commit -m "Resolved merge conflict"` to finish.

### 3. Simulation Workflow (How to break and fix it)
To prove how conflicts work, the following terminal commands were executed:
```bash
# 1. Create a base file on the main branch
echo "Baseline Source Configuration" > system.config
git add system.config && git commit -m "Initialize core configuration"

# 2. Make a branch called Feature-A and change line 1
git checkout -b feature-A
echo "Feature-A Environment Adjustments" > system.config
git commit -am "Apply feature-A enhancements"

# 3. Go back to main, make a branch called Feature-B, and change line 1 to something else
git checkout main
git checkout -b feature-B
echo "Feature-B Pipeline Optimization" > system.config
git commit -am "Apply feature-B optimization"

# 4. Try to merge Feature-A into Feature-B. This instantly breaks!
git merge feature-A 

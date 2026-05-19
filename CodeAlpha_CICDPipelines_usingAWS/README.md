# CodeAlpha DevOps — Task 1: CI/CD Pipeline on AWS

A fully automated CI/CD pipeline built on AWS, covering containerization, continuous integration, deployment, and monitoring.

---

## 🛠 Tech Stack

| Component | Service |
|---|---|
| CI/CD Orchestration | AWS CodePipeline |
| Build & Test | AWS CodeBuild |
| Container Registry | Amazon ECR |
| Deployment | AWS App Runner |
| Monitoring | Amazon CloudWatch |
| Source Control | GitHub |

---

## 🏗 Architecture

```
GitHub (push to main)
        │
        ▼
AWS CodePipeline
        │
        ├── Source   →  GitHub Repository
        ├── Build    →  CodeBuild (Docker build + push to ECR)
        └── Deploy   →  App Runner (auto-pulls from ECR)
                │
                ▼
        CloudWatch (logs + alerts)
```

---

## 📁 Project Structure

```
CodeAlpha_CICDPipeline/
├── app.js
├── package.json
├── Dockerfile
├── buildspec.yml
└── README.md
```

---

## ⚙️ Setup & Deployment

### Prerequisites

- AWS CLI v2 configured (`aws configure`)
- Docker installed
- GitHub account
- Node.js 18+

---

### Phase 1 — Application

A simple Node.js/Express web server containerized with Docker.

- Entry point: `app.js`
- Exposed port: `3000`
- Containerized via `Dockerfile` using `node:18-alpine`

---

### Phase 2 — Amazon ECR

Container registry used to store and version Docker images.

- Repository name: `codealpha-web-app`
- Region: `us-east-1`
- Images tagged as `:latest` on every successful build

---

### Phase 3 — AWS CodeBuild

Handles the automated build process on every push to `main`.

Defined in `buildspec.yml` with three phases:

| Phase | Actions |
|---|---|
| pre_build | Authenticate Docker to ECR |
| build | Build and tag Docker image |
| post_build | Push image to ECR, output `imagedefinitions.json` |

> CodeBuild requires **Privileged mode** enabled to run Docker commands.

---

### Phase 4 — AWS App Runner

Managed deployment service — equivalent to Azure App Service.

- Pulls the latest image directly from ECR
- Auto-deploys on every new image push
- Exposes the app via a public HTTPS URL
- CPU: 0.25 vCPU / Memory: 0.5 GB

---

### Phase 5 — AWS CodePipeline

Orchestrates the full pipeline end-to-end.

| Stage | Provider | Action |
|---|---|---|
| Source | GitHub | Triggers on push to `main` via webhook |
| Build | CodeBuild | Runs `buildspec.yml`, pushes image to ECR |
| Deploy | App Runner | Detects new ECR image, redeploys automatically |

---

### Phase 6 — CloudWatch Monitoring

- Build logs streamed to `/aws/codebuild/codealpha-build`
- App logs streamed to `/aws/apprunner/codealpha-web-service`
- SNS email alerts configured on pipeline failure
- Alarms set for both failed and successful pipeline executions

---

## 🔁 How It Works

1. Developer pushes code to the `main` branch
2. GitHub webhook triggers CodePipeline automatically
3. CodeBuild builds a new Docker image and pushes it to ECR
4. App Runner detects the new image and performs a zero-downtime redeploy
5. CloudWatch logs all activity and sends alerts on failure

---

## 🔗 Resources

- [AWS CodePipeline Docs](https://docs.aws.amazon.com/codepipeline/)
- [AWS CodeBuild Docs](https://docs.aws.amazon.com/codebuild/)
- [Amazon ECR Docs](https://docs.aws.amazon.com/ecr/)
- [AWS App Runner Docs](https://docs.aws.amazon.com/apprunner/)
- [Amazon CloudWatch Docs](https://docs.aws.amazon.com/cloudwatch/)

---

## 👤 Author

**Your Name**  
DevOps Intern — CodeAlpha  
GitHub: [@your-username](https://github.com/your-username)  
LinkedIn: [linkedin.com/in/your-profile](https://linkedin.com/in/your-profile)

---

*CodeAlpha Internship Program 
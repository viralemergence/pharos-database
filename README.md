<h1 align="center">
  Pharos Database
</h1>

## 🔗 Pharos Repositories:

The Pharos project is split into three repositories:

| Repository        | Purpose                                            | Link                                                                                           |
| ----------------- | -------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `pharos-frontend` | Frontend application and deployment infrastructure | [github.com/viralemergence/pharos-frontend](https://github.com/viralemergence/pharos-frontend) |
| `pharos-api`      | API and deployment infrastructure                  | [github.com/viralemergence/pharos-api](https://github.com/viralemergence/pharos-api)           |
| `pharos-database` | SQL database and deployment infrastructure         | [github.com/viralemergence/pharos-database](https://github.com/viralemergence/pharos-database) |

## 🚀 Deployment Status

| Branch | CI/CD Status                                                                                                                                                                                                                                           |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Prod   | [![CircleCI](https://dl.circleci.com/status-badge/img/circleci/39PL8myokkHY7obZPJeFEC/Cr5VZbHxzAnKKxeDWwJBR7/tree/prod.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/circleci/39PL8myokkHY7obZPJeFEC/Cr5VZbHxzAnKKxeDWwJBR7/tree/prod) |

## 👩‍💻 Overview

This repository is not necessary for local development. For local
pharos database setup instructions see
[github.com/viralemergence/pharos-api](https://github.com/viralemergence/pharos-api).

This repository contains the SAM ([AWS Serverless Application Model](https://aws.amazon.com/serverless/sam/))
template which orchistrates the Postgres RDS instance and networking containing all Pharos databases.

The RDS instance and networking is shared across all pharos environments
(`dev`, `review`, `staging`, and `prod`) as well as individual developer
environments for development and testing.

This template also sets up the networking, permissions, and demonstrates
how to allow direct database access from whitelisted IP addresses if
direct database access is necessary for admin tasks.

All changes to the database infrastructure must be done by committing to
this repository; changes committed to this repository in the `prod` branch
will be automatically applied to the production environment via SAM in CircleCI.

## 🏙️ Infrastructure Overview Diagram

![Overview diagram](https://github.com/viralemergence/pharos-database/blob/prod/img/pharos-database-highlevel.png)

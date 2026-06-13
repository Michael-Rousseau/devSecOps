# DEUSDashboard

This project was generated using [Angular CLI](https://github.com/angular/angular-cli) version 20.3.10.

## Infrastructure (AWS Academy Learner Lab)

Full architecture is documented in `docs/rapport`. Quick operational reference below.

### Variable injection

Terraform modules (`terraform/modules/*`) are environment-agnostic: every environment-specific value is a variable. The dev environment (`terraform/environments/dev`) injects everything:

- Non-secret values: `terraform/environments/dev/terraform.tfvars`
- Secrets: environment variables — `export TF_VAR_db_password=...` and `export TF_VAR_nasa_api_key=...` (CI uses GitHub Secrets and passes them with `-var`)

### Per-session checklist (Learner Lab credentials expire every ~4h)

1. Refresh AWS credentials: `scripts/update-aws-keys.sh` (and update GitHub Secrets for CI)
2. `terraform -chdir=terraform/environments/dev apply`
3. Update `ansible/inventory/hosts.ini` with current IPs (`terraform output bastion_public_ip`, ECS/monitoring private IPs)
4. Configure hosts:

```bash
cd ansible
ansible-playbook playbooks/site.yml
ansible-playbook playbooks/monitoring.yml \
  -e "alb_dns_name=$(terraform -chdir=../terraform/environments/dev output -raw alb_dns_name)" \
  -e "grafana_admin_password=$GRAFANA_ADMIN_PASSWORD"
```

### Replacement risks (terraform apply destroys/recreates the resource)

| Value | Resource replaced if changed |
|---|---|
| `db_name` | RDS instance (data loss) |
| `public_subnet_cidrs` / `private_subnet_cidrs` | Subnets and everything inside |
| DynamoDB `hash_key` | Cache table |
| AMI data sources (`most_recent = true`) | Bastion / monitoring instance whenever Amazon publishes a new AL2023 AMI — stateless, re-run ansible afterwards |

### Learner Lab constraints (intentional deviations)

- Single `LabRole` IAM role everywhere (custom IAM forbidden)
- S3 public-read website hosting instead of CloudFront + OAC (CloudFront/ACM unavailable)
- HTTP-only ALB (no ACM certificate)
- `my_ip_cidr = 0.0.0.0/0` for bastion/Grafana (client IPs rotate); restrict to `<ip>/32` outside the lab

## Development server

To start a local development server, run:

```bash
ng serve
```

Once the server is running, open your browser and navigate to `http://localhost:4200/`. The application will automatically reload whenever you modify any of the source files.

## Code scaffolding

Angular CLI includes powerful code scaffolding tools. To generate a new component, run:

```bash
ng generate component component-name
```

For a complete list of available schematics (such as `components`, `directives`, or `pipes`), run:

```bash
ng generate --help
```

## Building

To build the project run:

```bash
ng build
```

This will compile your project and store the build artifacts in the `dist/` directory. By default, the production build optimizes your application for performance and speed.

## Running unit tests

To execute unit tests with the [Karma](https://karma-runner.github.io) test runner, use the following command:

```bash
ng test
```

## Running end-to-end tests

For end-to-end (e2e) testing, run:

```bash
ng e2e
```

Angular CLI does not come with an end-to-end testing framework by default. You can choose one that suits your needs.

## Additional Resources

For more information on using the Angular CLI, including detailed command references, visit the [Angular CLI Overview and Command Reference](https://angular.dev/tools/cli) page.

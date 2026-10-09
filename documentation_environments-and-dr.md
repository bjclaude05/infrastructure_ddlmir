# Environments and Disaster Recovery (reference design)

| Environment | Purpose | Data | Access | Change control |
|---|---|---|---|---|
| Development | Developers build and unit-test | Synthetic | Developers | None |
| Testing / UAT | Integration and user acceptance | Masked copy | Testers, business | Release ticket |
| Production | Live service | Real | Operations only | Approved change, rollback plan |
| Disaster Recovery | Standby at a second site | Replicated | Operations | Mirrors production |

## Upgrade path (Java 21, Spring Boot 3.5)
1. Build the target runtime on Development (`install_java21.sh`, `create_app_user.sh`, `myapp.service`).
2. Promote the same scripts to Testing, run regression and performance checks.
3. Rehearse the production cut-over and the rollback (`tools/automation/deploy.sh`).
4. Release to Production in a maintenance window, then rebuild DR from the same scripts.

## DR principles
- Targets agreed with the system owner (example: RTO 4 h, RPO 24 h).
- Backups copied off-site and restore-tested monthly.
- Failover and recovery drills at least twice a year with a written result.
- Runbook: `tools/recovery/recovery-procedure.md`.

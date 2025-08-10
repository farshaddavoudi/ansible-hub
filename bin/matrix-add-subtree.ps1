#!/usr/bin/env pwsh

Set-Location ../

Write-Host "Adding the entire matrix-docker-ansible-deploy project as a subtree..."
git subtree add --prefix=matrix/matrix-docker-ansible-deploy `
  https://github.com/spantaleev/matrix-docker-ansible-deploy.git `
  master --squash
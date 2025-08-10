#!/usr/bin/env pwsh
Set-Location ../

Write-Host "Updating Matrix deploy to latest version, using matrix-docker-ansible-deploy git repo ..."
git subtree pull --prefix=matrix/matrix-docker-ansible-deploy `
  https://github.com/spantaleev/matrix-docker-ansible-deploy.git `
  master --squash


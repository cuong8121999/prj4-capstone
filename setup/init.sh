#!/bin/bash
set -e -o pipefail

echo "Fetching IAM github-action-user ARN"
userarn=$"(aws iam get-user --user-name github-action-user | jq -r .User.Arn)"

# Download tool for manipulating aws-auth
echo "Downloading tool..."
brew install aws-iam-authenticator

echo "Updating permissions"
aws-iam-authenticator add user --userarn="arn:aws:iam::245310611731:user/github-action-user" --username=github-action-user --groups=system:masters --kubeconfig="$HOME"/.kube/config --prompt=false

echo "Cleaning up"
rm aws-iam-authenticator
echo "Done!"
#!/usr/bin/env bash
set -euo pipefail

REPO="Michael-Rousseau/DEUS_Dashboard"

echo "=== DEUS Dashboard — AWS Learner Lab Key Rotation ==="
echo ""
echo "Paste your Learner Lab credentials (from AWS Details > Show):"
echo ""

read -rp "AWS_ACCESS_KEY_ID: " AWS_ACCESS_KEY_ID
read -rp "AWS_SECRET_ACCESS_KEY: " AWS_SECRET_ACCESS_KEY
read -rp "AWS_SESSION_TOKEN: " AWS_SESSION_TOKEN

echo ""
echo "[1/2] Updating ~/.aws/credentials ..."
mkdir -p ~/.aws
cat > ~/.aws/credentials <<EOF
[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
aws_session_token = ${AWS_SESSION_TOKEN}
EOF

echo "  Done."

echo ""
read -rp "Update GitHub Secrets too? (y/N): " UPDATE_GH

if [[ "${UPDATE_GH}" =~ ^[Yy]$ ]]; then
    echo "[2/2] Updating GitHub Secrets for ${REPO} ..."
    echo "${AWS_ACCESS_KEY_ID}" | gh secret set AWS_ACCESS_KEY_ID --repo "${REPO}"
    echo "${AWS_SECRET_ACCESS_KEY}" | gh secret set AWS_SECRET_ACCESS_KEY --repo "${REPO}"
    echo "${AWS_SESSION_TOKEN}" | gh secret set AWS_SESSION_TOKEN --repo "${REPO}"
    echo "  GitHub Secrets updated."
else
    echo "[2/2] Skipping GitHub Secrets."
fi

echo ""
echo "Keys updated. They expire in ~4 hours."
echo "Verify: aws sts get-caller-identity"

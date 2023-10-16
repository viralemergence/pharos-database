# Command used to deploy or update the database stack

# --rofile needs to be an AWS Profile in the Verena
# account with  developer-level permissions

sam deploy \
  --config-env prod \
  --template-file ./template.yaml \
  --no-confirm-changeset \
  --no-fail-on-empty-changeset \
  --profile verena-prod-dev


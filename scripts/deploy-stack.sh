sam deploy \
  --config-env prod \
  --template-file ./template.yaml \
  --no-confirm-changeset \
  --no-fail-on-empty-changeset \
  --profile verena-prod-dev


#!/bin/bash
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
LIME_YELLOW=$(tput setaf 190)
YELLOW=$(tput setaf 3)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)

while [[ "$#" > 0 ]];
  do case $1 in
    -p|--profile) profile=$2; shift;;
    -d|--database) database=$2; shift;;
    -o|--output) output=$2; shift;;
    *) echo "Unknown parameter passed: $1"; exit 1 ;;
  esac
  shift
done

echo ""
if [ "$profile" != "" ]; then
  echo "AWS Profile: ${YELLOW}${BRIGHT}$profile${NORMAL}"
else
  echo "${RED}AWS Profile required${NORMAL}"
  exit 1
fi

if ! [ -x "$(command -v /opt/homebrew/opt/postgresql@15/bin/pg_dump)" ]; then
  echo -e "\n${RED}${BRIGHT}DEPENDENCY ERROR${NORMAL}"
  echo "pg_dump for postgres@15 not found in"
  echo -e "${YELLOW}/opt/homebrew/opt/postgres@15/bin/${NORMAL}\n"
  echo -e "${RED}This convenience script depends on postgresql@15"
  echo -e "installed on an apple silicone mac via:${NORMAL}\n"
  echo -e "\$ ${YELLOW}brew install postgres@15${NORMAL}\n"
  exit 1
fi

secret=`aws secretsmanager get-secret-value \
  --secret-id pharos-database-DBAdminSecret \
  --region us-east-2 \
  --profile $profile \
  | jq -r .SecretString \
  | jq`

PGHOST=`echo $secret | jq -r .host`
PGPORT=`echo $secret | jq -r .port`
PGUSER=`echo $secret | jq -r .username`
PGPASSWORD=`echo $secret | jq -r .password`

echo ""
echo "Host: ${GREEN}${BRIGHT}$PGHOST${NORMAL}"
echo "Port: ${GREEN}${BRIGHT}$PGPORT${NORMAL}"
echo "Username: ${GREEN}${BRIGHT}$PGUSER${NORMAL}"

PGPASSWORD=$PGPASSWORD \
  /opt/homebrew/opt/postgresql@15/bin/pg_dump -h $PGHOST -p $PGPORT -U $PGUSER -Fc $database > $output


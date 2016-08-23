
YOUR_HOSTED_ZONE_HERE="Z48PQXNQ2JS53"

case "$1" in
  "clean_challenge")
    altname="$2"
    challenge_token="$3"
    keyauth_hook="$4"
    /home/letsencrypt/.env/bin/aws route53 change-resource-record-sets --hosted-zone-id $YOUR_HOSTED_ZONE_HERE --change-batch "{\"Changes\":[{\"Action\":\"DELETE\",\"ResourceRecordSet\":{\"Name\":\"_acme-challenge.${altname}\",\"Type\":\"TXT\",\"TTL\":60,\"ResourceRecords\":[{\"Value\":\"\\\"${keyauth_hook}\\\"\"}]}}]}"
    ;;
  "deploy_challenge")
      altname="$2"
      challenge_token="$3"
      keyauth_hook="$4"

      /home/letsencrypt/.env/bin/aws route53 change-resource-record-sets --hosted-zone-id $YOUR_HOSTED_ZONE_HERE --change-batch "{\"Changes\":[{\"Action\":\"UPSERT\",\"ResourceRecordSet\":{\"Name\":\"_acme-challenge.${altname}\",\"Type\":\"TXT\",\"TTL\":60,\"ResourceRecords\":[{\"Value\":\"\\\"${keyauth_hook}\\\"\"}]}}]}"
      sleep 20
    ;;
  "deploy_cert")
    domain="$2"
    private_key="$3"
    cert="$4"
    chain="$5"

    sudo /usr/sbin/service nginx reload
    # NO-OP
    ;;
esac



import requests
import os
from datetime import datetime
import json

NAME_DOT_COM_USER = os.environ["TF_VAR_name_dot_com_user"]
NAME_DOT_COM_TOKEN = os.environ["TF_VAR_name_dot_com_token"]
SLACK_WEBHOOK = os.environ.get("SLACK_WEBHOOK", "")


def main():
    url = "https://api.name.com/v4/domains"
    res = requests.get(url, auth=(NAME_DOT_COM_USER, NAME_DOT_COM_TOKEN))

    issues = []
    for domain in res.json()["domains"]:
        domain_name = domain["domainName"]
        expected_tf = f"sld/records.{domain_name}.tf"
        expire_date_str = domain["expireDate"]
        parsed_expire_date = datetime.strptime(expire_date_str, "%Y-%m-%dT%H:%M:%SZ")
        if parsed_expire_date > datetime.now():
            if not os.path.exists(expected_tf):
                issues.append(f"Terraform records file '{expected_tf}' not found")
        
        days_until_expiration = (parsed_expire_date - datetime.now()).days
        if days_until_expiration <= 30:
            issues.append(f"The domain '{domain_name}' expires in {days_until_expiration} days")

    if len(issues) > 0:
        print("Found issue(s):")
        for issue in issues:
            print(issue)
        
            if SLACK_WEBHOOK != "":
                payload = {
                    "attachments": [
                        {
                            "title": "Domain Alert",
                            "text": issue,
                            "fields": [
                                {
                                    "title": "Action Required",
                                    "value": "Please take action on the name.com domain",
                                    "short": False
                                }
                            ],
                            "footer": "Domain Monitor",
                            "ts": int(datetime.now().timestamp())
                        }
                    ]
                }
                res = requests.post(
                    SLACK_WEBHOOK,
                    data=json.dumps(payload),
                    headers={'Content-Type': 'application/json'}
                )
                res.raise_for_status()
            else:
                print("Warning: Webhook url not provided")
        
        exit(1)
    else:
        print("No issues found!")

if __name__ == "__main__":
    main()
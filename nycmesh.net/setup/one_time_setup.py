import csv
import requests
import os

DOMAIN = os.environ["TF_VAR_name_dot_com_domain"]
NAME_DOT_COM_USER = os.environ["TF_VAR_name_dot_com_user"]
NAME_DOT_COM_TOKEN = os.environ["TF_VAR_name_dot_com_token"]

OUTPUT_TF = "../records.tf"
OUTPUT_SH = "import.sh"

class OneTimeSetup:
    def get_records(self, domain_name):
        ret = []
        per_page = 1000
        url = f"https://api.name.com/v4/domains/{domain_name}/records?perPage={per_page}"
        res = requests.get(url, auth=(NAME_DOT_COM_USER, NAME_DOT_COM_TOKEN))
        ret.extend(res.json()["records"])
        while res.json().get("nextPage", None) is not None:
            next_page = res.json()["nextPage"]
            url = f"https://api.name.com/v4/domains/{domain_name}/records?perPage={per_page}&page={next_page}"
            res = requests.get(url, auth=(NAME_DOT_COM_USER, NAME_DOT_COM_TOKEN))
            ret.extend(res.json()["records"])
        return ret

    def one_time_setup(self):
        with open(OUTPUT_TF, "w") as fdtf:
            with open(OUTPUT_SH, "w") as fdsh:
                for item in self.get_records(DOMAIN):
                    tf, sh = self.generate_resource(item)
                    fdtf.write(tf)
                    fdsh.write(sh)
            

    def generate_resource(self, row):
        print(row)
        record_id = row["id"]
        host = row.get("host", "")
        record_type = row["type"]
        answer = row["answer"]
        resource_name = f"record_{host}_{record_id}"
        tf = f"""
resource "namedotcom_record" "{resource_name}" {{
    domain_name = "{DOMAIN}"
    host = "{host}"
    record_type = "{record_type}"
    answer = "{answer}"
}}
"""
        sh = f"terraform import namedotcom_record.{resource_name} {DOMAIN}:{record_id}\n"
        return tf, sh

if __name__ == "__main__":
    ots = OneTimeSetup()
    ots.one_time_setup()

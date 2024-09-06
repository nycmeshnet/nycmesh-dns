# SLD One Time Setup

## GitHub Repository Setup

1. Obtain your [name dot com API key](https://www.name.com/account/settings/api).
2. Set the secret `TF_VAR_name_dot_com_user` to your name dot com username.
3. Set the secret `TF_VAR_name_dot_com_token` to your name dot com token.
4. Setup a s3 bucket (or similar) based on your needs for state storage. For s3, follow the terraform [instructions](https://developer.hashicorp.com/terraform/language/settings/backends/s3#s3-bucket-permissions). Set the secret `BUCKET_TF_STATE` to the bucket name.
5. Set the secrets `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

## Initial Setup (Existing Domain)

Complete the following from your  local machine. These steps should work on linux with python3 + pip installed.

1. Clone this repository.
2. Setup a python environment:
```
cd setup
python3 -m venv venv
source venv/bin/activate
pip install requests
```
3. Obtain your [name dot com API key](https://www.name.com/account/settings/api).
4. Obtain your `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` (as above).
5. Update `main.tf` with your bucket information (`backend` configuration).
6. Execute the one time setup:
```
export TF_VAR_name_dot_com_domain="nycmesh.net"
export TF_VAR_name_dot_com_user="theactualvalue"
export TF_VAR_name_dot_com_token="theactualvalue"
export BUCKET_TF_STATE="yourbucketname"
export AWS_ACCESS_KEY_ID="theactualvalue"
export AWS_SECRET_ACCESS_KEY="theactualvalue"
python3 one_time_setup.py
```
7. Inspect the generated `../records.${TF_VAR_name_dot_com_domain}.tf`, compare it to your domain in the name dot com UI. Make manual corrections as needed.
8. Inspect the generated `import.${TF_VAR_name_dot_com_domain}.sh`. Make manual corrections as needed.
9. Execute `cd ..`
10. Execute `terraform init -backend-config="bucket=$BUCKET_TF_STATE"`
11. Execute `bash setup/import.${TF_VAR_name_dot_com_domain}.sh`
12. Execute `terraform plan`
13. Execute `terraform apply`

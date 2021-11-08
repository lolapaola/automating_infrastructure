/*
    author: Paola A. Buitrago @lolapaola
    credit: Joel W. King  @joelwking

    usage:

      To refresh the state, use the `terraform refresh` command. A tutorial on state can be found
      at https://www.terraform.io/docs/state/index.html

      To prevent the `access_key` and `secret_key` from being exposed in the public repo, these
      values are defined in the file `credentials_backend` and excluded from publishing by inclusion
      in the `.gitignore` file.

      To specify the values for these keys, issue `terraform init -backend-config=credentials_backend`.
      Once initialized, the credentials are stored in the directory `.terraform`. This directory should
      also be included in the `.gitignore` file.

      The `credentials_backend` file is in the form:

        access_key =  "12345"
        secret_key =  "12345"

    references:
      - https://www.terraform.io/docs/backends/types/s3.html
      - https://www.terraform.io/docs/backends/config.html
      - https://gitlab.com/joelwking/terraform_aci

*/

terraform {
  backend "s3" {
    bucket = "terraformlola"
    key    = "projects/lola/state.tfstate"    # Path to the state file inside the S3 Bucket
    region = "us-east-1"
    # access_key = "12345"                  # specified in file credentials_backend
    # secret_key = "12345"                  # specified in file credentials_backend
  }
}

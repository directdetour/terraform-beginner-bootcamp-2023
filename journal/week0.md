# Terraform Beginner Bootcamp 2023 - Week 0

## Table of Contents
- [Terraform Beginner Bootcamp 2023](#terraform-beginner-bootcamp-2023)
  * [Semantic Versioning :mage:](#semantic-versioning--mage-)
  * [Installing Terraform CLI](#installing-terraform-cli)
    + [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
    + [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Considerations for the Linux Distribution](#considerations-for-the-linux-distribution)
      - [Checking OS version](#checking-os-version)
      - [Using Shebang](#using-shebang)
      - [Execution Considerations](#execution-considerations)
      - [Linux permissions Considerations](#linux-permissions-considerations)
    + [Gitpod Lifecycle (Before, Init, Command)](#gitpod-lifecycle-before-init-command)
    + [Working with Env Vars](#working-with-env-vars)
      - [env command](#env-command)
      - [Setting and unsetting Env Vars](#setting-and-unsetting-env-vars)
      - [Printing env vars](#printing-env-vars)
    + [Scoping of env vars](#scoping-of-env-vars)
      - [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
    + [AWS CLI Installation](#aws-cli-installation)
  * [Terraform Basics](#terraform-basics)
    + [Terraform Registry](#terraform-registry)
    + [Terraform Console](#terraform-console)
      - [Terraform Init](#terraform-init)
      - [Terraform Plan](#terraform-plan)
      - [Terraform Apply](#terraform-apply)
      - [Terraform Destroy](#terraform-destroy)
      - [Terraform Lock Files](#terraform-lock-files)
      - [Terraform State Files](#terraform-state-files)
      - [Terraform Directory](#terraform-directory)
  * [Issues with Terraform Cloud login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)
      - [Workaround](#workaround)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Semantic Versioning :mage:

**Add Semantic Versioning Documentation to Project**
We want to document semantic versioning in our project.

The project will utilize semantic versioning for its tagging [semver.org](https://semver.org/)

general format: **MAJOR.MINOR.PATCH** eg `1.0.1`

Given a version number MAJOR.MINOR.PATCH, increment the:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Installing Terraform CLI

### Considerations with the Terraform CLI changes
The terraform Install instructions changed due to gpg keyring changes, so the original yaml for gitpod terraform installation has to be modified. Referring to the most recent install instructions: [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Refactoring into Bash Scripts
While fixing install issues, we decided the installation steps were too long for the yml file and moved script into its own file.

bash script location - [./bin/install_terraform_cli](./bin/install_terrafrom_cli)

- Keeps Gitpod Task File [.gitpod.yml](.gitpod.yml) tidy.
- Allows easier debug and manual execution of the Terraform CLI install
- Allows better portability for other projects that need to install Terraform CLI.

### Considerations for the Linux Distribution

#### Checking OS version
This project is built using Ubuntu.
Please consider checking your linux distribution and change according to your needs.
[Check linux OS version](https://www.geeksforgeeks.org/how-to-check-the-os-version-in-linux/#)

Example - checking OS version
```
$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```



#### Using Shebang

A Shebang (pronounced Sha-bang) tells the system which program will interpret the script.

https://en.wikipedia.org/wiki/Shebang_(Unix)


chatGPT recommended `#!/usr/bin/env bash`
- for portability bewteen different OS distros
- will search the user's PATH for the bash executable


#### Execution Considerations
When executing the bash script we can use the `./` shorthand to execute the script.

eg. `./bin/install_terraform_cli`

If using it in gitpod.yml, must use source.

eg. `source ./bin/install_terraform_cli`

#### Linux permissions Considerations


https://en.wikipedia.org/wiki/Chmod


making bash script executable using chmod 

eg. 
```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```

### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using init because it will not rerun if  we restart an existing workspace

https://www.gitpod.io/docs/configure/workspaces/tasks


### Working with Env Vars

#### env command

We can list out all enironment variables using the `env` command

We can filter specific env vars using grep `env | grep AWS_`

#### Setting and unsetting Env Vars

In the terminal we can set using   `export HELLO='world'`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env var without writing export eg.

```sh
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```

#### Printing env vars
We can print an env var using `echo` eg `echo $HELLO`

### Scoping of env vars

When opening new bash terminals in VS Code it will not be aware of Env Vars that you have set in another terminal. For persistant env vars, add them to your bash profile `.bash_profile`

#### Persisting Env Vars in Gitpod

We can store these in Gitpod Secrets Storage

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive data values.

### AWS CLI Installation

AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check our AWS credentials are correctly configured by using this command:

```sh
aws sts get-caller-identity
```

If that is successful, you should see a json payload return that looks like this:

```json
{
    "UserId": "ABABABABABABABABABABA",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials and IAM user in order to use the AWS CLI



## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry [registry.terraform.io](https://registry.terraform.io/)

- Providers: interface to APIs that will allow you to create resources in Terraform
- Modules: a way to make Terraform code modular, portable and shareable.

### Terraform Console

We can list all Terraform commands by typing `terraform`

#### Terraform Init
`terraform init` initializes a Terraform working directory. It downloads and installs any necessary plugins and modules, preparing the environment for Terraform configuration.

#### Terraform Plan
`terraform plan` generates an execution plan. It analyzes the current state of infrastructure and configuration files to provide a preview of changes that will be applied when using Terraform Apply.

#### Terraform Apply
`terraform apply` applies the changes specified in the Terraform configuration. It creates, modifies, or deletes infrastructure resources according to the execution plan generated by Terraform Plan. (prompts yes or no, apply `--auto-approve` flag to override)

#### Terraform Destroy
`terraform destroy` will destroy resources. `--auto-approve` is also available for this command.


#### Terraform Lock Files
`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project

- This should be committed to your Version Source Control (VSC) eg. Github

#### Terraform State Files
`terraform.tfstate` contains information about the current state of your infrastructure

- This file **Should Not** be committed to your Version Source Control (VSC) eg. Github
- This file can containt sensitive data
- If you lose this file you lose the known state of your infrastructure

#### Terraform Directory
`.terraform` directory contains binaries of Terraform providers.


## Issues with Terraform Cloud login and Gitpod Workspace

`terraform login` attempts to launch a wysiwyg view to generate a token, this is not compatible with gitpod and vscode in the browser.

#### Workaround
Manually generate a new token at https://app.terraform.io/app/settings/tokens

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json 
open /home/gitpod/.terraform.d/credentials.tfrc.json 
```
Provide the following code using the new token value

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "RFAI7I3uxXw6zQ.atlasv1.qxwrvndcbYGhsJwwEXAMPLEEXAMPLEEXAMPLEEXAMPLEEXAMPLE"      
    }
  }
}

```

This has been automated using a bash script [./bin/generate_tfrc_credentials](./bin/generate_tfrc_credentials)
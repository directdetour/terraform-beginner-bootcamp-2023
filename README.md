# Terraform Beginner Bootcamp 2023


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
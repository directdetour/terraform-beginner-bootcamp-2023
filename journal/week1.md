# Terraform Beginner Bootcamp 2023 - Week 1


## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

The var-file flag is used in Terraform to specify a JSON or HCL (HashiCorp Configuration Language) file containing input variables for a configuration. This flag allows you to separate your variable definitions from the main configuration files, making it easier to manage and reuse variable values across different environments or deployments.

Usage:

```bash
terraform apply -var-file=myvars.tfvars
```

In the example above, myvars.tfvars is the name of the variable file that contains the variable definitions. When you apply your Terraform configuration, Terraform will read the variable values from this file and use them during the execution.

Note: Ensure that the variable file is in the appropriate JSON or HCL format and contains the necessary variable declarations to avoid errors during the Terraform run.

### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

### auto.tfvars

The `auto.tfvars` file is a special configuration file used in Terraform to automatically load variable values when working with Terraform Cloud. This file allows you to set default values for your variables, making it easier to work with your Terraform configurations in a cloud environment.

**Functionality:**

The auto.tfvars file is used in Terraform Cloud to automatically load variable values without requiring manual input during the execution of Terraform configurations. This file is automatically processed by Terraform Cloud when it detects its presence in the working directory, allowing you to set default values for your variables.

**Usage:**

1. Create an `auto.tfvars` file in your Terraform configuration directory.

2. Define variable assignments in the `auto.tfvars` file using the following format:

   ```hcl
   variable_name = "variable_value"
   ```
When running Terraform in Terraform Cloud, it will automatically read and apply the variable values from auto.tfvars.

This functionality is particularly useful for storing sensitive or default values securely, ensuring that your Terraform Cloud runs are consistent and streamlined.




### order of terraform variables

Terraform variables follow a specific order of precedence when their values are assigned. Understanding this order is essential for managing and overriding variable values effectively:

1. **Environment Variables:**
    - Environment variables take the highest precedence. You can set Terraform variables using environment variables in your shell session. For example, `TF_VAR_variable_name` will override the value of `variable_name` defined in your configuration.

2. **Terraform Configuration Files:**
    - Values defined directly in Terraform configuration files (`.tf` or `.tf.json`) have precedence over default values. These values are part of your configuration and can be customized for different environments.

3. **Variable Files (`*.tfvars`):**
    - Variable files allow you to separate variable definitions from your main configuration. These files are used to assign values to variables, and their values override the defaults set in configuration files.

4. **Command-Line Flags:**
    - When running Terraform commands, you can use command-line flags like `-var` or `-var-file` to provide variable values. These flags take precedence over values defined in configuration files and variable files.

5. **Defaults in Variable Declarations:**
    - If none of the above sources provide a value for a variable, Terraform will use the default value specified in the variable declaration within your configuration file. Defaults are used when no other value is available.

By understanding this order of precedence, you can effectively manage and override Terraform variable values to suit your specific use cases and environments.

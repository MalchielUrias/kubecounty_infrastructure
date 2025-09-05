# AWS IAM Module

This module wraps the official [terraform-aws-modules/iam/aws](https://github.com/terraform-aws-modules/terraform-aws-iam) module for creating IAM roles and policies.

## Usage

```hcl
module "aws_iam" {
  source = "../../modules/aws-iam"

  iam_role_name      = "example-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  policy_name        = "example-policy"
  policy_description = "Example policy for demonstration."
  policy             = data.aws_iam_policy_document.example.json
}
```

## Variables

| Name                | Description                                         | Type   |
|---------------------|-----------------------------------------------------|--------|
| iam_role_name       | Name of the IAM role to create.                     | string |
| assume_role_policy  | The policy that grants an entity permission to assume the role. | string |
| policy_name         | Name of the IAM policy.                             | string |
| policy_description  | Description of the IAM policy.                      | string |
| policy              | The policy document.                                | string |

## Outputs

| Name      | Description                |
|-----------|----------------------------|
| role_name | The name of the IAM role.  |
| role_arn  | The ARN of the IAM role.   |

## Reference

See the [terraform-aws-iam module documentation](https://github.com/terraform-aws-modules/terraform-aws-iam) for advanced usage and additional options.

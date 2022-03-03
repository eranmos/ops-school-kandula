#############
# cognito   #
#############

/*
# Create an IAM role for the auto-join
resource "aws_iam_role" "unauth_role" {
  name               = "Cognito_KandulaKibanaUnauth_Role"
  assume_role_policy = file("${path.module}/policies/Cognito_KandulaKibanaUnauth_Role.json")
  tags               = local.common_tags
}

resource "aws_iam_role" "auth_role" {
  name               = "Cognito_KandulaKibanaAuth_Role"
  assume_role_policy = file("${path.module}/policies/Cognito_KandulaKibanaAuth_Role.json")
  tags               = local.common_tags
}
*/


########### resources for cognito identity_pool creation ###############
resource "aws_cognito_identity_pool" "kandula_kibana" {
  identity_pool_name               = var.project_name
  allow_unauthenticated_identities = true
  allow_classic_flow               = false

  tags = local.common_tags
}

########### resources for cognito user_pool creation ###################
resource "aws_cognito_user_pool" "kandula_kibana" {
  name = "${var.project_name}-kibana"

  password_policy {
    minimum_length = "7"
    require_lowercase = false
    require_numbers   = true
    require_symbols   = false
    require_uppercase = false
    temporary_password_validity_days = "4"
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  tags = local.common_tags
}

resource "aws_cognito_user_group" "kandula_admin" {
  name         = "kandula_admin"
  user_pool_id = aws_cognito_user_pool.kandula_kibana.id
  description  = "This Group id for kandula admin users"
}

resource "aws_cognito_user_pool_ui_customization" "kandula_kibana" {
  user_pool_id = aws_cognito_user_pool.kandula_kibana.id
  image_file = filebase64("KandulaLogo.jpg")
}

/*
resource "aws_cognito_user" "kandula_kibana" {
  user_pool_id = aws_cognito_user_pool.kandula_kibana.id
  username     = "eranmos"

  attributes = {
    temporary_password = "12345678"
    phone_number   = "+972508256413"
    phone_number_verified = false
    terraform      = true
    foo            = "bar"
    email          = "eranmos@hashicorp.com"
    email_verified = false
  }
}
*/

resource "aws_cognito_user_pool_domain" "kandula_kibana" {
  user_pool_id    = aws_cognito_user_pool.kandula_kibana.id
  domain          = "kandula-kibana"
}
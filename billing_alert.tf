# SNS Topic for Billing Alerts
resource "aws_sns_topic" "billing_alerts" {
  name = "billing-alerts-topic"
}

# SNS Topic Subscription for Email
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol  = "email"
  endpoint  = "kottagundu-kumar.sri-sai@capgemini.com"  # Replace with your email address
}

# AWS Budget for Monthly Cost Alerts
resource "aws_budgets_budget" "monthly_budget" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "20"      # Monthly threshold limit in USD
  limit_unit        = "USD"
  time_unit         = "MONTHLY"  # Budget is tracked on a monthly basis

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "FORECASTED"
    threshold           = 100
    threshold_type      = "PERCENTAGE"
    subscriber_sns_topic_arns = [aws_sns_topic.billing_alerts.arn]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold           = 90
    threshold_type      = "PERCENTAGE"
    subscriber_sns_topic_arns = [aws_sns_topic.billing_alerts.arn]
  }
}

# AWS Budget for Weekly Cost Alerts
resource "aws_budgets_budget" "weekly_budget" {
  name              = "weekly-budget"
  budget_type       = "COST"
  limit_amount      = "5"      # Set a weekly threshold (e.g., $25 for 4 weeks of a $100 monthly budget)
  limit_unit        = "USD"
  time_unit         = "MONTHLY"  # We use monthly with weekly alerts based on cost incurred in that week

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold           = 5    # Set to trigger when actual costs exceed $25 in a week
    threshold_type      = "ABSOLUTE_VALUE"  # Use absolute value for weekly alerts
    subscriber_sns_topic_arns = [aws_sns_topic.billing_alerts.arn]
  }
}

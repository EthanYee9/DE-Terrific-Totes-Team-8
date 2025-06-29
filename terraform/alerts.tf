# Extract alarm 
resource "aws_sns_topic" "lambda_extract_alerts" {
  name = "lambda-extract-alerts"
}

resource "aws_sns_topic_subscription" "extract_email_alert" {
  topic_arn = aws_sns_topic.lambda_extract_alerts.arn
  protocol  = "email"
  endpoint  = "example@gmail.com" 
}

resource "aws_cloudwatch_metric_alarm" "lambda_extract_error_alarm" {
  alarm_name          = "lambda-extract-error-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Triggers on any error in extract Lambda"
  alarm_actions       = [aws_sns_topic.lambda_extract_alerts.arn]

  dimensions = {
    FunctionName = aws_lambda_function.extract_lambda.function_name
  }
}

# Transform alarm 
resource "aws_sns_topic" "lambda_transform_alerts" {
  name = "lambda-transform-alerts"
}

resource "aws_sns_topic_subscription" "transform_email_alert" {
  topic_arn = aws_sns_topic.lambda_transform_alerts.arn
  protocol  = "email"
  endpoint  = "example@gmail.com" 
}

resource "aws_cloudwatch_metric_alarm" "lambda_transform_error_alarm" {
  alarm_name          = "lambda-transform-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Triggers on any error in transform Lambda"
  alarm_actions       = [aws_sns_topic.lambda_transform_alerts.arn]

  dimensions = {
    FunctionName = aws_lambda_function.transform_lambda.function_name
  }
}

#Load alarm - 
resource "aws_sns_topic" "lambda_load_alerts" {
  name = "lambda-load-alerts"
}

resource "aws_sns_topic_subscription" "load_email_alert" {
  topic_arn = aws_sns_topic.lambda_load_alerts.arn
  protocol = "email"
  endpoint = "example@gmail.com"
}

resource "aws_cloudwatch_metric_alarm" "lambda_load_error_alarm" {
  alarm_name          = "lambda-load-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Triggers on any error in load Lambda"
  alarm_actions       = [aws_sns_topic.lambda_load_alerts.arn]

  dimensions = {
    FunctionName = aws_lambda_function.load_lambda.function_name
  }
}

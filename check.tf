check "check_budget_exceeded" {
  data "aws_budgets_budget" "example" {
    name = aws_budgets_budget.example.name
  }
 
  assert {
    condition = !data.aws_budgets_budget.example.budget_exceeded
    error_message = format("AWS budget has been exceeded! Calculated spend: '%s' and budget limit: '%s'",
                 data.aws_budgets_budget.example.calculated_spend[0].actual_spend[0].amount,
      data.aws_budgets_budget.example.budget_limit[0].amount
      )
  }
}
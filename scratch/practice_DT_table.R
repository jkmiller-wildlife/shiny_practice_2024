# load packages ---- 
library(DT)

# checkboxGroupInput(  inputId,
#label,
#choices = NULL,
#selected = NULL,
#inline = FALSE,
#width = NULL,
#choiceNames = NULL,
#choiceValues = NULL)

years_df <- penguins %>%
  filter(year %in% c(2007:2008))

DT::datatable(years_df)

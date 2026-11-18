library(shiny)
LEAPDisplay <- navbarPage(
  title = "LEAP Data Display",
  
  navbarMenu(
  title = "Effects on Relative Intensity of Peanut Allergy", 
          tabPanel("Age at Cessation of Breast Feeding", value = "int.BF"),
           tabPanel("Number of Foods in Diet at 3 months of Age", value = "int.num.foods"),
           tabPanel("Number of cigarettes smoked in the house per week", value = "int.num.cigs")),
navbarMenu(
  title = "Factors That Affect Occurrence of Allergy",
  tabPanel("Age at Cesation of Breast Feeding", value = "occ.BF"),
  tabPanel("Number of Foods in Diet at 3 months of Age", value = "occ.num.foods"),
  tabPanel("Number of cigarrtes smoked in the house per week", value = "occ.num.cigs"))
)

LEAPWork <- function(input, output, session)
{
  
}
           
shinyApp(LEAPDisplay,LEAPWork)
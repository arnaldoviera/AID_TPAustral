#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


##setear directorio de trabajo



##install.packages("rsconnect")
##library(shiny)
##library(tidyverse)
##library(rsconnect)
##library(readr)
##resultado <- read_delim("app2/resultado.txt","\t", escape_double = FALSE, locale = locale(encoding = "ISO-8859-1"), trim_ws = TRUE)


interfaz <- fluidPage(
    
    titlePanel("TP Final - Grupo 4"),
    
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput(
                inputId = "MiLista",
                label = "Banda a Visualizar",
                choices = c("Serú Girán", "Sui Generis", "Charly García", "PorSuiGieco", "La Máquina de Hacer Pájaros", "Billy Bond and The Jets"),
                selected = "Serú Girán")
        ),
        mainPanel(
            plotOutput("MiGrafico")
        )
    )
)




MiServer <- function(input, output) {
    
    output$MiGrafico <- renderPlot({
        
        resultado %>% filter(album_artist %in% input$MiLista) %>% 
            ggplot(aes(x = album_artist, y = energy, fill = album_artist)) +
            geom_bar(stat = "identity") +
            facet_wrap(~ album_artist) +
            scale_fill_manual(values = c("yellow", "green")) +
            ylab("% Energy") +
            theme(legend.position = "none",
                  axis.text = element_text(size = 10))
    })
}

shinyApp(ui = interfaz, server = MiServer)

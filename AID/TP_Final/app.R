
##limiar ambiente de trabajo
rm(list =ls())

##setear directorio de trabajo
setwd("C:/Users/vieraa/Documents/AID_TPAustral/AID/TP_Final")
WD <- getwd()


## importación archivo correcto de tarea 1

count

##Codigobase de la clase 7

interfaz <- fluidPage(
  
  titlePanel("TP Final - Grupo 4"),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "MiLista",
        label = "Banda a Visualizar",
        choices = c("Serú Girán", "Sui Generis", "Charly Garcia", "PorSuiGieco", "La Máquina de Hacer Pájaros", "Billy Bond and The Jets"),
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
      scale_fill_manual(values = c("red", "green")) +
      ylab("% danc") +
      theme(legend.position = "none",
            axis.text = element_text(size = 10))
  })
}

shinyApp(ui = interfaz, server = MiServer)
#Importamos la librería shiny
library(shiny)

#Definimos la interfaz para mostrar un histograma de ejemplo
ui <- fluidPage(
    
    #Creamos el título de la aplicación
    titlePanel("Histograma"),
    
    #Plantilla que incluye un panel lateral y un panel central más grande
    sidebarLayout(
        
        #Panel lateral dónde tendremos un deslizador
        sidebarPanel(
            
            #Deslizador que nos permitirá variar el número de cajas del histograma
            #min y max nos delimita los valores minimos y máximos del delizador, y value el valor por defecto
            sliderInput(inputId = "bins",
                        label = "Número de cajas:",
                        min = 3,
                        max = 15,
                        value = 3)
            
        ),
        
        #Panel central para mostrar el histograma
        mainPanel(
            
            #Visualización a mostrar, en este caso un histograma
            plotOutput(outputId = "distPlot")
            
        )
    )
)

#Creamos un vector aleatorio de 1000 elementos fuera de la funcion server
#para que no se recalcule de nuevo cada vez que cambiamos el valor con el deslizador
times <- rpois(n = 1000, lambda = 5)

#Función que renderiza el histograma de forma dinámica
server <- function(input, output) {
    #Renderizamos en tiempo real el histograma "distPlot"
    output$distPlot <- renderPlot({
        
        #Creamos las variables que pasaremos al histograma. Valores x e intervalos
        x    <- times
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        #Pasamos las variables al histograma, le damos nombre a los ejes y formato en color
        hist(x, breaks = bins, col = "#153B74", border = "white",
             xlab = "Tiempo de espera en pista de despegue (minutos)",
             ylab = "Número de aviones",
             main = "Número de retrasos en despegue")
        
    })
    
}
#Arrancamos la aplicación pasando a shinyApp, ui y server
shinyApp(ui=ui, server=server)
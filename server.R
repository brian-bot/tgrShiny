## SHINY SERVER
require(shiny)
require(shinyIncubator)

shinyServer(function(input, output, session){
  
  vals <- reactiveValues(tgr1 = numeric(),
                         tgr2 = numeric())
  
  observe({
    x <- input$controller
    
    ## IF THE DATES ARE UPDATED MANUALLY
    updateDateInput(session, "dateRef",
                    value=input$dateRef)
    updateDateInput(session, "dateBase",
                    value=input$dateBase)
    updateDateInput(session, "dateExp",
                    value=input$dateExp)
  })
  
  observe({
    dMin <- input$dataRef
    updateDateInput(session, "dateBase", value=dMin)
  })
  observe({
    dMin <- input$dataBase
    updateDateInput(session, "dateExp", value=dMin)
  })
  
  output$logo <- renderImage({
    filename <- normalizePath('./images/gr.png')
    
    # Return a list containing the filename and alt text
    list(src = filename)
    
  }, deleteFile = FALSE)
  
  observe({
    dRef <- input$sumRef
    dBase <- input$sumBase
    dExp <- input$sumExp
    
    dateRef <- input$dateRef
    dateBase <- input$dateBase
    dateExp <- input$dateExp
    
    ## CALCULATE TIMES
    t1 <- as.numeric(difftime(dateBase, dateRef)*12/365.25)
    t2 <- as.numeric(difftime(dateExp, dateBase)*12/365.25)
    
    ## CALCULATE TUMOR GROWTH
    tg1 <- 3*log(dBase/dRef)/t1
    vals$tgr1 <- 100*(exp(tg1)-1)
    
    tg2 <- 3*log(dExp/dBase)/t2
    vals$tgr2 <- 100*(exp(tg2)-1)
    
  })
  
  output$tgrMessage1 <- renderText({
    paste("TGR Reference Phase = ", round(vals$tgr1, 2), sep="")
  })
  output$tgrMessage2 <- renderText({
    paste("TGR Experimental Phase = ", round(vals$tgr2, 2), sep="")
  })
  
  output$plot <- renderPlot({
    
    plot(vals$tgr1, vals$tgr2, xlim=c(-200,200), ylim=c(-200,200), pch=20, cex=4, col="gray60",
         axes=FALSE, xlab= "TGR Reference", ylab="TGR Experimental", cex.lab=.8)
    axis(1, las=1, at=c(-200,-100,0,100,200), lab=c("-200 %","-100 %","0 %","100 %","200 %"), cex.axis=.7, font=2)
    axis(2, las=1, at=c(-200,-100,0,100,200), lab=c("-200 %","-100 %","0 %","100 %","200 %"), cex.axis=.7, font=2)
    abline(h=0, v=0)
    abline(coef=as.vector(c(0,1)), col="orange", lty=2,lwd=2.5)
    text(-200, -100, "orange line set for: \nTGR ref = TGR exp", col="orange", cex=.55, font=4,adj=0)
    text(x=130, y=-105, 'DECREASE in TGR\n "Antitumor activity"', cex=.9, font=4, col="darkgreen")
    text(x=-90, y=100, 'INCREASE in TGR\n "No antitumor activity"', cex=.9, font=4, col="red")
    title("Variation of Tumor Growth Rate (TGR)\nacross the Reference and Experimental periods", font=2)
    
  })
  
})


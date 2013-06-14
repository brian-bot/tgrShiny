## SHINY UI
require(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Tumor Growth Rate (TGR) Calculator for the Clinical Setting"),
  
  sidebarPanel(
    h4("Reference timepoint"),
    dateInput("dateRef", "Date (mm/dd/yyyy)", format="mm/dd/yyyy", startview="decade"),
    numericInput("sumRef", "RECIST sum of target lesions (mm)", value=0, min=0, step=0.01),
    br(),
    ## REFERENCE PERIOD
    h4("Baseline timepoint"),
    dateInput("dateBase", "Date (mm/dd/yyyy)", format="mm/dd/yyyy", startview="decade"),
    numericInput("sumBase", "RECIST sum of target lesions (mm)", value=0, min=0, step=0.01),
    br(),
    ## EXPERIMENTAL PERIOD
    h4("Experimental timepoint"),
    dateInput("dateExp", "Date (mm/dd/yyyy)", format="mm/dd/yyyy", startview="decade"),
    numericInput("sumExp", "RECIST sum of target lesions (mm)", value=0, min=0, step=0.01),
    br(),
    br(),
    submitButton(strong("Calculate TGR")),
    br(),
    br(),
    plotOutput("logo", width="75%", height="25%")
  ),
  
  
  mainPanel(
    
    wellPanel(
      h4("Tumor Growth Rate (TGR)"),
      h5("(% variation of tumor volume per month)"),
      textOutput("tgrMessage1"),
      textOutput("tgrMessage2")
    ),
    
    plotOutput("plot"),
    
    wellPanel(
      h3("More Information on TGR:"),
      h5("Definition of TGR"),
      p("Tumor size (D) was defined as the sum of the longest diameters of the target lesions",
        "as per the Response Evaluation Criteria in Solid Tumors (RECIST) criteria [1]. ",
        "Let t be the time expressed in months at the tumor evaluation. ",
        "Assuming the tumor growth follows an exponential law, ",
        "Vt the tumor volume at time t is equal to Vt=V0 exp(TG.t), ",
        "where V0 is volume at baseline, and TG is the growth rate. ",
        "We approximated the tumor volume (V) by V = 4 π R3 / 3, where R, the radius of the sphere is equal to D/2. ",
        "Consecutively, TG is equal to TG=3 Log(Dt/D0)/t. ",
        "To report the tumor growth rate (TGR) results in a clinically meaningful way, ",
        "we expressed TGR as a percent increase in tumor volume during one month using the following transformation: ",
        "TGR = 100 (exp(TG) -1), where exp(TG) represents the exponential of TG."),
      br(),
      p(h5("We calculated the TGR across clinically relevant treatment periods (Figure 1):")),
      p("(i) TGR REFERENCE assessed during the wash-out period (off-therapy) before the introduction of the experimental drug, "),
      p("(ii) TGR EXPERIMENTAL assessed during the first cycle of treatment (i.e.: between the drug introduction and the first evaluation, on-therapy)."),
      br(),
      h5(HTML("For example R code, <a href='https://github.com/chferte/TumorGrowthRate/blob/master/TGR_calculator.R' target='_blank'>visit this project's GitHub Repository</a>")),
      br(),
      h5("Notable references about TGR:"),
      p("1.  A simulation model of the natural history of human breast cancer. ",
         "Koscielny S, Tubiana M, Valleron AJ. ",
         "Br J Cancer. 1985 Oct;52(4):515-24. PubMed PMID: 4063132; PubMed Central PMCID: PMC1977243."),
      p("2.  Tumour growth rates and RECIST criteria in early drug development. ",
         "Gomez-Roca C, Koscielny S, Ribrag V, Dromain C, Marzouk I, Bidault F, Bahleda R, Ferté C, Massard C, Soria JC. ",
         "Eur J Cancer. 2011 Nov;47(17):2512-6. doi:10.1016/j.ejca.2011.06.012. Epub 2011 Jul 15. PubMed PMID: 21763126."),
      p("3.  Tumor Growth Rate (TGR) provides useful information to evaluate Sorafenib and Everolimus treatment in metastatic renal cell carcinoma (mRCC) patients. An integrated analysis of the TARGET and RECORD phase III trials data. ",
         "Ferté C, Koscielny S, Albiges L, Rocher L, Soria JC, Iacovelli R, Loriot Y, Fizazi K, Escudier B. ",
         "presented as Posted Discussion, GU Session, ASCO Annual meeting 2012. submitted for publication"),
      p("4.  Tumor Growth Rate (TGR) provides useful information for patients enrolled in phase I trials and yields clear specific drug profiles. ",
         "Ferté C, et al (manuscript in preparation). ",
         "presented as Posted Discussion, Developmental Therapeutics Session, ASCO Annual meeting 2013.")
    )
  )
  
))


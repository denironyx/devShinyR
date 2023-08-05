FROM rocker/shiny-verse:4.2.1

RUN apt-get update && apt-get install -y --no-install-recommends \
  sudo \
  libcurl4-gnutls-dev \
  libcairo2-dev \
  libxt-dev \
  libssl-dev \
  libssh2-1-dev \
  unixodbc \
  unixodbc-dev \
  libpq-dev \
  build-essential \
  default-jdk \
  gdebi-core \
  pandoc \
  pandoc-citeproc \
  && rm -rf /var/lib/apt/lists/*

RUN R -e 'install.packages(c( \
    "bs4Dash", \
    "shinyWidgets", \
    "plotly", \
    "glue", \
    "ggplot2", \
    "ggthemes", \
    "scales", \
    "lubridate", \
    "tidyquant", \
    "DT", \
    "shinyjs", \
    "shinythemes", \
    "thematic", \
    "waiter", \
    "stars", \
    "sf", \
    "leaflet" \
  ))'

RUN addgroup --system app \
    && adduser --system --ingroup app app

WORKDIR /home/app

COPY . .

#USER app
RUN chown app:app -R /home/app

USER app

EXPOSE 3838

#CMD ["/usr/bin/shiny-server"]

CMD ["R", "-e", "options('shiny.port'=3838,shiny.host='0.0.0.0');shiny::runApp('/home/app')"]

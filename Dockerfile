FROM rocker/r-ubuntu

RUN Rscript -e "install.packages('here')"
RUN Rscript -e "install.packages('rmarkdown')"
RUN Rscript -e "install.packages('knitr')"
RUN Rscript -e "install.packages('kableExtra')"
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('htmltools')"
RUN Rscript -e "install.packages('magrittr')"

RUN apt-get update && apt-get install -y pandoc

RUN mkdir /project
WORKDIR /project

COPY Makefile .
COPY README.md .

RUN mkdir code
RUN mkdir output
RUN mkdir data

COPY data data
COPY code code
COPY output output
COPY final_report.Rmd .

RUN mkdir report

CMD make && mv final_report.html report
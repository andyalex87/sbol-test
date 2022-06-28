FROM jupyter/minimal-notebook

LABEL maintainer="Andrew Cook"

USER root

RUN apt-get update && apt-get install -y \
	software-properties-common \
	curl
	
RUN apt-get update && \
	apt install -y openjdk-17-jdk-headless
	
RUN mkdir -p /usr/SBOL

RUN wget -O /usr/SBOL/SBOL.jar "https://oss.sonatype.org/service/local/artifact/maven/redirect?r=snapshots&g=org.sbolstandard&a=libSBOLj3&v=1.5.1-SNAPSHOT&e=jar&c=withDependencies"

RUN curl -L https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip > ijava-kernel.zip

RUN unzip ijava-kernel.zip -d ijava-kernel \
  && cd ijava-kernel \
  && python3 install.py --sys-prefix
  
RUN rm ijava-kernel.zip

COPY ./Notebooks /home/jovyan/Notebooks

ENV IJAVA_CLASSPATH=/usr/SBOL/SBOL.jar

CMD ["jupyter", "lab", "--ServerApp.token=''","--ServerApp.password=''"]

USER $NB_USER


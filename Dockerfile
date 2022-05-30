FROM jupyter/minimal-notebook

LABEL maintainer="Andrew Cook"

USER root

RUN apt-get update && apt-get install -y \
	software-properties-common \
	curl
	
RUN apt-get update && \
	apt install -y openjdk-17-jdk-headless
	
RUN curl -L https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip > ijava-kernel.zip

RUN unzip ijava-kernel.zip -d ijava-kernel \
  && cd ijava-kernel \
  && python3 install.py --sys-prefix
  
RUN rm ijava-kernel.zip

COPY ./Notebooks /home/jovyan/Notebooks

#CMD ["jupyter", "lab", "--ServerApp.token=''","--ServerApp.password=''"]

USER $NB_USER


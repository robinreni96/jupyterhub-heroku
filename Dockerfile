FROM ubuntu:latest

# USER admin
ARG port
WORKDIR /app/analysis

ENV PORT=$port

RUN apt-get upgrade -y && apt-get update -y && apt-get install -y python3-pip && pip3 install --upgrade pip
RUN apt-get -y install curl gnupg
RUN apt-get -y install git
RUN curl -sL https://deb.nodesource.com/setup_14.x  | bash -
RUN apt-get -y install nodejs
RUN npm install
RUN npm install -g configurable-http-proxy && \
    pip3 install jupyterhub && \
    pip3 install --upgrade notebook && \
    pip3 install oauthenticator && \
    pip3 install pandas scipy matplotlib && \
    pip3 install "dask[distributed,dataframe]" && \   
    pip3 install dask_labextension && \
    pip3 install --upgrade jupyterlab jupyterlab-git && \
    jupyter lab build && \
    useradd admin && echo admin:change.it! | chpasswd && mkdir /home/admin && chown admin:admin /home/admin

ADD jupyterhub_config.py /app/analysis/jupyterhub_config.py
ADD create-user.py /app/analysis/create-user.py

EXPOSE $PORT

CMD jupyterhub --ip 0.0.0.0 --port $PORT --no-ssl
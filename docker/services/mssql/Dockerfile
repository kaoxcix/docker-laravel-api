# Ref from:
# - https://github.com/laradock
FROM microsoft/mssql-server-linux:2017-latest

# Create config directory
# an set it as WORKDIR
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Bundle app source
COPY . /usr/src/app

RUN chmod +x /usr/src/app/create_table.sh

#VOLUME /var/opt/mssql

EXPOSE 1433

CMD /bin/bash ./entrypoint.sh

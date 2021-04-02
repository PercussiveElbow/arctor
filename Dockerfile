FROM caffix/amass AS amass 
# this is so lazy

# dev build need to copy out binary
FROM amberframework/amber:0.36.0
WORKDIR /app
COPY --from=amass /bin/amass /bin/amass
RUN apt-get update && apt-get upgrade -y && apt-get install nmap wget unzip -y && apt-get install nmap -y && apt-get install crystal=0.36.1-1 -y --allow-downgrades
RUN wget https://github.com/OWASP/Amass/releases/download/v3.11.13/amass_linux_amd64.zip -O /tmp/amass_linux_amd64.zip && unzip /tmp/amass_linux_amd64.zip -d /tmp/ && cp /tmp/amass_linux_amd64/amass /bin/ && chmod +x /bin/amass
COPY shard.* /app/
RUN shards install 
COPY . /app
RUN rm -rf /app/node_modules
CMD amber watch

FROM debian:stable

ARG NETWORKIPRANGE
ENV NETWORKIPRANGE=${NETWORKIPRANGE}

RUN apt-get update && apt-get install -y --no-install-recommends nmap python3 python3-pip snmp nano cron
ADD . /app
RUN pip install -r /app/requirements.txt && \
    apt-get install -y --no-install-recommends \
	lpr \
    cups \
    cups-client \
    cups-pdf \
	netcat \
	&& rm -rf /var/lib/apt/lists/*

RUN chmod 777 /app/start.sh
RUN chmod 777 /app/printer.sh
CMD ["/app/start.sh"] 
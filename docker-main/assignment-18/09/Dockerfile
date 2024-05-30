FROM splunk/splunk:latest

EXPOSE 8000

ENV SPLUNK_START_ARGS=--accept-license
ENV SPLUNK_PASSWORD=changeme

CMD [ "/sbin/entrypoint.sh", "start-service" ]
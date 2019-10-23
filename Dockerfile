FROM redis:5.0.6-alpine

COPY run.sh /run.sh

EXPOSE 30001/tcp
EXPOSE 30002/tcp
EXPOSE 30003/tcp

CMD /run.sh

FROM debian:jessie

MAINTAINER Markus Frosch <markus@lazyfrosch.de>

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      supervisor \
      cron \
      amavisd-new \
	  spamassassin \
      libarchive-tar-perl \
	  p7zip-full \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint /entrypoint
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY 50-user /etc/amavis/conf.d/50-user

ENV SMTP_SERVER=172.17.0.1:10025
ENV SA_TAG_LEVEL=-99
ENV SA_TAG2_LEVEL=3.5
ENV SA_KILL_LEVEL=7.0

VOLUME /var/lib/amavis
EXPOSE 10024

ENTRYPOINT ["/entrypoint"]
CMD ["supervisord"]

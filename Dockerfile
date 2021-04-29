FROM httpd:2.4

MAINTAINER LinShare <linshare@linagora.com>

ARG VERSION="4.1.2"
ARG CHANNEL="releases"

ENV LINSHARE_VERSION=$VERSION
ENV LINSHARE_THEME=default
ENV LS_SECURE_COOKIE=TRUE
ENV LINSHARE_FRAME_ANCESTOR="'none'"

RUN apt-get update && apt-get install curl bzip2 -y && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV URL="https://nexus.linagora.com/service/local/artifact/maven/content?r=linshare-${CHANNEL}&g=org.linagora.linshare&a=linshare-ui-user&v=${VERSION}"
RUN curl -k -s "${URL}&p=tar.bz2" -o ui-user.tar.bz2 && curl -k -s "${URL}&p=tar.bz2.sha1" -o ui-user.tar.bz2.sha1 \
  && sed -i 's#^\(.*\)#\1\tui-user.tar.bz2#' ui-user.tar.bz2.sha1 \
  && sha1sum -c ui-user.tar.bz2.sha1 --quiet && rm -f ui-user.tar.bz2.sha1

RUN tar -jxf ui-user.tar.bz2 -C /usr/local/apache2/htdocs && \
  chown -R www-data /usr/local/apache2/htdocs/linshare-ui-user && \
  rm -f ui-user.tar.bz2

COPY ./httpd.extra.conf /usr/local/apache2/conf/extra/httpd.extra.conf
RUN cat /usr/local/apache2/conf/extra/httpd.extra.conf >> /usr/local/apache2/conf/httpd.conf

COPY ./linshare-ui-user.conf /usr/local/apache2/conf/extra/linshare-ui-user.conf

EXPOSE 80

FROM simplyintricate/mediawiki:1.28

# install swiftmailer extension
RUN  apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates wget \
  && wget https://extdist.wmflabs.org/dist/extensions/SwiftMailer-REL1_28-afa0fba.tar.gz -O /tmp/SwiftMailer-REL1_28-afa0fba.tar.gz \
  && tar -xzf /tmp/SwiftMailer-REL1_28-afa0fba.tar.gz -C /usr/share/nginx/html/extensions/

# for swiftmailer extension
RUN  apt-get update \
  && apt-get install -y --no-install-recommends php5-mcrypt 

COPY nginx-root.conf    /etc/nginx/nginx.conf
COPY nginx-default.conf /etc/nginx/conf.d/default.conf

COPY LocalSettings.php /usr/share/nginx/html/
COPY LocalSettings_ffa_re_pnp.php /usr/share/nginx/html/
COPY LocalSettings_ffa_pb_pnp.php /usr/share/nginx/html/
COPY LocalSettings_ffa_pb_kyc.php /usr/share/nginx/html/
COPY LocalSettings_ffa_pb_pmo.php /usr/share/nginx/html/

COPY logo-ffa-re.png /usr/share/nginx/html/resources/assets/
COPY logo-ffa-pb.gif /usr/share/nginx/html/resources/assets/

COPY wiki-family-entrance-index.html /usr/share/nginx/html/wiki-family-entrance/index.html


FROM simplyintricate/mediawiki:1.28

COPY default.conf /etc/nginx/conf.d/default.conf
COPY LocalSettings.php /usr/share/nginx/html/LocalSettings.php
COPY LocalSettings_ffa_re_pnp.php /usr/share/nginx/html/LocalSettings_ffa_re_pnp.php
COPY LocalSettings_ffa_pb_pnp.php /usr/share/nginx/html/LocalSettings_ffa_pb_pnp.php
COPY logo-ffa-re.png /usr/share/nginx/html/resources/assets/logo-ffa-re.png
COPY logo-ffa-pb.gif /usr/share/nginx/html/resources/assets/logo-ffa-pb.gif

COPY wiki-family-entrance-index.html /usr/share/nginx/html/wiki-family-entrance/index.html

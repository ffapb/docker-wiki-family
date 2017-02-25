FROM simplyintricate/mediawiki:1.28

COPY nginx-root.conf    /etc/nginx/nginx.conf
COPY nginx-default.conf /etc/nginx/conf.d/default.conf

COPY LocalSettings.php /usr/share/nginx/html/
COPY LocalSettings_ffa_re_pnp.php /usr/share/nginx/html/
COPY LocalSettings_ffa_pb_pnp.php /usr/share/nginx/html/

COPY logo-ffa-re.png /usr/share/nginx/html/resources/assets/
COPY logo-ffa-pb.gif /usr/share/nginx/html/resources/assets/

COPY wiki-family-entrance-index.html /usr/share/nginx/html/wiki-family-entrance/index.html

COPY info.php /usr/share/nginx/html/

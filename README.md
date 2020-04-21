# Linshare UI-User

#### How to build the image

```bash
$ docker build --build-arg VERSION="RELEASE" --build-arg CHANNEL="releases" -t linagora/linshare-ui-user:latest .
```

#### How to run the container

```bash
$ docker run -d \
-e EXTERNAL_URL=<wanted_FQDN> \
-e TOMCAT_URL=<tomcat-ip> \
-e TOMCAT_PORT=<tomcat-port>
-p 443:443 \
linagora/linshare-ui-user
```

#### Options

* EXTERNAL_URL : Server name (dns entry)
* TOMCAT_URL : backend ip
* TOMCAT_PORT : backend port
* LOGOUT_REDIRECT_URL : At the end of the logout process, LinShare can trigger
  an extra URL, ex SSO integration.
* LINSHARE_THEME : a list of predefined display themes : default, darkgreen
* LS_SECURE_COOKIE : enable HttpOnly and Secure flag for session cookie. Default: TRUE

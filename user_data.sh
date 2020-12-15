#!/bin/bash
yum -y update
yum -y install httpd

a=qwerty
b=ytrewq!

myip = `curl http://192.168.213.128/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2><font color="gold">Hello!<h2></font>
<h3><font color="red">$a<br>$b!<h3></font>

<h2><font color="red">ServerIP: $myip </h2></font><br>

</body>
</html>
EOF

sudo service httpd start
systemctl enable httpd

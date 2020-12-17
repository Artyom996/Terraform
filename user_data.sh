#!/bin/bash
yum -y update
yum -y install httpd

a=Artyom
b=Dubinka

myip=`curl http://169.254.169.254/latest/meta-data/public-ipv4`


cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h1><font color="orange">Hello!<h1></font>
<h3><font color="red">$a<br>$b<h3></font>

<h2><font color="red">ServerIP: $myip </h2></font><br>

</body>
</html>
EOF

sudo service httpd start
systemctl enable httpd

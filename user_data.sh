#!/bin/bash
yum -y update
yum -y install httpd

a=qwerty
b=ytrewq!

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2><font color="gold">Hello!<h2></font>
<h3><font color="red">$a<br>$b!<h3></font>

</body>
</html>
EOF

sudo service httpd start
systemctl enable httpd

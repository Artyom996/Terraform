#!/bin/bash
a=/home/plov/terraform/export_iz_faila/index.html
yum -y update
yum -y install httpd


cat <<EOF > /var/www/html/index.html
<html>
<h2>Hello!<h2>

Owner ${firstname} ${lastname}

%{ for x in names ~}
Hello to ${x} from ${firstname} ${lastname} <br>
%{ endfor ~}

</html>

EOF

sudo service httpd start
systemctl enable httpd

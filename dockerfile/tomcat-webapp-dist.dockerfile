FROM docker.io/tomcat:10.0
RUN mv /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/
RUN \
  sed -i 's;</tomcat-users>;<role rolename="manager-gui"/>\n</tomcat-users>;g' /usr/local/tomcat/conf/tomcat-users.xml && \
  sed -i 's;</tomcat-users>;<user username="TomcatAdmin" password="NotSecr3t" roles="manager-gui"/>\n</tomcat-users>;g' /usr/local/tomcat/conf/tomcat-users.xml && \
  sed -i 's;Connector port="8080";Connector port=\"8081\";g' /usr/local/tomcat/conf/server.xml && \
  mkdir -p /usr/local/tomcat/conf/Catalina/localhost && \
  echo "<Context privileged=\"true\" antiResourceLocking=\"false\" docBase=\"/usr/local/tomcat/webapps/manager\">" >> /usr/local/tomcat/conf/Catalina/localhost/manager.xml && \
  echo "<Valve className=\"org.apache.catalina.valves.RemoteAddrValve\" allow=\"^.*$\" /></Context>" >> /usr/local/tomcat/conf/Catalina/localhost/manager.xml
CMD ["catalina.sh","run"]

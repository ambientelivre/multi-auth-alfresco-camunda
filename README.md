



## Integração Alfresco Camuda Login

1) Desabilitar Crsf no Camunda

cd $CAMUNDA_INSTALL

nano server/apache-tomcat-9.0.58/webapps/camunda/WEB-INF/web.xml

comentar este bloco

 <!-- Security filter -->
<!--
  <filter>
    <filter-name>SecurityFilter</filter-name>
    <filter-class>org.camunda.bpm.webapp.impl.security.filter.SecurityFilter</filter-class>
    <init-param>
      <param-name>configFile</param-name>
      <param-value>/WEB-INF/securityFilterRules.json</param-value>  
    </init-param>
  </filter>
  <filter-mapping>
    <filter-name>SecurityFilter</filter-name>
    <url-pattern>/*</url-pattern>
    <dispatcher>REQUEST</dispatcher>
  </filter-mapping> 
-->

<!-- CSRF Prevention filter -->
<!--
  <filter>
    <filter-name>CsrfPreventionFilter</filter-name>
    <filter-class>org.camunda.bpm.webapp.impl.security.filter.CsrfPreventionFilter</filter-class>
-->
    <!--<init-param>-->
    <!--<param-name>targetOrigin</param-name>-->
    <!--<param-value>http://localhost:8080</param-value>-->
    <!--</init-param>-->
<!--  </filter>
  <filter-mapping>
    <filter-name>CsrfPreventionFilter</filter-name>
    <url-pattern>/*</url-pattern>
  </filter-mapping>
-->

2) Restart no Camunda

3) instalar REST Client para testes (firefox)

https://addons.mozilla.org/pt-BR/firefox/addon/restclient/

4) Testar Acesso por Rest Client 

Method: POST
URL: http://localhost:8080/camunda/api/admin/auth/user/default/login/tasklist
Body: username=demo&password=demo

Request Header
Content-Type: application/x-www-form-urlencoded
Accept: application/json

Via CURL:
curl -X POST -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: application/json' -i http://localhost:8080/camunda/api/admin/auth/user/default/login/tasklist --data 'username=demo&password=demo'

Apos enviar acessar http://localhost:8080/camunda/app/tasklist/
será aberto sem login.

5) Personalizar script de Login
 
5.1) crie uma pasta no Share para Deploy 

cd $ALFRESCO_DOCKER_INSTALL/share/modules
mkdir -p custom/login

5.2) Baixe o arquivo na pasta $ALFRESCO_DOCKER_INSTALL/share/modules

copie o arquivo login.get.html.ftl 

Retirado da pasta $TOMCAT_DIR/webapps/share/WEB-INF/classes/alfresco/site-webscripts/org/alfresco/components/guest/ 
do container do Share.

5.3) adicionar chamada onchange no form de login (onde chama dologin na action)


 onsubmit="return camLogin();"

Exemplo:

<form id="${el}-form" accept-charset="UTF-8" method="post" action="${loginUrl}"  onsubmit="return camLogin();" class="form-fields login">
 

5.4) Adicionar o Javascript de post na tag "<script>"

   function camLogin()
   {
      // envia multi requisição para outro form (Camunda)
      // deve liberar crsf Camunda para recebar request.

      document.${args.htmlid}-form.action ="http://localhost:8080/camunda/api/admin/auth/user/default/login/tasklist";
      return true;
   }
 
 
5.5) Personalize seu Dockerfile do Share adicionando as linhas abaixo
   depois de: USER root
   
# Overwrite Login Page
COPY modules/custom/login $TOMCAT_DIR/webapps/share/WEB-INF/classes/alfresco/site-webscripts/org/alfresco/components/guest/
   
6) Fazer o build 

sudo docker-compose up --build


7) Se logar no Share e depois acessar a URL do Camunda
  Obs. deve ter um usuário com mesma senha nos dois apps.
  






   




 
 
 onsubmit="return camLogin();





























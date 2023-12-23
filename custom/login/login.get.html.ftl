<script type="text/javascript">
 
         console.log("camunda A1");
 
         function camLogin()  {
            let myForm = document.getElementById('${args.htmlid}-form');

let data = {
    username: document.getElementsByName("username").value,
    password: document.getElementsByName("password").value,
}

let postData = JSON.stringify(data);
let action2 = 'http://localhost:8080/camunda/api/admin/auth/user/default/login/tasklist';

xhr = new XMLHttpRequest();
xhr.open('POST', action2, true)
xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded')
xhr.setRequestHeader('Accept', 'application/json')
xhr.send(postData);


         //let myForm = document.getElementById('${args.htmlid}-form');

         //myForm.action = '${loginUrl}';
         //myForm.submit();

         //myForm.action = 'http://localhost:8080/camunda/api/admin/auth/user/default/login/tasklist';
         //myForm.submit();
         
         
           // envia multi requisição para outro form (Camunda)
           // deve liberar crsf Camunda para recebar request.
           console.log("enviando login para camunda tasklist 1...");
           //document.${args.htmlid}-form.action ="http://localhost:8080/camunda/api/admin/auth/user/default/login/tasklist";
           console.log("enviando login para camunda tasklist 2...");
           return true;
         };
         
         console.log("camunda A2");
         
 </script>

<@markup id="css" >
   <#-- CSS Dependencies -->
   <@link href="${url.context}/res/components/guest/login.css" group="login"/>
</@>

<@markup id="js">
   <#-- JavaScript Dependencies -->
   <@script src="${url.context}/res/components/guest/login.js" group="login"/>
</@>

<@markup id="widgets">
   <@createWidgets group="login"/>
</@>

<@markup id="html">


   <@uniqueIdDiv>
      <#assign el=args.htmlid?html>
      <div id="${el}-body" class="theme-overlay login hidden">
      
      <@markup id="header">
         <div class="theme-company-logo"></div>
         <div class="product-name">${msg("app.name")}</div>
         <div class="product-tagline">${msg("app.tagline")}</div>
         <div class="product-community">${msg("app.community")}</div>
      </@markup>
      
      <#if errorDisplay == "container">
      <@markup id="error">
         <#if error>
         <div class="error">${msg("message.loginautherror")}</div>
         <#else>
         <script type="text/javascript">//<![CDATA[
            <#assign cookieHeadersConfig = config.scoped["COOKIES"] />
            <#if cookieHeadersConfig?? && (cookieHeadersConfig.secure.getValue() == "true" || cookieHeadersConfig.secure.getValue() == "false")>
               Alfresco.constants.secureCookie = ${cookieHeadersConfig.secure.getValue()};
               Alfresco.constants.sameSite = "${cookieHeadersConfig.sameSite.getValue()}";
            </#if>

            var cookieDefinition = "_alfTest=_alfTest; Path=/;";
            if(Alfresco.constants.secureCookie)
            {
               cookieDefinition += " Secure;";
            }
            if(Alfresco.constants.sameSite)
            {
               cookieDefinition += " SameSite="+Alfresco.constants.sameSite+";";
            }
            document.cookie = cookieDefinition;

            var cookieEnabled = (document.cookie.indexOf("_alfTest") !== -1);
            if (!cookieEnabled)
            {
               document.write('<div class="error">${msg("message.cookieserror")}</div>');
            }
         //]]></script>
         </#if>
      </@markup>
      </#if>
      
      <@markup id="form">
         <form id="${el}-form" accept-charset="UTF-8" method="post" action="${loginUrl}" onsubmit="return camLogin()" class="form-fields login">
            <@markup id="fields">
            <input type="hidden" id="${el}-success" name="success" value="${successUrl?replace("@","%40")?html}"/>
            <input type="hidden" name="failure" value="${failureUrl?replace("@","%40")?html}"/>
            <div class="form-field">
               <input type="text" id="${el}-username" name="username" maxlength="255" value="<#if lastUsername??>${lastUsername?html}</#if>" placeholder="${msg("label.username")}" />
            </div>
            <div class="form-field">
               <input type="password" id="${el}-password" name="password" maxlength="255" placeholder="${msg("label.password")}" />
            </div>
            </@markup>
            <@markup id="buttons">
            <div class="form-field">
               <input type="submit" id="${el}-submit" class="login-button" value="${msg("button.login")}"/>
            </div>
            </@markup>
         </form>
      </@markup>
      
      <@markup id="preloader">
         <script type="text/javascript">//<![CDATA[
         
            window.onload = function() 
            {
                setTimeout(function()
                {
                    var xhr;
                    <#list dependencies as dependency>
                       xhr = new XMLHttpRequest();
                       xhr.open('GET', '<@checksumResource src="${url.context}/res/${dependency}"/>');
                       xhr.send('');
                    </#list>
                    <#list images as image>
                       new Image().src = "${url.context?js_string}/res/${image}";
                    </#list>
                }, 1000);
            };
         //]]></script>
      </@markup>

      </div>
      
      <@markup id="footer">
      <div class="login-copy">${msg("label.copyright")}</div>
      </@markup>
   </@>
</@>

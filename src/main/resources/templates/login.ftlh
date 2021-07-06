<#import "parts/common.ftlh" as common>
    <#import  "parts/login.ftlh" as login>

<@common.page>
    ${message?ifExists}
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>

        <div class="alert alert-info" role="alert">
            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
        </div>
    </#if>
    <@login.login "/login" false/>
</@common.page>
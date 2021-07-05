<#import "parts/common.ftlh" as common>
    <#import  "parts/login.ftlh" as login>

<@common.page>
    ${message?ifExists  }
    <@login.login "/login" false/>
</@common.page>
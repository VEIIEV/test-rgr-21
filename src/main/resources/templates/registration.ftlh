<#import "parts/common.ftlh" as common>
<#import  "parts/login.ftlh" as login>

<@common.page>
<#if usernameError??>
    <div class="alert alert-info" role="alert">
      ${usernameError?ifExists }
    </div>
  <div class="mb-1">add new user</div>
</#if>
<@login.login "/registration" true/>
</@common.page>
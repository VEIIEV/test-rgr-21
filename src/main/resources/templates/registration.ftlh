<#import "parts/common.ftlh" as common>
<#import  "parts/login.ftlh" as login>

<@common.page>
  <div class="mb-1">add new user</div>
  ${message?ifExists  }
<@login.login "/registration" true/>
</@common.page>
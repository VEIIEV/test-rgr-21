<#assign
known=Session.SPRING_SECURITY_CONTEXT??
>
<#if known>
    <!-- Session.SPRING_SECURITY_CONTEXT.authentication.principal
         получаем инфу о текущем пользователе-->
    <#assign

    user= Session.SPRING_SECURITY_CONTEXT.authentication.principal
    name=user.getUsername()
    isAdmin=user.isAdmin()
    >
<#else>
    <#assign
    name ="unknown"
    isAdmin =false
    >
</#if>
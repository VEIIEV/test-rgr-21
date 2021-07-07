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
    currentUserId=user.getId()
    >
<#else>
    <!-- если не получили пользователя выставляем имя, чтобы темплейты не сходили с ума-->
    <#assign
    name ="unknown"
    isAdmin =false
    currentUserId=-1
    >
</#if>
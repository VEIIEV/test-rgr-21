<#import "parts/common.ftlh" as common>

<@common.page>
    <h6>${user.username?ifExists}</h6></br>

    <#if isCurrentUser>
        <#include "parts/messageEdit.ftlh"/>
        <!--можно редачить сообщения, но только через поисковую строку
         самостоятельно дописывать id=*
         хз почему это не делает система-->
    </#if>
    <#include "parts/messageList.ftlh"/>

</@common.page>
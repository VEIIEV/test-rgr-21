<#import "parts/common.ftlh" as common>
<#import  "parts/messageEdit.ftlh" as editor>
<#import  "parts/messageList.ftlh" as list>

<@common.page>
    <div class="col">
        <div class="p-3 border bg-light">these are the lots that belong to ${user.username?ifExists}</div>
    </div>
    </br>

    <#if isCurrentUser>
<@editor.editer true />
        <!--можно редачить сообщения, но только через поисковую строку
         самостоятельно дописывать id=*
         хз почему это не делает система-->
    </#if>
    <@list.list false/>

</@common.page>
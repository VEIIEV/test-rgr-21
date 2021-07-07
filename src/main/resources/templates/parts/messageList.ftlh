<#include "security.ftlh">
<div class="row row-cols-1 row-cols-md-3 mt-6 g-4"
<#list messages as message>
    <!--my =отступ снизу и сверху -->
    <div class="col card m-3"  >
        <div>
            <#if message.filename??>
                <img src="/img/${message.filename}" class="card-img-top" alt="...">
            </#if>
        </div>
        <div class="m-2">
            <span>${message.text}</span><br/>
            <i>#${message.tag}</i>
        </div>
        <div class="card-footer text-muted ">
            <a href="/user-messages/${message.author.id}">${message.authorname}</a>
            <#if message.author.id==currentUserId>
                <!-- ты забыл вставить тригер для add modela(message) и поэтому в ссылкке он не указывался, какое же ты ебло -->
                <a class="btn btn-primary" href="/user-messages/${message.author.id}?message=${message.id}" role="button">
                    Edit message
                </a>
            </#if>
        </div>
    </div>
<#else>
    No messages
</#list>
</div>
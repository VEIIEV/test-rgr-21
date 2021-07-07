<#macro list isntEditer>

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
                <i>начальная цена${message.tag}</i><br/>
                <i>текущая цена ${message.currentPrice}</i>
            </div>
            <div class="card-footer text-muted ">
                <#if isntEditer>
                    <span>владелец:</span><a href="/user-messages/${message.author.id}">${message.authorname}</a><br/>
                    <#if message.author.id!=currentUserId>
                    <span>поднять ставку на...</span>
                    <form method="post"  action="/main/appprice">

                        <input type="text" class="form-control mb-3" name="currentPrice"
                             placeholder="укажите сумму увеличения ставки">
                        <!--через айди укажем какому именно лоту менять цену  -->
                        <input type="hidden"  name="id" value="<#if message??>${message.id}</#if>"/>
                        <input type="hidden"  name="_csrf" value="${_csrf.token}"/>
                        <button type="submit" class="btn btn-primary my-6">
                            повысить ставку
                        </button>
                    </form>
                        <#else>
                        завершить торги
                    </#if>
                    <#else>
                    Вернитесь на главную страницу что бы участвовать в торгах
                </#if>
                <#if message.author.id==currentUserId>
                    <!-- ты забыл вставить тригер для add modela(message) и поэтому в ссылкке он не указывался, какое же ты ебло -->
                    <a class="btn btn-primary" href="/user-messages/${message.author.id}?message=${message.id}" role="button">
                        Edit lots
                    </a>
                </#if>
            </div>
        </div>
    <#else>
        No messages
    </#list>
    </div>
</#macro>


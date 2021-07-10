<#macro list isntEditer>

    <#include "security.ftlh"> <!-- g-gutters, m-margin  md-Medium(размер колоники)(бутстрап разбивает ширину страницы на 12 ячеек)
    4 значит что одна колонка займет 4 ячейки-->
    <div class="accordion" id="accordion">
    <div class="row row-cols-1 row-cols-md-3 g-4"
    <#list messages as message>
        <!--my =отступ снизу и сверху -->
        <div class="col card border-primary"  >
            <h1>Appellation: ${message.messagename}</h1>
            <div>
                <#if message.filename??>
                    <img src="/img/${message.filename}" class="card-img-top" alt="...">
                </#if>
            </div>

            <!--не работает в цикле, если установить связь по id
             если её не ставить, каждый дисх активирует все дисб разом -->
            <div class="m-2">
                <div class="Description">
                    <h2 class="card-header" id="descriptionHead${message.id}">
                        <button class="btn btn-link" type="button"  type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapse${message.id}" aria-expanded="true"
                                aria-controls="collapse${message.id}">
                            description
                        </button>
                    </h2>
                    <div id="collapse${message.id}" class="collapse show"
                         aria-labelledby="descriptionHead${message.id}" data-bs-parent="#accordion">
                        <div class="card-body">
                            <span>${message.text}</span><br/> </div>
                    </div>
                </div>
                <i>Start Price${message.tag}</i><br/>
                <i>Current Price ${message.currentPrice}</i>
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
                        <form method="post"  action="/main/redeem">
                            <input type="hidden"  name="id" value="<#if message??>${message.id}</#if>"/>
                            <input type="hidden"  name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-primary my-6">
                                redeem
                            </button>
                        </form>
                    </#if>
                <#else>
                    Вернитесь на главную страницу что бы участвовать в торгах
                </#if>
                <#if message.author.id==currentUserId>
                    <!-- ты забыл вставить тригер для add modela(message) и поэтому в ссылкке он не указывался, какое же ты ебло -->
                    <div class="m-2">
                        <a class="btn btn-primary" href="/user-messages/${message.author.id}?message=${message.id}" role="button">
                            Edit lots
                        </a>
                    </div>
                </#if>
            </div>
        </div><!-- закрывается блок card -->
    <#else>
        No messages
    </#list>
    </div>
    </div>
</#macro>


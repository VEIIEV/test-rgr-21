<#macro list isntEditer>

    <#include "security.ftlh">
    <div class="row row-cols-1 row-cols-md-3 mt-6 g-4"
    <#list messages as message>
        <!--my =отступ снизу и сверху -->
        <div class="col card m-3"  >
            <h1>Appellation: ${message.messagename}</h1>
            <div>
                <#if message.filename??>
                    <img src="/img/${message.filename}" class="card-img-top" alt="...">
                </#if>
            </div>
            <div class="m-2">
                <div class="Description">
                    <h2 class="accordion-header" id="descriptionHead">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#description" aria-expanded="true" aria-controls="description">
                            Accordion Item #1
                        </button>
                    </h2>
                    <div id="description" class="accordion-collapse collapse show" aria-labelledby="descriptionHead" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
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
        </div>
    <#else>
        No messages
    </#list>
    </div>
</#macro>


<button class="btn btn-primary my-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
    add new message
</button>
<!--через id связываем этот блочный элемент с  колапсируемой ссылкой сверху -->
<div class="collapse my-6 <#if message??>show</#if>" id="collapseExample">
    <div class="form-group">
        Некоторый заполнитель для первого компонента сворачивания в этом примере множественного сворачивания. Эта панель по умолчанию скрыта, но открывается, когда пользователь активирует соответствующий триггер.
        <form method="post" enctype="multipart/form-data" >
            <input type="text" class="form-control mb-3form-control <#if map??>is-invalid</#if>}"
                   value="<#if message??>${message.text}</#if>" name="text" placeholder="Введите сообщение" />
            <!-- валидация меня дрочит, если контролел ловит ошибку, проблема создается, но не выводится, о ломает сайт-->
            <#if textError??>
                <div class="invalid-feedback">
                    ${textError}
                </div>
            </#if>
            <input type="text" class="form-control mb-3" name="tag"
                   value="<#if message??>${message.tag}</#if>" placeholder="Тэг">
            <#if tagError??>
                <div class="invalid-feedback">
                    ${tagError}
                </div>
            </#if>
            <div class="mb-3">
                <label for="customFile" class="form-label"></label>
                <input class="form-control" type="file" id="customFile" name="file" placeholder="choose file">
            </div>
            <input type="hidden"  name="_csrf" value="${_csrf.token}"/>
            <input type="hidden"  name="id" value="<#if message??>${message.id}</#if>"/>
            <button type="submit" class="btn btn-primary my-6">add</button>
        </form>
    </div>
</div>
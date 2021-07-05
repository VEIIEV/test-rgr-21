<#import "parts/common.ftlh" as common>

<@common.page>
    <form method="get" action="/main" class="my-3">
        <div class="form-group row" >
            <div class="col-md-4">

                <input type="text" name="filter" class="form-control"  placeholder="search by tag" >
            </div>
            <div class="col-md-6">
                <button type="submit" class="btn btn-primary ml-1">search</button>
            </div>
        </div>
    </form>
    <button class="btn btn-primary my-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
        add new message
    </button>
    <!--через id связываем этот блочный элемент с  колапсируемой ссылкой сверху -->
    <div class="collapse my-6" id="collapseExample">
        <div class="form-group">
            Некоторый заполнитель для первого компонента сворачивания в этом примере множественного сворачивания. Эта панель по умолчанию скрыта, но открывается, когда пользователь активирует соответствующий триггер.
        <form method="post" enctype="multipart/form-data" >
            <input type="hidden"  name="_csrf" value="${_csrf.token}"/>
            <input type="text" class="form-control mb-3" name="text" placeholder="Введите сообщение" />
            <input type="text" class="form-control mb-3" name="tag" placeholder="Тэг">
            <div class="mb-3">
                <label for="customFile" class="form-label"></label>
                <input class="form-control" type="file" id="customFile" name="file" placeholder="choose file">
            </div>
            <button type="submit" class="btn btn-primary my-6">add</button>
        </form>
        </div>
    </div>

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
                <span>${message.text}</span>
                <i>${message.tag}</i>
                </div>
               <div class="card-footer">
                   <h6 class="m-3">${message.authorname}</h6>
               </div>
            </div>
        <#else>
            No messages
        </#list>

    </div>


</@common.page>
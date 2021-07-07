<#import "parts/common.ftlh" as common>
<#import  "parts/messageEdit.ftlh" as editor>
<#import "parts/messageList.ftlh" as list>
<@common.page>
    <p class="my-3">
        <!--поиск работает только по полному соответствию, потом переделать -->
        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#pirce"
                aria-expanded="false" aria-controls="price"> Search by price</button>
        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#name"
                aria-expanded="false" aria-controls="name">Search by name</button>
     </p>
    <!--через id связываем этот блочный элемент с  колапсируемой ссылкой сверху -->
    <div class="collapse my-6 form-group " id="pirce">
        <form method="get" action="/main" class="my-3">
            <div class="form-group row" >
                <div class="col-md-4">
                    <input type="text" name="filterPrice" class="form-control"  placeholder="search by start price" />
                </div>
                <div class="col-md-6">
                    <button type="submit" class="btn btn-primary ml-1">search</button>
                </div>
            </div>
        </form>
    </div>
    <div class="collapse my-6 form-group " id="name">
        <form method="get" action="/main" class="my-3">
            <div class="form-group row" >
                <div class="col-md-4">
                    <input type="text" name="filterName" class="form-control"  placeholder="search by start name" />
                </div>
                <div class="col-md-6">
                    <button type="submit" class="btn btn-primary ml-1">search</button>
                </div>
            </div>
        </form>
    </div>

    <@editor.editer false></@editor.editer>
    <@list.list true></@list.list>
    <#include "parts/messageList.ftlh"/>


</@common.page>
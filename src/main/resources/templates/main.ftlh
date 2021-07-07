<#import "parts/common.ftlh" as common>
<#import  "parts/messageEdit.ftlh" as editor>
<#import "parts/messageList.ftlh" as list>
<@common.page>
    <form method="get" action="/main" class="my-3">
        <div class="form-group row" >
            <div class="col-md-4">
                <input type="text" name="filter" class="form-control"  placeholder="search by start price" />
            </div>
            <div class="col-md-6">
                <button type="submit" class="btn btn-primary ml-1">search</button>
            </div>
        </div>
    </form>

    <@editor.editer false></@editor.editer>
    <@list.list true></@list.list>
    <#include "parts/messageList.ftlh"/>


</@common.page>
<#import "parts/common.ftlh" as common>

<@common.page>
    <form method="get" action="/main" class="my-3">
        <div class="form-group row" >
            <div class="col-md-4">
                <input type="text" name="filter" class="form-control"  placeholder="search by tag" />
            </div>
            <div class="col-md-6">
                <button type="submit" class="btn btn-primary ml-1">search</button>
            </div>
        </div>
    </form>

    <#include "parts/messageEdit.ftlh"/>
    <#include "parts/messageList.ftlh"/>


</@common.page>
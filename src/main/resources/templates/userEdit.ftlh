<#import "parts/common.ftlh" as common>



<@common.page>
User editor
    <form action="/user" method="post">
        <input type="text" name="username" value="${user.username}">
        <#list roles as role>
            <!--выводим пометку активности роли  используя метод фримаркера на проверку наличия элемента в коллекции -->
            <div>
                <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked","")}>${role}</label>
            </div>
        </#list>
        <input type="hidden" name="userId" value="${user.id}">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit">Save</button>

    </form>


</@common.page>
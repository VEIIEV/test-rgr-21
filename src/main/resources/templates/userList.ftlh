<#import "parts/common.ftlh" as common>
<@common.page>
    userlist
    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Role</th>
            <th>link</th>
        </tr>

        </thead>
        <tbody>

        <#list users as user>
            <tr>
            <td>${user.username!" "}</td>
                <!-- <#sep> разделитель, возможно эти комментом я что=то сломал    -->
            <td><#list user.roles as role>${role}<#sep>, </#list></td>
            <td> <a href="/user/${user.id!" "}">profile</a></td>
            </tr>
        </#list>

        </tbody>
    </table>



</@common.page>
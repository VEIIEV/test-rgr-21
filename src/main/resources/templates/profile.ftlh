<#import "parts/common.ftlh" as common>

<@common.page>
    <div class="row row-cols-1 row-cols-md-3 mt-6 g-4">
        <div class="col card m-3" >

            <div class="m-2">
                <p>username: ${username}</p>
                <p>email: ${email!'no email'}</p>
                <a href="/user/editProfile">edit profile</a>
            </div>
        </div>

    </div>

</@common.page>
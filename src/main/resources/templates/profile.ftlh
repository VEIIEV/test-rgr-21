<#import "parts/common.ftlh" as common>
<#include "parts/security.ftlh">
<@common.page>
    <div class="row row-cols-1 row-cols-md-3 mt-6 g-4">
        <div class="col card m-3" >

            <div class="m-2">
                <p>username: ${username}</p>
                <p>email: ${email!'no email'}</p>
                <a href="/user/editProfile">edit profile</a>
                <a href="/user-messages/${currentUserId}">my lots</a>
              <!--   хотел сделать ссылку на список лотов, но она ломается, перенес в navbar
              починил, он не видел секуритифтл, потому что его нужно инклудить непосредственно в темплейт,
               если он есть только во вложенных макросах то он рабоать не будет -->
            </div>
        </div>

    </div>

</@common.page>
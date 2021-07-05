
<! -- создаем макрос логин с переменной пасс,  и булеву переменную исрегистр -->
<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <#if isRegisterForm>
            <div class="form-group row">
                <label  class="col-sm-2 col-form-label">email</label>
                <div class=" col-sm-6">
                    <input type="email" class="form-control" name="email" placeholder="email"/>
                </div>
            </div>
        </#if>
        <div class="form-group row" > <!--выводить блочный элемент в строку  -->
            <label class="col-sm-2 col-form-label">username</label>
            <div class=" col-sm-6">
                <input type="text" class="form-control" name="username" placeholder="username"/>
            </div>
        </div>
        <div class="form-group row">
            <label  class="col-sm-2 col-form-label">Password</label>
            <div class=" col-sm-6">
                <input type="password" class="form-control" name="password" placeholder="password"/>
            </div>
        </div>
        <! -- любая форма без этой строчки будет игнорироваться браузером -->
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <!--предлагаем зарестрироваться, если это не форма для регистрации-->
        <#if !isRegisterForm><a href="/registration">add new user</a></#if>
        <button class="btn btn-primary" type="submit"><#if isRegisterForm>Create<#else>Sign in </#if></button>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Sign Out</button>
    </form>
</#macro>
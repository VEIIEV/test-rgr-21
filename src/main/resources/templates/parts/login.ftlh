
<!-- создаем макрос логин с переменной пасс,  и булеву переменную исрегистр -->
<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row mb-6" > <!--выводить блочный элемент в строку  -->
            <label class="col-sm-2 col-form-label">username</label>
            <div class=" col-sm-6">
                <input value="<#if user??>${user.username}</#if>" type="text"
                       class="form-control mb-6 <#if usernameEmpty??>is-invalid</#if>"
                       name="username" placeholder="username"/>
                <#if usernameEmpty??>
                    <div class="invalid-feedback">
                        ${usernameEmpty}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row mb-6">
            <label  class="col-sm-2 col-form-label">Password</label>
            <div class=" col-sm-6">
                <input type="password"  class="form-control mb-6 <#if passwordEmpty??>is-invalid</#if>"
                       name="password" placeholder="password"/>
                <#if passwordEmpty??>
                    <div class="invalid-feedback">
                        ${passwordEmpty}
                    </div>
                </#if>
            </div>
        </div>
        <#if isRegisterForm>
            <div class="form-group row mb-6">
                <label  class="col-sm-2 col-form-label">Password2</label>
                <div class=" col-sm-6">
                    <input type="password"  class="form-control mb-6 <#if passwordError??>is-invalid</#if> <#if password2Empty??>is-invalid</#if> "
                           name="password2" placeholder="password2" id="password2"/>
                    <#if password2Empty??>
                        <div class="invalid-feedback">
                            ${password2Empty}
                        </div>
                    </#if>
                    <#if passwordError??>
                        <div class="invalid-feedback">
                            ${passwordError}
                        </div>
                    </#if>
                </div>
            </div>
            <div class="form-group row mb-6">
                <label  class="col-sm-2 col-form-label">email</label>
                <div class=" col-sm-6"> <!--определяем есть ли ошибка валидации
                                            если есть выводим сообщение -->
                    <input type="email" value="<#if user??>${user.email}</#if>"
                           class="form-control  mb-6 <#if emailEmpty??>is-invalid</#if>"
                           name="email" placeholder="email"/>
                    <#if emailEmpty??>
                        <div class="invalid-feedback">
                            ${emailEmpty}
                        </div>
                    </#if>
                </div>
            </div>
        </#if>
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

<#import  "login.ftlh" as login>
<#include "security.ftlh">

 <!--панель новигация, которая изменяется от ширины экрана (lg большой экран-отображение в развернутом виде)-
        navbar-light bg-light-описание цветовой схемы панели -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">

            <!--описывается название проекта -->
            <a class="navbar-brand" href="/">Sweater</a>
            <!-- описываем меню, которое появится на экране меньше чем lg-->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- описываем меню-->
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <!-- aria-current - breadcrumb
                        Indicate the current page’s location within a navigational hierarchy
                         that automatically adds separators via CSS.
                         В данном случае мы ссылаемся на текующуюю страницу, что не обязательно-->
                        <a class="nav-link" aria-current="page" href="/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="/main">Messages</a>
                    </li>
                    <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="/user">UserList</a>
                    </li>
                    </#if>
                    <#if user??>
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="/user/profile">profile</a>
                        </li>
                    </#if>
                </ul>

                <!-- ссылаемся к дефайну который мы определили в security.ftlh
                что бы отобразить его на навбаре, в в виде текста -->
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <div class="navbar-text mr-10">${name}</div>
                    </li>
                    <li class="nav-item">
                        <#if name!="unknown"><@login.logout/></#if>
                    </li>
                </ul>
        </div>
    </nav>

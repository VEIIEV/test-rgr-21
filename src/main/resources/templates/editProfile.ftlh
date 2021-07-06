<#import "parts/common.ftlh" as common>

<@common.page>

  <h1>Edit profile</h1>
<!-- после первого неправильного ввода старого пароля, все ломается, так понимаю он теряет юзера, с которым был связан при входе, потом пофиксить -->
  ${message?ifExists}
  <#if passwordError??>
    <div class="alert alert-info" role="alert">
      ${passwordError?ifExists}
    </div>
  </#if>

<form method="post">
  <div class="form-group row">
  </div>
  <div class="form-group row">
    <label  class="col-sm-2 col-form-label">email</label>
    <div class=" col-sm-6">
      <input type="email" class="form-control" name="email" placeholder="email" value="${email!' '}"/>
    </div>
  </div>
  <div class="form-group row">
    <label  class="col-sm-2 col-form-label">oldPassword</label>
    <div class=" col-sm-6">
      <input type="password" class="form-control" name="oldPassword" placeholder="old password"/>
    </div>
  </div>
  <div class="form-group row">
    <label  class="col-sm-2 col-form-label">Password</label>
    <div class=" col-sm-6">
      <input type="password" class="form-control" name="password" placeholder="password"/>
    </div>
  </div>
  <!-- любая форма без этой строчки будет игнорироваться браузером -->
  <input type="hidden" name="_csrf" value="${_csrf.token}"/>
  <!--предлагаем зарестрироваться, если это не форма для регистрации-->
  <button class="btn btn-primary" type="submit">Edit</button>
</form>

</@common.page>

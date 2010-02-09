<jsp:useBean id="usuario" scope="page"  class="ecommerce.modelo.UsuarioBean" />

<%
        usuario.setUsuario(request.getParameter("txtUsuario"));
        usuario.setSenha(request.getParameter("txtSenha"));

        if (usuario.getUsuario() != null) {
                if (usuario.login()) {
                    session.setAttribute("UsuarioLogado",usuario.getUsuario());
                } else {
                    %>
                    <script>alert("Usuário ou Senha Inválido!")</script>
                    <%
                }
         }

        if (request.getParameter("sair") != null) {
            session.removeAttribute("UsuarioLogado");
        }

        if (session.getAttribute("UsuarioLogado") == null ) {

%>
<form action="index.jsp" method="post">
    <h2>Usuário:<input type="text" name="txtUsuario"/> </h2>
    <h2>Senha:<input type="password" name="txtSenha"/> </h2>
    <input type="submit" value="login" />
</form>
<%
} else {
%>
<form action="index.jsp" method="post">
    <h1>Área Administrativa [
<%
    out.println(session.getAttribute("UsuarioLogado"));
%>
    ] <input type="submit" name ="sair" value="sair"/></h1>
</form>
    <hr/>
    <a href="link1">Menu1</a><br/>
    <a href="link1">Menu2</a><br/>
    <a href="link1">Menu3</a><br/>
    <a href="link1">Menu4</a><br/>
    <hr/>

<%
        }
%>
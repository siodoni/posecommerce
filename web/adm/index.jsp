<jsp:useBean id="usuario" scope="page"  class="ecommerce.modelo.UsuarioBean" />
<%
            usuario.setUsuario(request.getParameter("txtUsuario"));
            usuario.setSenha(request.getParameter("txtSenha"));

            if (usuario.getUsuario() != null) {
                if (usuario.login()) {
                    session.setAttribute("UsuarioLogado", usuario.getUsuario());
                } else {
%>
<script type="text/javascript">alert("Usu�rio ou senha inv�lida!")</script>
<%                                    }
            }

            if (request.getParameter("sair") != null) {
                session.removeAttribute("UsuarioLogado");
            }

            if (session.getAttribute("UsuarioLogado") == null) {

%>
<form action="index.jsp" method="post">
    <h2>Usu�rio:<input type="text" name="txtUsuario"/> </h2>
    <h2>Senha:<input type="password" name="txtSenha"/> </h2>
    <input type="submit" value="login" />
</form>
<%          } else {
%>
<form action="index.jsp" method="post">
    <h1>�rea Administrativa [
        <%
                        out.println(session.getAttribute("UsuarioLogado"));
        %>
        ] <input type="submit" name ="sair" value="sair"/></h1>
</form>
<%
                //Testando a permiss�o do usu�rio
                //Verificar o momento que dever� ser feita essa checagem...
                if (usuario.getTpPermissao(usuario.getUsuario()).equals("admin")) {
%>
<hr/>
<a href="link1">Menu 1</a><br/>
<a href="link1">Menu 2</a><br/>
<a href="link1">Menu 3</a><br/>
<a href="link1">Menu 4</a><br/>
<hr/>
<%              }
            }
%>
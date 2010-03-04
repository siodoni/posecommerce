<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="usuario" scope="page" class="ecommerce.modelo.UsuarioBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
    </head>
    <body>
        <%
              if (request.getParameter("pSenha").equals(request.getParameter("pSenha2")) == false) {
        %>
                <script language="javascript" type="text/javascript">
                    alert("Senha Inválida!");
                    document.location.href = "novousuario.jsp";
                </script>
        <%
              } else {

                    usuario.setIdUsuario(Integer.parseInt(request.getParameter("pIdUsuario")));
                    usuario.setNome(request.getParameter("pNome"));
                    usuario.setPermissao("user");
                    usuario.setSenha(request.getParameter("pSenha"));
                    usuario.setUsuario(request.getParameter("pUsuario"));
                    usuario.alterarUsuario();
        %>
                <script language="javascript" type="text/javascript">
                    alert("Usuário gravado com sucesso!");
                    document.location.href = "index.jsp";
                </script>
        <%
             }
        %>
    </body>
</html>
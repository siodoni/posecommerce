<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="usuario" scope="page" class="ecommerce.modelo.UsuarioBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
    </head>
    <body>
        <%
                    boolean prossegue = true;
                    String mensagem = "";
                    int idUsuario = Integer.parseInt(request.getParameter("pIdUsuario"));

                    try {
                        usuario.excluirUsuario(idUsuario);
                    } catch (Exception e) {
                        prossegue = false;
                        mensagem = e.toString();
                    }

                    if (prossegue) {
        %>
        <script language="javascript" type="text/javascript">
            alert("Usuário excluído com sucesso!");
            document.location.href = "listausuario.jsp";
        </script>
        <%          } else {
                        out.println("<center>");
                        out.println("<h1><img src=\"img/excluir.gif\" alt=\"erro\"/>&nbsp;Erro</h1>");
                        out.println("<br/>" + mensagem + "<br/><br/>");
                        out.println("<a href=\"javascript:window.history.go(-1)\">Voltar</a>");
                        out.println("</center>");
                    }
        %>
    </body>
</html>
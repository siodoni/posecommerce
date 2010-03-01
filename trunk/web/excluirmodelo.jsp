<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="modelo" scope="page" class="ecommerce.modelo.ModeloBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
    </head>
    <body>
        <%
                    int idModelo = Integer.parseInt(request.getParameter("pModelo"));
                    modelo.excluirModelo(idModelo);
        %>
        <script language="javascript" type="text/javascript">
            alert("Modelo Excluída com Sucesso!");
            document.location.href = "listamodelo.jsp";
        </script>
    </body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="marca" scope="page" class="ecommerce.modelo.MarcaBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
    </head>
    <body>
        <%
                    marca.setIdMarca(Integer.parseInt(request.getParameter("pMarca")));
                    marca.setDescricao(request.getParameter("pDescricao"));
                    marca.alterarMarca();

        %>
        <script language="javascript" type="text/javascript">
            alert("Marca Gravada com Sucesso!");
            document.location.href = "listamarca.jsp";
        </script>
    </body>
</html>
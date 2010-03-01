<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="departamento" scope="page" class="ecommerce.modelo.DepartamentoBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
    </head>
    <body>
        <%
                    departamento.setIdDepartamento(Integer.parseInt(request.getParameter("pDepartamento")));
                    departamento.setDescricao(request.getParameter("pDescricao"));
                    departamento.alterarDepartamento();

        %>
        <script language="javascript" type="text/javascript">
            alert("Departamento Gravada com Sucesso!");
            document.location.href = "listadepartamento.jsp";
        </script>
    </body>
</html>
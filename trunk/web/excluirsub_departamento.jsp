<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="sub_departamento" scope="page" class="ecommerce.modelo.Sub_departamentoBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
    </head>
    <body>
        <%
                    int idSub_departamento = Integer.parseInt(request.getParameter("pSub_departamento"));
                    sub_departamento.excluirSub_departamento(idSub_departamento);
        %>
        <script language="javascript" type="text/javascript">
            alert("Sub_departamento Excluída com Sucesso!");
            document.location.href = "listasub_departamento.jsp";
        </script>
    </body>
</html>
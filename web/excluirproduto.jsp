<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="produto" scope="page" class="ecommerce.modelo.ProdutoBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
    </head>
    <body>
        <%
                    int idProduto = Integer.parseInt(request.getParameter("pProduto"));
                    produto.excluirProduto(idProduto);
        %>
        <script language="javascript" type="text/javascript">
            alert("Produto Excluída com Sucesso!");
            document.location.href = "listaprod.jsp";
        </script>
    </body>
</html>
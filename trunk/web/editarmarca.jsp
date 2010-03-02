<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="marca" scope="page" class="ecommerce.modelo.MarcaBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
    </head>
    <body>
        <jsp:include page="topo.jsp"></jsp:include>
        <%
                    int idMarca = Integer.parseInt(request.getParameter("pMarca"));
                    marca.listarMarca(idMarca);
        %>
        <h1 align="center">Editar Marca</h1>
        <br/>
        <form action="gravarmarca.jsp" method="post" name="frm">
            <input value="<%out.print(marca.getIdMarca());%>"
                   type="hidden" name="pMarca" id="pMarca"/>
            <table align="center">
                <tr>
                    <td>
                        <label for="pDescricao">Descrição:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idMarca != 0) {
                                        out.print(marca.getDescricao());
                                    }%>"
                               type="text" size="40" maxlength="40" name="pDescricao" id="pDescricao"/>
                        <br/>
                    </td>
                </tr>
            </table>

            <br/>
            <center>
                <a href="javascript:document.frm.submit();">Salvar</a>
                <b>|</b>
                <a href="listamarca.jsp">Cancelar</a>
            </center>
        </form>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>


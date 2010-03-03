<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="departamento" scope="page" class="ecommerce.modelo.DepartamentoBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
    </head>
    <body>
        <jsp:include page="topo.jsp"></jsp:include>
        <%
                    int idDepartamento = Integer.parseInt(request.getParameter("pDepartamento"));
                    departamento.listarDepartamento(idDepartamento);
        %>
        <h1 align="center">Editar Departamento</h1>
        <br/>
        <form action="gravardepartamento.jsp" method="post" name="frm">
            <input value="<%out.print(departamento.getIdDepartamento());%>"
                   type="hidden" name="pDepartamento" id="pDepartamento"/>
            <table align="center">
                <tr>
                    <td>
                        <label for="pDescricao">Descrição:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idDepartamento != 0) {
                                        out.print(departamento.getDescricao());
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
                <a href="listadepartamento.jsp">Cancelar</a>
            </center>
        </form>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>
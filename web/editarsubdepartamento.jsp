<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="subdepartamento" scope="page" class="ecommerce.modelo.SubDepartamentoBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
    </head>
    <body>
        <jsp:include page="topo.jsp"></jsp:include>
        <%
                    int idSubDepartamento = Integer.parseInt(request.getParameter("pSubDepartamento"));
                    subdepartamento.listarSubDepartamento(idSubDepartamento);
        %>
        <h1 align="center">Editar Sub-departamento</h1>
        <br/>
        <form action="gravarsubdepartamento.jsp" method="post" name="frm">
            <input value="<%out.print(subdepartamento.getIdSubDepartamento());%>"
                   type="hidden" name="pSubDepartamento" id="pSubDepartamento"/>
            <table align="center">
                <tr>
                    <td>
                        <label for="pDescricao">Descrição:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idSubDepartamento != 0) {
                                        out.print(subdepartamento.getDescricao());
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
                <a href="listasubdepartamento.jsp">Cancelar</a>
            </center>
        </form>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>
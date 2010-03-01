<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="sub_departamento" scope="page" class="ecommerce.modelo.Sub_departamentoBean"/>
<html>
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
           <link rel="StyleSheet" href="css/geral.css" type="text/css">
    </head>
    <body>

    <jsp:include page="topo.jsp"></jsp:include>

    <%
                int idSub_departamento = Integer.parseInt(request.getParameter("pSub_departamento"));
                sub_departamento.listarSub_departamento(idSub_departamento);
    %>
        <h1 align="center">Editar Sub-departamento</h1>
        <br/>
        <form action="gravarsub_departamento.jsp" method="post" name="frm">
            <input value="<%out.print(sub_departamento.getIdSub_departamento());%>"
                   type="hidden" name="pSub_departamento" id="pSub_departamento"/>
            <table align="center">
                <tr>
                    <td>
                        <label for="pDescricao">Descrição:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idSub_departamento!= 0) {
                                        out.print(sub_departamento.getDescricao());
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
                <a href="listasub_departamento.jsp">Cancelar</a>
            </center>
        </form>


    <jsp:include page="rodape.jsp"></jsp:include>

</body>
</html>


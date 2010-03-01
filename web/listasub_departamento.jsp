<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
           
    <script language="javascript" type="text/javascript">
        function excluir(pSub_departamento) {
            if (confirm("Confirma a exclusão do registro?")) {
                document.location.href = "excluirsub_departamento.jsp?pSub_departamento=" + pSub_departamento;
            }
        }
    </script>
    </head>
    <body>

    <jsp:include page="topo.jsp"></jsp:include>

        <h1 align="center">Cadastro de Sub_departamentos</h1>
        <br/>
        <table width="80%" align="center">
            <tr>
                <td width="80%" class="titulo">Descrição</td>
                <td width="10%" class="titulo" align="center">Alterar</td>
                <td width="10%" class="titulo" align="center">Excluir</td>
            </tr>
            <%
                        String css;
                        int cont = 0;

                        String sql =
                                "  select descricao, "
                                + "       id_sub_departamento "
                                + "  from sub_departamento"
                                + " order by descricao";
                        Connection conn;
                        ResultSet rs;
                        Conexao conecta;
                        CallableStatement clst;

                        conecta = new Conexao();
                        conn = conecta.metodoConecta();
                        clst = conn.prepareCall(sql);
                        rs = clst.executeQuery();

                        while (rs.next()) {
                            cont++;

                            if (cont % 2 == 0) {
                                css = "par";
                            } else {
                                css = "impar";
                            }

                            out.println("<tr>");
                            out.println("<td class=\"" + css + "\">");
                            out.println(rs.getString(1));
                            out.println("</td>");
                            out.println("<td class=\"" + css + "\" align=\"center\">");
                            out.println("<a href=\"editarsub_departamento.jsp?pSub_departamento=" + rs.getInt(2) + "\"><img src=\"img/editar.png\" alt=\"editar\"/></a>");
                            out.println("</td>");
                            out.println("<td class=\"" + css + "\" align=\"center\">");
                            out.println("<a href=\"javascript:excluir(" + rs.getInt(2) + ");\"><img src=\"img/excluir.gif\" alt=\"excluir\"/></a>");
                            out.println("</td>");
                            out.println("</tr>");
                        }

                        rs.getStatement().close();
                        clst.close();
                        conn.close();
            %>
        </table>
        <br/>
        <center>
            <a href="editarsub_departamento.jsp?pSub_departamento=0">Incluir</a>
            <a href="indexadmin.jsp">Voltar</a>
        </center>

        <jsp:include page="rodape.jsp"></jsp:include>

</body>
</html>


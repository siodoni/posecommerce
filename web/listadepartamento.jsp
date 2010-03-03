<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
        <script language="javascript" type="text/javascript">
            function excluir(pDepartamento) {
                if (confirm("Confirma a exclusão do registro?")) {
                    document.location.href = "excluirdepartamento.jsp?pDepartamento=" + pDepartamento;
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="topo.jsp"></jsp:include>
        <h1 align="center">Cadastro de Departamentos</h1>
        <br/>
        <table width="80%" align="center">
            <tr>
                <td class="titulo">Descrição</td>
                <td width="10%" class="titulo" align="center">Alterar</td>
                <td width="10%" class="titulo" align="center">Excluir</td>
            </tr>
            <%
                        String css;
                        int cont = 0;

                        String sql =
                                "  select descricao, "
                                + "       id_departamento "
                                + "  from departamento"
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
                            out.println("<a href=\"editardepartamento.jsp?pDepartamento=" + rs.getInt(2) + "\"><img src=\"img/editar.png\" alt=\"editar\"/></a>");
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
            <a href="editardepartamento.jsp?pDepartamento=0">Incluir</a>
            &nbsp;|&nbsp;
            <a href="index.jsp">Voltar</a>
        </center>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>


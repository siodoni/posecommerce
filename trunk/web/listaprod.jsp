<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>

        <script language="javascript" type="text/javascript">
            function excluir(pProduto) {
                if (confirm("Confirma a exclusão do registro?")) {
                    document.location.href = "excluirproduto.jsp?pProduto=" + pProduto;
                }
            }
        </script>
    </head>
    <body>

        <jsp:include page="topo.jsp"></jsp:include>

        <h1 align="center">Cadastro de Produtos</h1>
        <br/>
        <table width="80%" align="center">
            <tr>
                <td width="30%" class="titulo">Descrição</td>
                <td width="20%" class="titulo">Departamento</td>
                <td width="20%" class="titulo">Sub-departamento</td>
                <td width="20%" class="titulo">Modelo</td>
                <td width="20%" class="titulo">Cor</td>
                <td width="20%" class="titulo">Imagem</td>
                <td width="10%" class="titulo" align="center">Alterar</td>
                <td width="10%" class="titulo" align="center">Excluir</td>
            </tr>
            <%
                        String css;
                        int cont = 0;

                        String sql =
                                "select produto.id_produto, "
                                + " produto.descricao,"
                                + " departamento.descricao as departamento, "
                                + " sub_departamento.descricao as sub_departamento, "
                                + " modelo.descricao as modelo, "
                                + " cor.descricao as cor, "
                                + " imagem "
                                + " from produto "
                                + " inner join departamento on departamento.id_departamento = produto.departamento"
                                + " inner join sub_departamento on sub_departamento.id_sub_departamento = produto.sub_departamento"
                                + " inner join modelo on modelo.id_modelo = produto.modelo"
                                + " inner join cor on cor.id_cor = produto.cor"
                                + " ORDER BY produto.descricao";
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
                            out.println("<td class=\"" + css + "\">" + rs.getString(2) + "</td>");
                            out.println("<td class=\"" + css + "\">" + rs.getString(3) + "</td>");
                            out.println("<td class=\"" + css + "\">" + rs.getString(4) + "</td>");
                            out.println("<td class=\"" + css + "\">" + rs.getString(5) + "</td>");
                            out.println("<td class=\"" + css + "\">" + rs.getString(6) + "</td>");
                            out.println("<td class=\"" + css + "\">" + rs.getString(7) + "</td>");
                            out.println("<td class=\"" + css + "\" align=\"center\">");
                            out.println("<a href=\"editarproduto.jsp?pProduto=" + rs.getInt(1) + "\"><img src=\"img/editar.png\" alt=\"editar\"/></a>");
                            out.println("</td>");
                            out.println("<td class=\"" + css + "\" align=\"center\">");
                            out.println("<a href=\"javascript:excluir(" + rs.getInt(1) + ");\"><img src=\"img/excluir.gif\" alt=\"excluir\"/></a>");
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
            <a href="editarproduto.jsp?pProduto=0">Incluir</a>
            <a href="index.jsp">Voltar</a>
        </center>

        <jsp:include page="rodape.jsp"></jsp:include>

    </body>
</html>


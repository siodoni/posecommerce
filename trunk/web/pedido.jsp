<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
        <script language="javascript" type="text/javascript">
            function excluir(pPedidoItem) {
                if (confirm("Confirma a exclusão do registro?")) {
                    document.location.href = "excluirpedido.jsp?pPedidoItem=" + pPedidoItem;
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="topo.jsp"></jsp:include>
        <h1 align="center">Meu Pedido</h1>
        <br/>
        <table width="80%" align="center">
            <tr>
                <td class="titulo">Produto</td>
                <td class="titulo">Quantidade</td>
                <td class="titulo">Valor</td>
                <td width="10%" class="titulo" align="center"></td>
            </tr>
            <%
                        String css;
                        int cont = 0;

                        String sql =
                                "select i.id_pedido_item," 
                              + "m.descricao || ' ' || p.descricao || ' ' || ma.descricao as produto , "
                              + " i.quantidade,i.vlr_venda"
                              + "  from pedido_item i "
                              + "  inner join pedido ped on ped.id_pedido = i.pedido"
                              + "  inner join produto p on p.id_produto = i.produto"
                              + "  inner join modelo m on m.id_modelo = p.modelo"
                              + "  inner join marca ma on ma.id_marca = m.marca"
                              + "  where ped.usuario = " + session.getAttribute("IdUsuario").toString();
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
            <a href="index.jsp">Voltar</a>
        </center>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="StyleSheet" href="css/dtree.css" type="text/css">
        <title>Lista Produto</title>
    </head>
    <body>
        <%
                    String produto = request.getParameter("pProduto");
                    String sql =
                            "  select '<tr><td colspan=2><img src=''' || nvl(a.imagem,'img/sem_foto.png') || '''/></td></tr>' imagem, "
                            + "       '<tr><td>Descrição</td><td>'|| a.descricao || ' - ' || b.descricao || '</td></tr>' descricao, "
                            + "       '<tr><td>Marca</td><td>'|| c.descricao || '</td></tr>' marca, "
                            + "       '<tr><td>Quantidade</td><td>'|| a.quantidade || '</td></tr>' quantidade, "
                            + "       '<tr><td>Preço unitário</td><td>'|| to_char(a.preco_unit,'fm9g999g999d00') || '</td></tr>' preco_unit, "
                            + "       '<tr><td>Cor</td><td>'|| d.descricao || '</td></tr>' cor, "
                            + "       '<tr><td colspan=2><hr/></td></tr>' divisor "
                            + "  from cor d, "
                            + "       marca c, "
                            + "       modelo b, "
                            + "       produto a "
                            + " where a.departamento || a.sub_departamento || b.marca || a.modelo = ? "
                            + "   and b.id_modelo = a.modelo "
                            + "   and c.id_marca  = b.marca "
                            + "   and d.id_cor    = a.cor ";

                    Connection conn;
                    ResultSet rs;
                    Conexao conecta;
                    CallableStatement clst;

                    conecta = new Conexao();
                    conn = conecta.metodoConecta();
                    clst = conn.prepareCall(sql);
                    clst.setString(1, produto);
                    rs = clst.executeQuery();

                    out.println("<table>");
                    while (rs.next()) {
                        out.println(rs.getString(1));
                        out.println(rs.getString(2));
                        out.println(rs.getString(3));
                        out.println(rs.getString(4));
                        out.println(rs.getString(5));
                        out.println(rs.getString(6));
                        out.println(rs.getString(7));
                    }
                    out.println("</table>");

                    rs.getStatement().close();
                    clst.close();
                    conn.close();
        %>
    </body>
</html>

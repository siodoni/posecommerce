<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="StyleSheet" href="css/geral.css" type="text/css">
        <title>Lista Produto</title>
    </head>
    <body>
        <%
                    String tableAnt = "", localAnt = "";
                    String produto = request.getParameter("pProduto");
                    String nivel = request.getParameter("pNivel");
                    String sql =
                            "select '<tr><td colspan=2><img src=''img/' || nvl(a.imagem, 'sem_foto.png') || "
                            + "       '''/></td></tr>' imagem, "
                            + "       '<tr><td>Descrição</td><td>' || a.descricao || ' - ' || b.descricao || "
                            + "       '</td></tr>' descricao, "
                            + "       '<tr><td>Marca</td><td>' || c.descricao || '</td></tr>' marca, "
                            + "       '<tr><td>Quantidade</td><td>' || a.quantidade || '</td></tr>' quantidade, "
                            + "       '<tr><td>Preço unitário</td><td>' || "
                            + "       to_char(a.preco_unit, 'fm9g999g999d00') || '</td></tr>' preco_unit, "
                            + "       '<tr><td>Cor</td><td>' || d.descricao || '</td></tr>' cor, "
                            + "       '<tr><td colspan=2><hr/></td></tr>' divisor, "
                            + "       case when ? = 1 "
                            + "            then '<b><a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) ||                                                                      '&pNivel=1\">' || initcap(e.descricao) || '</a></b>' "
                            + "            when ? = 2 "
                            + "            then '   <a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) ||                                                                      '&pNivel=1\">' || initcap(e.descricao) || '</a> - ' || "
                            + "                 '<b><a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) ||                                        '&pNivel=2\">' || initcap(f.descricao) || '</a></b>' "
                            + "            when ? = 3 "
                            + "            then '   <a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) ||                                                                      '&pNivel=1\">' || initcap(e.descricao) || '</a> - ' || "
                            + "                 '   <a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) ||                                        '&pNivel=2\">' || initcap(f.descricao) || '</a> - ' || "
                            + "                 '<b><a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) || nvl(b.marca, 0) ||                     '&pNivel=3\">' || initcap(c.descricao) || '</a></b>' "
                            + "            when ? = 4 "
                            + "            then '   <a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) ||                                                                      '&pNivel=1\">' || initcap(e.descricao) || '</a> - ' || "
                            + "                 '   <a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) ||                                        '&pNivel=2\">' || initcap(f.descricao) || '</a> - ' || "
                            + "                 '   <a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) || nvl(b.marca, 0) ||                     '&pNivel=3\">' || initcap(c.descricao) || '</a> - ' || "
                            + "                 '<b><a href=\"listaProduto.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) || nvl(b.marca, 0) || nvl(a.modelo, 0) || '&pNivel=4\">' || initcap(b.descricao) || '</a></b>' "
                            + "       end local "
                            + "  from sub_departamento f, "
                            + "       departamento e, "
                            + "       cor d, "
                            + "       marca c,"
                            + "       modelo b,"
                            + "       produto a "
                            + " where ( "
                            + "        ( "
                            + "         ? = 1 "
                            + "   and   nvl(a.departamento, 0) = ? "
                            + "        ) "
                            + "    or  ( "
                            + "         ? = 2 "
                            + "   and   nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) = ? "
                            + "        ) "
                            + "    or  ( "
                            + "        ? = 3 "
                            + "   and  nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) || nvl(b.marca, 0) = ? "
                            + "        ) "
                            + "    or  ( "
                            + "        ? = 4 "
                            + "   and  nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) || nvl(b.marca, 0) || nvl(a.modelo, 0) = ? "
                            + "        ) "
                            + "       ) "
                            + "   and b.id_modelo           = a.modelo "
                            + "   and c.id_marca            = b.marca "
                            + "   and d.id_cor              = a.cor "
                            + "   and e.id_departamento     = a.departamento "
                            + "   and f.id_sub_departamento = a.sub_departamento"
                            + " order by a.departamento, a.sub_departamento, b.marca, a.modelo, a.id_produto ";
                    Connection conn;
                    ResultSet rs;
                    Conexao conecta;
                    CallableStatement clst;

                    conecta = new Conexao();
                    conn = conecta.metodoConecta();
                    clst = conn.prepareCall(sql);
                    clst.setString(1, nivel);
                    clst.setString(2, nivel);
                    clst.setString(3, nivel);
                    clst.setString(4, nivel);
                    clst.setString(5, nivel);
                    clst.setString(6, produto);
                    clst.setString(7, nivel);
                    clst.setString(8, produto);
                    clst.setString(9, nivel);
                    clst.setString(10, produto);
                    clst.setString(11, nivel);
                    clst.setString(12, produto);
                    rs = clst.executeQuery();

                    while (rs.next()) {
                        if (!localAnt.equalsIgnoreCase(rs.getString(8) + "<br/><br/>")) {
                            out.println(rs.getString(8) + "<br/><br/>");
                        }

                        if (!tableAnt.equalsIgnoreCase("<table>")) {
                            out.println("<table>");
                        }
                        out.println(rs.getString(1));
                        out.println(rs.getString(2));
                        out.println(rs.getString(3));
                        out.println(rs.getString(4));
                        out.println(rs.getString(5));
                        out.println(rs.getString(6));
                        out.println(rs.getString(7));
                        tableAnt = "<table>";
                        localAnt = rs.getString(8) + "<br/><br/>";
                    }
                    out.println("</table>");

                    rs.getStatement().close();
                    clst.close();
                    conn.close();
        %>
    </body>
</html>

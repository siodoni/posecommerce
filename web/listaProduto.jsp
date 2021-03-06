<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
        <title>Lista Produto</title>
    </head>
    <body>
        <%
                    String tableAnt = "", localAnt = "";
                    String produto = request.getParameter("pProduto");
                    String nivel = request.getParameter("pNivel");
                    String restricao = "";
                    boolean usuarioLogado = false;
                    
                    if (request.getParameter("pRestricao")!=null) {
                        restricao = request.getParameter("pRestricao");
                    }

                    if (session.getAttribute("UsuarioPermissao") != null) {
                        usuarioLogado = true;
                    } else {
                        usuarioLogado = false;
                    }

                    String sql =
                            "  select '<tr><td colspan=2><img src=''img/' || nvl(a.imagem, 'sem_foto.png') || "
                            + "       '''/></td></tr>' imagem, "
                            + "       '<tr><td>Descrição</td><td>' || a.descricao || ' - ' || b.descricao || "
                            + "       '</td></tr>' descricao, "
                            + "       '<tr><td>Marca</td><td>' || c.descricao || '</td></tr>' marca, "
                            + "       '<tr><td>Quantidade</td><td>' || pECommerce.fRetornaQtdDisp(a.id_produto) || '</td></tr>' quantidade, "
                            + "       '<tr><td>Preço unitário</td><td>' || "
                            + "       to_char(pECommerce.fRetornaVlrVenda(a.id_produto,'MAX'), 'fm9g999g990d00') || '</td></tr>' preco_unit, "
                            + "       '<tr><td>Cor</td><td>' || d.descricao || '</td></tr>' cor, "
                            + "       '<tr><td colspan=2><hr/></td></tr>' divisor, "
                            + "       case when ? = 1 "
                            + "            then '<b><a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) ||                                                                      '&pNivel=1\">' || initcap(e.descricao) || '</a></b>' "
                            + "            when ? = 2 "
                            + "            then '   <a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) ||                                                                      '&pNivel=1\">' || initcap(e.descricao) || '</a> - ' || "
                            + "                 '<b><a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) ||                                        '&pNivel=2\">' || initcap(f.descricao) || '</a></b>' "
                            + "            when ? = 3 "
                            + "            then '   <a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) ||                                                                      '&pNivel=1\">' || initcap(e.descricao) || '</a> - ' || "
                            + "                 '   <a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) ||                                        '&pNivel=2\">' || initcap(f.descricao) || '</a> - ' || "
                            + "                 '<b><a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) || nvl(b.marca, 0) ||                     '&pNivel=3\">' || initcap(c.descricao) || '</a></b>' "
                            + "            when ? = 4 "
                            + "            then '   <a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) ||                                                                      '&pNivel=1\">' || initcap(e.descricao) || '</a> - ' || "
                            + "                 '   <a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) ||                                        '&pNivel=2\">' || initcap(f.descricao) || '</a> - ' || "
                            + "                 '   <a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) || nvl(b.marca, 0) ||                     '&pNivel=3\">' || initcap(c.descricao) || '</a> - ' || "
                            + "                 '<b><a href=\"index.jsp?pProduto=' || nvl(a.departamento, 0) || nvl(a.sub_departamento, 0) || nvl(b.marca, 0) || nvl(a.modelo, 0) || '&pNivel=4\">' || initcap(b.descricao) || '</a></b>' "
                            + "       end local, a.id_produto, pECommerce.fRetornaVlrVenda(a.id_produto,'MAX') as vlrvenda  "
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
                            + "   and (a.descricao || b.descricao || c.descricao) like upper(?)"
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
                    clst.setString(13, "%" + restricao + "%");
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

                        if (usuarioLogado) {
                            out.println("<tr>");
                            out.println("<form action=\"gravarpedido.jsp\" method=\"post\">");
                            out.println("<td>");
                            out.println("Qtd.<input name=\"pQtde\" type=\"text\" size=\"3\" maxlength=\"3\" value=\"1\" />");
                            out.println("<input name=\"pProduto\" type=\"hidden\" value=\""+ rs.getString("id_produto")  + "\" />");
                            out.println("<input name=\"pVlrVenda\" type=\"hidden\" value=\""+ rs.getString("vlrvenda")  + "\" />");
                            out.println("</td>");
                            out.println("<td><input type=\"submit\" class=\"comprar\" value=\"Comprar\"/></td>");
                            out.println("</form>");
                            out.println("</tr>");
                        }
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

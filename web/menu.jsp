<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html>
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" name="generator" content="HelpNDoc v1.10 Free">
        <link rel="StyleSheet" href="css/dtree.css" type="text/css">
        <script type="text/javascript" src="js/dtree.js"></script>
    </head>
    <body>
        <table width="30%" border="0" align="left">
            <tr>
                <td width="20%" height="100%" valign="top">
                    <%

                                out.println("<script type='text/javascript'>");
                                out.println("d = new dTree('d');");
                                out.println("d.config.target = 'FrameMain';");
                                out.println("d.add(0,-1,'Menu','javascript:document.write()');");

                                String sql =
                                        "  select b.id_departamento     id_departamento, "
                                        + "       initcap(b.descricao)  departamento, "
                                        + "       b.id_departamento "
                                        + "     ||c.id_sub_departamento id_sub_departamento, "
                                        + "       initcap(c.descricao)  sub_departamento, "
                                        + "       b.id_departamento "
                                        + "     ||c.id_sub_departamento "
                                        + "     ||e.id_marca            id_marca, "
                                        + "       initcap(e.descricao)  marca, "
                                        + "       b.id_departamento "
                                        + "     ||c.id_sub_departamento "
                                        + "     ||e.id_marca "
                                        + "     ||d.id_modelo           id_modelo, "
                                        + "       initcap(d.descricao)  modelo "
                                        + "  from marca            e, "
                                        + "       modelo           d, "
                                        + "       sub_departamento c, "
                                        + "       departamento     b, "
                                        + "       produto          a "
                                        + " where b.id_departamento     = a.departamento "
                                        + "   and c.id_sub_departamento = a.sub_departamento "
                                        + "   and d.id_modelo           = a.modelo "
                                        + "   and e.id_marca            = d.marca "
                                        + " group by b.id_departamento, "
                                        + "          b.descricao, "
                                        + "          c.id_sub_departamento, "
                                        + "          c.descricao, "
                                        + "          e.id_marca, "
                                        + "          e.descricao, "
                                        + "          d.id_modelo, "
                                        + "          d.descricao "
                                        + " order by b.id_departamento || c.id_sub_departamento || e.id_marca || d.id_modelo ";

                                Connection conn;
                                ResultSet rs;
                                Conexao conecta;
                                CallableStatement clst;

                                conecta = new Conexao();
                                conn = conecta.metodoConecta();
                                clst = conn.prepareCall(sql);
                                rs = clst.executeQuery();

                                while (rs.next()) {
                                    //Departamento
                                    out.println("d.add(" + rs.getString(1) + ",0,'" + rs.getString(2) + "','javascript:document.write()');");
                                    //Sub-Departamento
                                    out.println("d.add(" + rs.getString(3) + "," + rs.getString(1) + ",'" + rs.getString(4) + "','javascript:document.write()');");
                                    //Marca
                                    out.println("d.add(" + rs.getString(5) + "," + rs.getString(3) + ",'" + rs.getString(6) + "','javascript:document.write()');");
                                    //Modelo
                                    out.println("d.add(" + rs.getString(7) + "," + rs.getString(5) + ",'" + rs.getString(8) + "','lista_produto.jsp?pProduto=" + rs.getString(7) + "');");
                                }

                                rs.getStatement().close();
                                clst.close();
                                conn.close();

                                out.println("document.write(d)");
                                out.println("</script>");
                    %>
                </td>
            </tr>
        </table>
    </body>
</html>
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

                                //Só aparece no menu produtos com quantidade
                                //disponivel no estoque maior que ZERO.
                                String sql =
                                        "  select nvl(b.id_departamento,0)     id_departamento, "
                                        + "       initcap(b.descricao)         departamento, "
                                        + "       nvl(b.id_departamento,0) "
                                        + "     ||nvl(c.id_sub_departamento,0) id_sub_departamento, "
                                        + "       initcap(c.descricao)         sub_departamento, "
                                        + "       nvl(b.id_departamento,0) "
                                        + "     ||nvl(c.id_sub_departamento,0) "
                                        + "     ||nvl(e.id_marca,0)            id_marca, "
                                        + "       initcap(e.descricao)         marca, "
                                        + "       nvl(b.id_departamento,0) "
                                        + "     ||nvl(c.id_sub_departamento,0) "
                                        + "     ||nvl(e.id_marca,0) "
                                        + "     ||nvl(d.id_modelo,0)           id_modelo, "
                                        + "       initcap(d.descricao)         modelo "
                                        + "  from marca            e, "
                                        + "       modelo           d, "
                                        + "       sub_departamento c, "
                                        + "       departamento     b, "
                                        + "       produto          a "
                                        + " where b.id_departamento     = a.departamento "
                                        + "   and c.id_sub_departamento = a.sub_departamento "
                                        + "   and d.id_modelo           = a.modelo "
                                        + "   and e.id_marca            = d.marca "
                                        + "   and exists                (select 1 "
                                        + "                                from estoque aa "
                                        + "                               where aa.produto = a.id_produto "
                                        + "                              having sum(aa.qtde_disp) > 0) "
                                        + " group by b.id_departamento, "
                                        + "          b.descricao, "
                                        + "          c.id_sub_departamento, "
                                        + "          c.descricao, "
                                        + "          e.id_marca, "
                                        + "          e.descricao, "
                                        + "          d.id_modelo, "
                                        + "          d.descricao "
                                        + " order by b.id_departamento || c.id_sub_departamento || e.id_marca || d.id_modelo ";

                                String deptoAnt = "", subDeptoAnt = "", marcaAnt = "", modeloAnt = "";

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
                                    if (!deptoAnt.equalsIgnoreCase("d.add(" + rs.getString(1) + ",0,'" + rs.getString(2) + "','listaProduto.jsp?pProduto=" + rs.getString(1) + "&pNivel=1');")) {
                                        out.println("d.add(" + rs.getString(1) + ",0,'" + rs.getString(2) + "','listaProduto.jsp?pProduto=" + rs.getString(1) + "&pNivel=1');");
                                    }

                                    //Sub-Departamento
                                    if (!subDeptoAnt.equalsIgnoreCase("d.add(" + rs.getString(3) + "," + rs.getString(1) + ",'" + rs.getString(4) + "','listaProduto.jsp?pProduto=" + rs.getString(3) + "&pNivel=2');")) {
                                        out.println("d.add(" + rs.getString(3) + "," + rs.getString(1) + ",'" + rs.getString(4) + "','listaProduto.jsp?pProduto=" + rs.getString(3) + "&pNivel=2');");
                                    }

                                    //Marca
                                    if (!marcaAnt.equalsIgnoreCase("d.add(" + rs.getString(5) + "," + rs.getString(3) + ",'" + rs.getString(6) + "','listaProduto.jsp?pProduto=" + rs.getString(5) + "&pNivel=3');")) {
                                        out.println("d.add(" + rs.getString(5) + "," + rs.getString(3) + ",'" + rs.getString(6) + "','listaProduto.jsp?pProduto=" + rs.getString(5) + "&pNivel=3');");
                                    }

                                    //Modelo
                                    if (!modeloAnt.equalsIgnoreCase("d.add(" + rs.getString(7) + "," + rs.getString(5) + ",'" + rs.getString(8) + "','listaProduto.jsp?pProduto=" + rs.getString(7) + "&pNivel=4');")) {
                                        out.println("d.add(" + rs.getString(7) + "," + rs.getString(5) + ",'" + rs.getString(8) + "','listaProduto.jsp?pProduto=" + rs.getString(7) + "&pNivel=4');");
                                    }

                                    deptoAnt = "d.add(" + rs.getString(1) + ",0,'" + rs.getString(2) + "','listaProduto.jsp?pProduto=" + rs.getString(1) + "&pNivel=1');";
                                    subDeptoAnt = "d.add(" + rs.getString(3) + "," + rs.getString(1) + ",'" + rs.getString(4) + "','listaProduto.jsp?pProduto=" + rs.getString(3) + "&pNivel=2');";
                                    marcaAnt = "d.add(" + rs.getString(5) + "," + rs.getString(3) + ",'" + rs.getString(6) + "','listaProduto.jsp?pProduto=" + rs.getString(5) + "&pNivel=3');";
                                    modeloAnt = "d.add(" + rs.getString(7) + "," + rs.getString(5) + ",'" + rs.getString(8) + "','listaProduto.jsp?pProduto=" + rs.getString(7) + "&pNivel=4');";
                                }

                                rs.getStatement().close();
                                clst.close();
                                conn.close();

                                out.println("d.add(999999,0,'Area Administrativa','adm/index.jsp');");

                                out.println("document.write(d)");
                                out.println("</script>");
                    %>
                </td>
            </tr>
        </table>
    </body>
</html>
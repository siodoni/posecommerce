<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" name="generator" content="HelpNDoc v1.10 Free"/>
        <link rel="StyleSheet" href="css/dtree.css" type="text/css"/>
        <script type="text/javascript" src="js/dtree.js"></script>
    </head>
    <body>
        <table border="0" cellpadding="0" cellspacing="0" width="220" style="height: 100%">
            <tr>
                <td><img src="img/spacer.gif" width="10" height="1" border="0" alt="" /></td>
                <td><img src="img/spacer.gif" width="3" height="1" border="0" alt="" /></td>
                <td><img src="img/spacer.gif" width="20" height="1" border="0" alt="" /></td>
                <td><img src="img/spacer.gif" width="4" height="1" border="0" alt="" /></td>
                <td><img src="img/spacer.gif" width="128" height="1" border="0" alt="" /></td>
                <td><img src="img/spacer.gif" width="10" height="1" border="0" alt="" /></td>
                <td><img src="img/spacer.gif" width="38" height="1" border="0" alt="" /></td>
                <td><img src="img/spacer.gif" width="7" height="1" border="0" alt="" /></td>
                <td><img src="img/spacer.gif" width="1" height="1" border="0" alt="" /></td>
            </tr>
            <tr>
                <td colspan="8"><img name="categorias_topo" src="img/categorias_topo.png" width="220" height="46" border="0" id="categorias_topo" alt="" /></td>
                <td><img src="img/spacer.gif" width="1" height="46" border="0" alt="" /></td>
            </tr>
            <tr>
                <td>
                    <img name="categorias_esq" src="img/categorias_esq.png" width="10" height="3" border="0" id="categorias_esq" alt="" />
                </td>
                <td rowspan="2" colspan="6" valign="top" bgcolor="#ffffff">
                    <table border="0" align="left">
                        <tr>
                            <td  height="100%" valign="top">
                                <%
                                            out.println("<script type='text/javascript'>");
                                            out.println("d = new dTree('d');");
                                            //out.println("d.config.target = 'FrameMain';");
                                            out.println("d.add(0,-1,'Menu','index.jsp');");

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
                                                    /*
                                                    + "   and exists                (select 1 "
                                                    + "                                from estoque aa "
                                                    + "                               where aa.produto = a.id_produto "
                                                    + "                              having sum(aa.qtde_disp) > 0) "
                                                    */
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
                                                if (!deptoAnt.equalsIgnoreCase("d.add(" + rs.getString(1) + ",0,'" + rs.getString(2) + "','index.jsp?pProduto=" + rs.getString(1) + "&pNivel=1');")) {
                                                    out.println("d.add(" + rs.getString(1) + ",0,'" + rs.getString(2) + "','index.jsp?pProduto=" + rs.getString(1) + "&pNivel=1');");
                                                }

                                                //Sub-Departamento
                                                if (!subDeptoAnt.equalsIgnoreCase("d.add(" + rs.getString(3) + "," + rs.getString(1) + ",'" + rs.getString(4) + "','index.jsp?pProduto=" + rs.getString(3) + "&pNivel=2');")) {
                                                    out.println("d.add(" + rs.getString(3) + "," + rs.getString(1) + ",'" + rs.getString(4) + "','index.jsp?pProduto=" + rs.getString(3) + "&pNivel=2');");
                                                }

                                                //Marca
                                                if (!marcaAnt.equalsIgnoreCase("d.add(" + rs.getString(5) + "," + rs.getString(3) + ",'" + rs.getString(6) + "','index.jsp?pProduto=" + rs.getString(5) + "&pNivel=3');")) {
                                                    out.println("d.add(" + rs.getString(5) + "," + rs.getString(3) + ",'" + rs.getString(6) + "','index.jsp?pProduto=" + rs.getString(5) + "&pNivel=3');");
                                                }

                                                //Modelo
                                                if (!modeloAnt.equalsIgnoreCase("d.add(" + rs.getString(7) + "," + rs.getString(5) + ",'" + rs.getString(8) + "','index.jsp?pProduto=" + rs.getString(7) + "&pNivel=4');")) {
                                                    out.println("d.add(" + rs.getString(7) + "," + rs.getString(5) + ",'" + rs.getString(8) + "','index.jsp?pProduto=" + rs.getString(7) + "&pNivel=4');");
                                                }

                                                deptoAnt = "d.add(" + rs.getString(1) + ",0,'" + rs.getString(2) + "','index.jsp?pProduto=" + rs.getString(1) + "&pNivel=1');";
                                                subDeptoAnt = "d.add(" + rs.getString(3) + "," + rs.getString(1) + ",'" + rs.getString(4) + "','index.jsp?pProduto=" + rs.getString(3) + "&pNivel=2');";
                                                marcaAnt = "d.add(" + rs.getString(5) + "," + rs.getString(3) + ",'" + rs.getString(6) + "','index.jsp?pProduto=" + rs.getString(5) + "&pNivel=3');";
                                                modeloAnt = "d.add(" + rs.getString(7) + "," + rs.getString(5) + ",'" + rs.getString(8) + "','index.jsp?pProduto=" + rs.getString(7) + "&pNivel=4');";
                                            }

                                            rs.getStatement().close();
                                            clst.close();
                                            conn.close();

                                            if (session.getAttribute("UsuarioPermissao") != null) {
                                                out.println("d.add(999999,0,'Area Administrativa','#');");
                                                if (session.getAttribute("UsuarioPermissao").equals("admin")) {
                                                    out.println("d.add(9999991,999999,'Cad. Marcas','listamarca.jsp');");
                                                    out.println("d.add(9999992,999999,'Cad. Departamentos','listadepartamento.jsp');");
                                                    out.println("d.add(9999993,999999,'Cad. Sub-Deptos','listasubdepartamento.jsp');");
                                                    out.println("d.add(9999994,999999,'Cad. Modelos','listamodelo.jsp');");
                                                    out.println("d.add(9999995,999999,'Cad. Produtos','listaprod.jsp');");
                                                    //out.println("d.add(9999996,999999,'Cad. Estoque','listaestoque.jsp');");
                                                    out.println("d.add(9999997,999999,'Cad. Usuário','listausuario.jsp');");
                                                } else {
                                                    out.println("d.add(999999100,999999,'Meus Pedidos','pedido.jsp');");
                                                }
                                            }

                                            out.println("document.write(d)");
                                            out.println("</script>");
                                %>
                            </td>
                        </tr>
                    </table>
                </td>
                <td><img name="categorias_dir" src="img/categorias_dir.png" width="7" height="3" border="0" id="categorias_dir" alt="" /></td>
                <td><img src="img/spacer.gif" width="1" height="3" border="0" alt="" /></td>
            </tr>
            <tr>
                <td valign="top" style="background-image: url(img/categorias_esq.png);" bgcolor="#ffffff"><p style="margin:0px"></p></td>
                <td valign="top" style="background-image: url(img/categorias_dir.png);" bgcolor="#ffffff"><p style="margin:0px"></p></td>
                <td>
                    <img src="img/spacer.gif" width="1" height="261" border="0" alt="" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <img name="categorias_rod1" src="img/categorias_rod1.png" width="33" height="25" border="0" id="categorias_rod1" alt="" />
                </td>
                <td>
                    <img name="categorias_rod2" src="img/categorias_rod2.png" width="4" height="25" border="0" id="categorias_rod2" alt="" />
                </td>
                <td colspan="3">
                    <img name="categorias_rod3" src="img/categorias_rod3.png" width="176" height="25" border="0" id="categorias_rod3" alt="" />
                </td>
                <td>
                    <img name="menu_r4_c8" src="img/menu_r4_c8.png" width="7" height="25" border="0" id="menu_r4_c8" alt="" />
                </td>
                <td>
                    <img src="img/spacer.gif" width="1" height="25" border="0" alt="" />
                </td>
            </tr>
        </table>
    </body>
</html>
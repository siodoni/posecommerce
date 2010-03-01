<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<jsp:useBean id="produto" scope="page" class="ecommerce.modelo.ProdutoBean"/>
<html>
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
           <link rel="StyleSheet" href="css/geral.css" type="text/css">
    </head>
    <body>

    <jsp:include page="topo.jsp"></jsp:include>

    <%
                int idProduto = Integer.parseInt(request.getParameter("pProduto"));
                produto.listarProduto(idProduto);
    %>
        <h1 align="center">Editar Produto</h1>
        <br/>
        <form action="gravarproduto.jsp" method="post" name="frm">
            <input value="<%out.print(produto.getIdProduto());%>"
                   type="hidden" name="pProduto" id="pProduto"/>
            <table align="center">
                <tr>
                    <td>
                        <label for="pDescricao">Descrição:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idProduto!= 0) {
                                        out.print(produto.getDescricao());
                                    }%>"
                               type="text" size="40" maxlength="40" name="pDescricao" id="pDescricao"/>
                        <br/>
                    </td>
                </tr>


                <tr>
                    <td>
                        <label for="pDepartamento">Departamento:</label>
                        <br/>
                    </td>
                    <td>
                        <select name="pDepartamento" id="pDepartamento">
            <%
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
                            out.println("<option value=" + rs.getString(2) );
                            if (rs.getInt(2) == produto.getDepartamento()) {
                                out.println(" selected ");
                            }
                            out.println(">");
                            out.println(rs.getString(1));
                            out.println("</option>");
                        }

                        rs.getStatement().close();
                        clst.close();
                        conn.close();
            %>
                        </select>
                        <br/>
                    </td>
                </tr>



                <tr>
                    <td>
                        <label for="pSubDepartamento">Sub-departamento:</label>
                        <br/>
                    </td>
                    <td>
                        <select name="pSubDepartamento" id="pSubDepartamento">
            <%
                        sql =
                                "  select descricao, "
                                + "       id_sub_departamento "
                                + "  from sub_departamento"
                                + " order by descricao";
                        conn = conecta.metodoConecta();
                        clst = conn.prepareCall(sql);
                        rs = clst.executeQuery();

                        while (rs.next()) {
                            out.println("<option value=" + rs.getString(2) );
                            if (rs.getInt(2) == produto.getSubDepartamento()) {
                                out.println(" selected ");
                            }
                            out.println(">");
                            out.println(rs.getString(1));
                            out.println("</option>");
                        }

                        rs.getStatement().close();
                        clst.close();
                        conn.close();
            %>
                        </select>
                        <br/>
                    </td>
                </tr>



                <tr>
                    <td>
                        <label for="pModelo">Modelo:</label>
                        <br/>
                    </td>
                    <td>
                        <select name="pModelo" id="pModelo">
            <%
                        sql =
                                "  select descricao, "
                                + "       id_modelo "
                                + "  from modelo"
                                + " order by descricao";
                        conn = conecta.metodoConecta();
                        clst = conn.prepareCall(sql);
                        rs = clst.executeQuery();

                        while (rs.next()) {
                            out.println("<option value=" + rs.getString(2) );
                            if (rs.getInt(2) == produto.getModelo()) {
                                out.println(" selected ");
                            }
                            out.println(">");
                            out.println(rs.getString(1));
                            out.println("</option>");
                        }

                        rs.getStatement().close();
                        clst.close();
                        conn.close();
            %>
                        </select>
                        <br/>
                    </td>
                </tr>


                <tr>
                    <td>
                        <label for="pCor">Cor:</label>
                        <br/>
                    </td>
                    <td>
                        <select name="pCor" id="pCor">
            <%
                        sql =
                                "  select descricao, "
                                + "       id_cor "
                                + "  from cor"
                                + " order by descricao";
                        conn = conecta.metodoConecta();
                        clst = conn.prepareCall(sql);
                        rs = clst.executeQuery();

                        while (rs.next()) {
                            out.println("<option value=" + rs.getString(2) );
                            if (rs.getInt(2) == produto.getCor()) {
                                out.println(" selected ");
                            }
                            out.println(">");
                            out.println(rs.getString(1));
                            out.println("</option>");
                        }

                        rs.getStatement().close();
                        clst.close();
                        conn.close();
            %>
                        </select>
                        <br/>
                    </td>
                </tr>



                <tr>
                    <td>
                        <label for="pImagem">Imagem:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idProduto!= 0) {
                                        out.print(produto.getImagem());
                                    }%>"
                               type="text" size="40" maxlength="200" name="pImagem" id="pImagem"/>
                        <br/>
                    </td>
                </tr>


            </table>

            <br/>
            <center>
                <a href="javascript:document.frm.submit();">Salvar</a>
                <b>|</b>
                <a href="listaprod.jsp">Cancelar</a>
            </center>
        </form>


    <jsp:include page="rodape.jsp"></jsp:include>

</body>
</html>


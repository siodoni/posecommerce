<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<jsp:useBean id="modelo" scope="page" class="ecommerce.modelo.ModeloBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
    </head>
    <body>
        <jsp:include page="topo.jsp"></jsp:include>
        <%
                    int idModelo = Integer.parseInt(request.getParameter("pModelo"));
                    modelo.listarModelo(idModelo);
        %>
        <h1 align="center">Editar Modelo</h1>
        <br/>
        <form action="gravarmodelo.jsp" method="post" name="frm">
            <input value="<%out.print(modelo.getIdModelo());%>"
                   type="hidden" name="pModelo" id="pModelo"/>
            <table align="center">
                <tr>
                    <td>
                        <label for="pDescricao">Descrição:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idModelo != 0) {
                                        out.print(modelo.getDescricao());
                                    }%>"
                               type="text" size="40" maxlength="40" name="pDescricao" id="pDescricao"/>
                        <br/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="pMarca">Marca:</label>
                        <br/>
                    </td>
                    <td>
                        <select name="pMarca" id="pMarca">
                            <%
                                        String sql =
                                                "  select descricao, "
                                                + "       id_marca "
                                                + "  from marca"
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
                                            out.println("<option value=" + rs.getString(2));
                                            if (rs.getInt(2) == modelo.getMarca()) {
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
            </table>
            <br/>
            <center>
                <a href="javascript:document.frm.submit();">Salvar</a>
                <b>|</b>
                <a href="listamodelo.jsp">Cancelar</a>
            </center>
        </form>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>


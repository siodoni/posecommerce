<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<jsp:useBean id="usuario" scope="page" class="ecommerce.modelo.UsuarioBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
    </head>
    <body>
        <jsp:include page="topo.jsp"></jsp:include>
        <%
                    int idUsuario = Integer.parseInt(request.getParameter("pIdUsuario"));
                    usuario.listarUsuario(idUsuario);
        %>
        <h1 align="center">Editar Usuário</h1>
        <br/>
        <form action="gravarusuario.jsp" method="post" name="frm">
            <input value="<%out.print(usuario.getIdUsuario());%>"
                   type="hidden" name="pIdUsuario" id="pIdUsuario"/>
            <table align="center">
                <tr>
                    <td>
                        <label for="pNome">Nome:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idUsuario != 0) {
                                        out.print(usuario.getNome());
                                    }%>"
                               type="text" size="40" maxlength="40" name="pNome" id="pNome"/>
                        <br/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="pUsuario">Usuário:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idUsuario != 0) {
                                        out.print(usuario.getUsuario());
                                    }%>"
                               type="text" size="20" maxlength="20" name="pUsuario" id="pUsuario"/>
                        <br/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="pSenha">Senha:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idUsuario != 0) {
                                        out.print(usuario.getSenha());
                                    }%>"
                               type="password" size="20" maxlength="20" name="pSenha" id="pSenha"/>
                        <br/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="pPermissao">Permissão:</label>
                        <br/>
                    </td>
                    <td>
                        <select name="pPermissao" id="pPermissao">
                            <%
                                        String sql =
                                                "  select 'Administrador' descricao, "
                                                + "       'admin' id_tp_permissao "
                                                + "  from dual  "
                                                + " union "
                                                + "select 'Cliente' descricao, "
                                                + "       'user' id_tp_permissao "
                                                + "  from dual "
                                                + " order by 1";

                                        Connection conn;
                                        ResultSet rs;
                                        Conexao conecta;
                                        CallableStatement clst;

                                        conecta = new Conexao();
                                        conn = conecta.metodoConecta();
                                        clst = conn.prepareCall(sql);
                                        rs = clst.executeQuery();

                                        while (rs.next()) {
                                            out.print("<option value=" + rs.getString(2));
                                            if (rs.getString(2).equalsIgnoreCase(usuario.getTpPermissao())) {
                                                out.print(" selected ");
                                            }
                                            out.print(">");
                                            out.print(rs.getString(1));
                                            out.print("</option>");
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
                <a href="listausuario.jsp">Cancelar</a>
            </center>
        </form>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>
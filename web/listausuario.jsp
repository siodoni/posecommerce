<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
        <script language="javascript" type="text/javascript">
            function excluir(pUsuario) {
                if (confirm("Confirma a exclusão do registro?")) {
                    document.location.href = "excluirusuario.jsp?pIdUsuario=" + pUsuario;
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="topo.jsp"></jsp:include>
        <h1 align="center">Cadastro de Usuários</h1>
        <br/>
        <table width="80%" align="center">
            <tr>
                <td class="titulo">Nome</td>
                <td class="titulo">Usuario</td>
                <td class="titulo">Permissão</td>
                <td width="10%" class="titulo" align="center">Alterar</td>
                <td width="10%" class="titulo" align="center">Excluir</td>
            </tr>
            <%
                        String css;
                        int cont = 0;

                        String sql =
                                "  select a.nome, "
                                + "       a.usuario, "
                                + "       case when a.permissao = 'user' "
                                + "            then 'Cliente' "
                                + "            when a.permissao =  'admin' "
                                + "            then 'Administrador' "
                                + "       end permissao,"
                                + "       a.id_usuario "
                                + "  from usuario a "
                                + " order by a.nome ";
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
                            out.println("<td class=\"" + css + "\">");
                            out.println(rs.getString(1));
                            out.println("</td>");
                            out.println("<td class=\"" + css + "\">");
                            out.println(rs.getString(2));
                            out.println("</td>");
                            out.println("<td class=\"" + css + "\">");
                            out.println(rs.getString(3));
                            out.println("</td>");
                            out.println("<td class=\"" + css + "\" align=\"center\">");
                            out.println("<a href=\"editarusuario.jsp?pIdUsuario=" + rs.getInt(4) + "\"><img src=\"img/editar.png\" alt=\"editar\"/></a>");
                            out.println("</td>");
                            out.println("<td class=\"" + css + "\" align=\"center\">");
                            out.println("<a href=\"javascript:excluir(" + rs.getInt(4) + ");\"><img src=\"img/excluir.gif\" alt=\"excluir\"/></a>");
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
            <a href="editarusuario.jsp?pIdUsuario=0">Incluir</a>
            &nbsp;|&nbsp;
            <a href="index.jsp">Voltar</a>
        </center>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>
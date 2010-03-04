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
                    int idUsuario = 0;
                    usuario.setIdUsuario(0);
        %>
        <h1 align="center">Editar Usuário</h1>
        <br/>
        <form action="gravarnovousuario.jsp" method="post" name="frm">
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
                        <label for="pSenha2">Confirmar Senha:</label>
                        <br/>
                    </td>
                    <td>
                        <input value="<%
                                    if (idUsuario != 0) {
                                        out.print(usuario.getSenha());
                                    }%>"
                               type="password" size="20" maxlength="20" name="pSenha2" id="pSenha2"/>
                        <br/>
                    </td>
                </tr>

            </table>
            <br/>
            <center>
                <a href="javascript:document.frm.submit();">Salvar</a>
                <b>|</b>
                <a href="index.jsp">Cancelar</a>
            </center>
        </form>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>
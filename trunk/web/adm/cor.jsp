<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
        <title>Cor</title>
    </head>
    <body>
        <%
                    Connection conn;
                    ResultSet rs;
                    Conexao conecta;
                    CallableStatement clst;

                    conecta = new Conexao();
                    conn = conecta.metodoConecta();
                    clst = conn.prepareCall("select pECommerce.fRetornaTabelaCorHtml tabela_cor from sys.dual");
                    rs = clst.executeQuery();

                    if (rs.next()) {
                        out.print(rs.getString(1));
                    }

                    rs.getStatement().close();
                    clst.close();
                    conn.close();
        %>
    </body>
</html>
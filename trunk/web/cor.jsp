<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ecommerce.bd.*, java.sql.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="StyleSheet" href="css/geral.css" type="text/css">
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
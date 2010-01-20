<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="ecommerce.bd.*, java.sql.*"%>
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
</html>
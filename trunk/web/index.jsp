<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
        <link rel="StyleSheet" href="css/geral.css" type="text/css"/>
    </head>
    <body>
        <jsp:include page="topo.jsp"></jsp:include>
        <table border="0" width="100%" align="center">
            <tr>
                <td width="200px" valign="top">
                    <jsp:include page="menu.jsp"></jsp:include>
                </td>
                <td width="100%"  valign="top">
                    <jsp:include page="listaProduto.jsp"></jsp:include>
                </td>
            </tr>
        </table>
        <jsp:include page="rodape.jsp"></jsp:include>
    </body>
</html>

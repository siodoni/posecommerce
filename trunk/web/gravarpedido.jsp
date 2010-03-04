<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="pedido" scope="page" class="ecommerce.modelo.PedidoBean"/>
<jsp:useBean id="pedidoItem" scope="page" class="ecommerce.modelo.PedidoItemBean"/>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-br" lang="pt-br">
    <head>
        <title>:::EF - Instrumentos musicais:::</title>
    </head>
    <body>
        <%
                    pedido.listarPedidoUsuario( Integer.parseInt(session.getAttribute("IdUsuario").toString()));
                    if (pedido.getIdPedido()==0) {
                        pedido.setUsuario(Integer.parseInt(session.getAttribute("IdUsuario").toString()));
                        pedido.alterarPedido();
                        pedido.listarPedidoUsuario( Integer.parseInt(session.getAttribute("IdUsuario").toString()));
                    }

                    pedidoItem.setIdPedidoItem(0);
                    pedidoItem.setPedido(pedido.getIdPedido());
                    pedidoItem.setProduto(Integer.parseInt(request.getParameter("pProduto")));
                    pedidoItem.setQuantidade(Integer.parseInt(request.getParameter("pQtde")));
                    pedidoItem.setVlrVenda(Float.parseFloat(request.getParameter("pVlrVenda")));
                    pedidoItem.alterarPedido();
        %>
        <script language="javascript" type="text/javascript">
            alert("Produto comprado com sucesso!");
            document.location.href = "listaProduto.jsp";
        </script>
    </body>
</html>
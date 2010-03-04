<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td><img src="img/spacer.gif" width="3" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="20" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="4" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="128" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="10" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="38" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="7" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="158" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="9" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="138" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="15" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="134" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="3" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="16" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="1" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="6" height="1" border="0" alt="" /></td>
        <td><img src="img/spacer.gif" width="1" height="1" border="0" alt="" /></td>
    </tr>
    <tr>
        <td colspan="16">
            <img name="layoutecommerce_r1_c1" src="img/layout-ecommerce_r1_c1.png" width="700" height="11" border="0" id="layoutecommerce_r1_c1" alt="" />
        </td>
        <td>
            <img src="img/spacer.gif" width="1" height="11" border="0" alt="" />
        </td>
    </tr>
    <tr>
        <td rowspan="4">
            <img name="layoutecommerce_r2_c1" src="img/layout-ecommerce_r2_c1.png" width="13" height="98" border="0" id="layoutecommerce_r2_c1" alt="" />
        </td>
        <td rowspan="3" colspan="3">
            <img name="logo" src="img/logo.png" width="152" height="77" border="0" id="logo" alt="" />
        </td>
        <td rowspan="4">
            <img name="layoutecommerce_r2_c6" src="img/layout-ecommerce_r2_c6.png" width="10" height="98" border="0" id="layoutecommerce_r2_c6" alt="" />
        </td>
        <td rowspan="4" colspan="3">
            <img name="foto" src="img/foto.png" width="203" height="98" border="0" id="foto" alt="" />
        </td>
        <td rowspan="4">
            <img name="layoutecommerce_r2_c10" src="img/layout-ecommerce_r2_c10.png" width="9" height="98" border="0" id="layoutecommerce_r2_c10" alt="" />
        </td>
        <td colspan="3" bgcolor="#6CAA00" >
            <form action="index.jsp" method="get">
                Pesquisa:
                <input name="pRestricao" id="pRestricao" type="text" 
                       value="<% if (request.getParameter("pRestricao")!=null) { out.print(request.getParameter("pRestricao")); } %>"
                       size="20" class="pesquisa"/>
                <input type="hidden" name="pProduto" value="<%= request.getParameter("pProduto") %>" />
                <input type="hidden" name="pNivel" value="<%= request.getParameter("pNivel") %>" />
                <input type="submit" value="Ok" class="pesquisa"/>
            </form>
        </td>
        <td colspan="2">
            <img name="layoutecommerce_r2_c14" src="img/layout-ecommerce_r2_c14.png" width="19" height="48" border="0" id="layoutecommerce_r2_c14" alt="" />
        </td>
        <td rowspan="4" colspan="2">
            <img name="layoutecommerce_r2_c16" src="img/layout-ecommerce_r2_c16.png" width="7" height="98" border="0" id="layoutecommerce_r2_c16" alt="" />
        </td>
        <td>
            <img src="img/spacer.gif" width="1" height="48" border="0" alt="" />
        </td>
    </tr>
    <tr>
        <td colspan="5">
            <img name="layoutecommerce_r3_c11" src="img/layout-ecommerce_r3_c11.png" width="306" height="9" border="0" id="layoutecommerce_r3_c11" alt="" />
        </td>
        <td>
            <img src="img/spacer.gif" width="1" height="9" border="0" alt="" />
        </td>
    </tr>
    <tr>
        <td rowspan="2" style="background-image: url(img/topo_botao1.png);">
            <form action="login.jsp" method="post">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <%
                                if (session.getAttribute("UsuarioLogado") == null) {
                    %>
                    <tr>
                        <td class="login">Login:</td>
                        <td>
                            <input name="txtUsuario" type="text" size="18" value="" class="login" />
                        </td>
                    </tr>
                    <tr>
                        <td class="login">Senha:</td>
                        <td>
                            <input name="txtSenha" type="password" size="8" value="" class="login"/>
                            <input type="submit" value="Ok" name="login" class="login"/>
                        </td>
                    </tr>
                    <%          } else {
                    %>
                    <tr><td  class="login"><strong>Usuário: </strong>
                            <%= session.getAttribute("UsuarioLogado")%>
                        </td>
                        <td>
                            <input type="submit" name ="sair" value="sair"  class="login"/>
                        </td></tr>
                        <%
                                    }
                        %>
                </table>
            </form>
        </td>
        <td rowspan="2"><img name="layoutecommerce_r4_c12" src="img/layout-ecommerce_r4_c12.png" width="15" height="41" border="0" id="layoutecommerce_r4_c12" alt="" /></td>
        <td colspan="2" rowspan="2" style="background-image: url(img/topo_botao2.png);" class="login">
            <center>
                <%
                            if (session.getAttribute("UsuarioLogado") != null) {
                                out.print("<a href='pedido.jsp'>Meu Pedido</a>");
                            } else {
                                out.print("");
                            }
                %>
            </center>
        </td>
        <td rowspan="2"><img name="layoutecommerce_r4_c15" src="img/layout-ecommerce_r4_c15.png" width="16" height="41" border="0" id="layoutecommerce_r4_c15" alt="" /></td>
        <td><img src="img/spacer.gif" width="1" height="20" border="0" alt="" /></td>
    </tr>
    <tr>
        <td colspan="3"><img name="layoutecommerce_r5_c3" src="img/layout-ecommerce_r5_c3.png" width="152" height="21" border="0" id="layoutecommerce_r5_c3" alt="" /></td>
        <td><img src="img/spacer.gif" width="1" height="21" border="0" alt="" /></td>
    </tr>
    <tr>
        <td colspan="16"><img name="layoutecommerce_r6_c1" src="img/layout-ecommerce_r6_c1.png" width="700" height="3" border="0" id="layoutecommerce_r6_c1" alt="" /></td>
        <td><img src="img/spacer.gif" width="1" height="3" border="0" alt="" /></td>
    </tr>
    <tr>
        <td colspan="16"><img name="linha1" src="img/linha1.png" width="700" height="6" border="0" id="linha1" alt="" /></td>
        <td><img src="img/spacer.gif" width="1" height="6" border="0" alt="" /></td>
    </tr>
    <tr>
        <td colspan="17">
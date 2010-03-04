<jsp:useBean id="usuario" scope="page"  class="ecommerce.modelo.UsuarioBean" />
<%
            usuario.setUsuario(request.getParameter("txtUsuario"));
            usuario.setSenha(request.getParameter("txtSenha"));

            if (usuario.getUsuario() != null) {
                if (usuario.login()) {
                    session.setAttribute("IdUsuario", usuario.getIdUsuario());
                    session.setAttribute("UsuarioLogado", usuario.getUsuario());
                    session.setAttribute("UsuarioPermissao", usuario.getTpPermissao());
                } else {
%>
<script type="text/javascript">alert("Usuário ou senha inválida!")</script>
<%                                    }
            }

            if (request.getParameter("sair") != null) {
                session.removeAttribute("IdUsuario");
                session.removeAttribute("UsuarioLogado");
                session.removeAttribute("UsuarioPermissao");
            }

            response.sendRedirect("index.jsp");
%>
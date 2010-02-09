package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioBean {

    private int codigo;
    private String usuario;
    private String senha;

    public UsuarioBean() {
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public boolean login() {
        boolean acesso = false;

        try {
            Connection conn;
            Conexao conecta;

            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    "  select usuario,"
                    + "       senha "
                    + "  from usuario "
                    + " where usuario = ? "
                    + "   and senha = ? ";

            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, this.getUsuario());
            pre.setString(2, this.getSenha());
            ResultSet dados = pre.executeQuery();

            acesso = dados.next() ? true : false;
            conn.close();

        } catch (Exception e) {
            System.out.println("Erro! " + e.getMessage());
        }
        return acesso;
    }
}

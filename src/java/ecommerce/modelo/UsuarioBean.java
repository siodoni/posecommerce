package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioBean {

    private int idUSuario;
    private String usuario;
    private String senha;
    private String permissao;

    public UsuarioBean() {
    }

    public int getIdUSuario() {
        return idUSuario;
    }

    public void setIdUSuario(int idUSuario) {
        this.idUSuario = idUSuario;
    }

    public String getPermissao() {
        return permissao;
    }

    public void setPermissao(String permissao) {
        this.permissao = permissao;
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

    public String getTpPermissao() {
        String tpPermissao = "user";

        try {
            Connection conn;
            Conexao conecta;

            conecta = new Conexao();
            conn = conecta.metodoConecta();

            PreparedStatement ps = conn.prepareStatement(
                    "  select permissao "
                    + "  from usuario "
                    + " where usuario = ? ");
            ps.setString(1, this.getUsuario());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                tpPermissao = rs.getString(1);
            }
            conn.close();

        } catch (Exception e) {
            System.out.println("Erro! " + e.getMessage());
        }
        return tpPermissao;
    }
}

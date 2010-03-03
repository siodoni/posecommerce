package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioBean {

    private int idUsuario;
    private String nome;
    private String usuario;
    private String senha;
    private String permissao;

    public UsuarioBean() {
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
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

    public void listarUsuario(int idUsuario) {
        try {
            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    "  select nome, "
                    + "       usuario, "
                    + "       senha, "
                    + "       permissao, "
                    + "       id_usuario "
                    + "  from usuario "
                    + " where id_usuario = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setIdUsuario(rs.getInt(5));
                setUsuario(rs.getString(2));
                setSenha(rs.getString(3));
                setPermissao(rs.getString(4));
                setNome(rs.getString(1));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void alterarUsuario() {
        try {

            String sql = "";

            if (getIdUsuario() != 0) {
                sql = "    update usuario "
                        + "   set nome       = ?, "
                        + "       usuario    = ?, "
                        + "       senha      = ?, "
                        + "       permissao  = ?"
                        + " where id_usuario = ?";
            } else {
                sql = "    insert into usuario "
                        + "  (nome, usuario, senha, permissao)"
                        + "values"
                        + "  (?, ?, ?, ?)";
            }

            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, getNome());
            ps.setString(2, getUsuario());
            ps.setString(3, getSenha());
            ps.setString(4, getPermissao());

            if (getIdUsuario() != 0) {
                ps.setInt(5, getIdUsuario());
            }
            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluirUsuario(int idUsuario) throws Exception {
        String sql = "delete from usuario where id_usuario = ?";

        Connection conn;
        Conexao conecta;
        conecta = new Conexao();
        conn = conecta.metodoConecta();

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idUsuario);
        ps.executeUpdate();

        ps.close();
        conn.close();
    }
}

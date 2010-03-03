package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DepartamentoBean {

    private int idDepartamento;
    private String descricao;

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getIdDepartamento() {
        return idDepartamento;
    }

    public void setIdDepartamento(int idDepartamento) {
        this.idDepartamento = idDepartamento;
    }

    public void listarDepartamento(int idDepartamento) {
        try {
            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    " select id_departamento, "
                    + "      descricao "
                    + " from departamento "
                    + "where id_departamento = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idDepartamento);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setIdDepartamento(rs.getInt(1));
                setDescricao(rs.getString(2));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void alterarDepartamento() {
        try {

            String sql = "";

            if (getIdDepartamento() != 0) {
                sql = "    update departamento "
                        + "   set descricao = ?"
                        + " where id_departamento = ?";
            } else {
                sql = "    insert into departamento "
                        + "  (descricao)"
                        + "values"
                        + "  (?)";
            }

            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, getDescricao());
            if (getIdDepartamento() != 0) {
                ps.setInt(2, getIdDepartamento());
            }
            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluirDepartamento(int idDepartamento) throws Exception {
        String sql = "delete from departamento where id_departamento = ?";

        Connection conn;
        Conexao conecta;
        conecta = new Conexao();
        conn = conecta.metodoConecta();

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idDepartamento);
        ps.executeUpdate();

        ps.close();
        conn.close();
    }
}

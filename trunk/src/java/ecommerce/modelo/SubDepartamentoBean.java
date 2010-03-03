package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SubDepartamentoBean {

    private int idSubDepartamento;
    private String descricao;

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getIdSubDepartamento() {
        return idSubDepartamento;
    }

    public void setIdSubDepartamento(int idSubDepartamento) {
        this.idSubDepartamento = idSubDepartamento;
    }

    public void listarSubDepartamento(int idSubDepartamento) {
        try {
            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    " select id_sub_departamento, "
                    + "      descricao "
                    + " from sub_departamento "
                    + "where id_sub_departamento = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idSubDepartamento);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setIdSubDepartamento(rs.getInt(1));
                setDescricao(rs.getString(2));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void alterarSubDepartamento() {
        try {

            String sql = "";

            if (getIdSubDepartamento() != 0) {
                sql = "    update sub_departamento "
                        + "   set descricao = ?"
                        + " where id_sub_departamento = ?";
            } else {
                sql = "    insert into sub_departamento "
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
            if (getIdSubDepartamento() != 0) {
                ps.setInt(2, getIdSubDepartamento());
            }
            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluirSubDepartamento(int idSubDepartamento) throws Exception {
        String sql = "delete from sub_departamento where id_sub_departamento = ?";

        Connection conn;
        Conexao conecta;
        conecta = new Conexao();
        conn = conecta.metodoConecta();

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idSubDepartamento);
        ps.executeUpdate();

        ps.close();
        conn.close();
    }
}
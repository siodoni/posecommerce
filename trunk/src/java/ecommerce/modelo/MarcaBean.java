package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MarcaBean {

    private int idMarca;
    private String descricao;

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    public void listarMarca(int idMarca) {
        try {
            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    " select id_marca, "
                    + "      descricao "
                    + " from marca "
                    + "where id_marca = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idMarca);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setIdMarca(rs.getInt(1));
                setDescricao(rs.getString(2));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void alterarMarca() {
        try {

            String sql = "";

            if (getIdMarca() != 0) {
                sql = "    update marca "
                        + "   set descricao = ?"
                        + " where id_marca = ?";
            } else {
                sql = "    insert into marca "
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
            if (getIdMarca() != 0) {
                ps.setInt(2, getIdMarca());
            }
            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluirMarca(int idMarca) throws Exception {
        String sql = "delete from marca where id_marca = ?";

        Connection conn;
        Conexao conecta;
        conecta = new Conexao();
        conn = conecta.metodoConecta();

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idMarca);
        ps.executeUpdate();

        ps.close();
        conn.close();
    }
}

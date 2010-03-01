package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ModeloBean {

    private int idModelo;
    private String descricao;
    private int marca;

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getMarca() {
        return marca;
    }

    public void setMarca(int marca) {
        this.marca = marca;
    }

    public int getIdModelo() {
        return idModelo;
    }

    public void setIdModelo(int idModelo) {
        this.idModelo = idModelo;
    }

    public void listarModelo(int idModelo) {
        try {
            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    " select id_modelo, "
                    + "      descricao,marca "
                    + " from modelo "
                    + "where id_modelo = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idModelo);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setIdModelo(rs.getInt(1));
                setDescricao(rs.getString(2));
                setMarca(rs.getInt(3));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void alterarModelo() {
        try {

            String sql = "";

            if (getIdModelo() != 0) {
                sql = "    update modelo "
                        + " set descricao = ?,"
                        + " marca = ?"
                        + " where id_modelo = ?";
            } else {
                sql = "    insert into modelo "
                        + "  (descricao,marca)"
                        + "values"
                        + "  (?,?)";
            }

            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, getDescricao());
            ps.setInt(2, getMarca());
            if (getIdModelo() != 0) {
                ps.setInt(3, getIdModelo());
            }
            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluirModelo(int idModelo) {
        try {
            String sql = "delete from modelo where id_modelo = ?";

            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idModelo);
            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

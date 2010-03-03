package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProdutoBean {

    private int idProduto;
    private String descricao;
    private int departamento;
    private int subDepartamento;
    private int modelo;
    private int cor;
    private String imagem;

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getCor() {
        return cor;
    }

    public void setCor(int cor) {
        this.cor = cor;
    }

    public int getDepartamento() {
        return departamento;
    }

    public void setDepartamento(int departamento) {
        this.departamento = departamento;
    }

    public int getModelo() {
        return modelo;
    }

    public void setModelo(int modelo) {
        this.modelo = modelo;
    }

    public int getSubDepartamento() {
        return subDepartamento;
    }

    public void setSubDepartamento(int subDepartamento) {
        this.subDepartamento = subDepartamento;
    }

    public String getImagem() {
        return imagem;
    }

    public void setImagem(String imagem) {
        this.imagem = imagem;
    }

    public int getIdProduto() {
        return idProduto;
    }

    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
    }

    public void listarProduto(int idProduto) {
        try {
            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    " select id_produto, "
                    + "      descricao, "
                    + "      departamento, "
                    + "      sub_departamento, "
                    + "      modelo, cor, imagem "
                    + " from produto "
                    + "where id_produto = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idProduto);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setIdProduto(rs.getInt(1));
                setDescricao(rs.getString(2));
                setDepartamento(rs.getInt(3));
                setSubDepartamento(rs.getInt(4));
                setModelo(rs.getInt(5));
                setCor(rs.getInt(6));
                setImagem(rs.getString(7));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void alterarProduto() {
        try {

            String sql = "";

            if (getIdProduto() != 0) {
                sql = "    update produto "
                        + "   set descricao = ?, "
                        + "   departamento = ?, "
                        + "   sub_departamento = ?, "
                        + "   modelo = ?, "
                        + "   cor = ?, "
                        + "   imagem = ? "
                        + " where id_produto = ?";
            } else {
                sql = "    insert into produto "
                        + "  (descricao,departamento, sub_departamento, modelo, cor, imagem)"
                        + "values"
                        + "  (?,?,?,?,?,?)";
            }

            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, getDescricao());
            ps.setInt(2, getDepartamento());
            ps.setInt(3, getSubDepartamento());
            ps.setInt(4, getModelo());
            ps.setInt(5, getCor());
            ps.setString(6, getImagem());
            if (getIdProduto() != 0) {
                ps.setInt(7, getIdProduto());
            }
            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluirProduto(int idProduto) throws Exception {
        String sql = "delete from produto where id_produto = ?";

        Connection conn;
        Conexao conecta;
        conecta = new Conexao();
        conn = conecta.metodoConecta();

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idProduto);
        ps.executeUpdate();

        ps.close();
        conn.close();
    }
}

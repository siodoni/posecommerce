package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ely
 */
public class PedidoItemBean {
    private int idPedidoItem;
    private int pedido;
    private int produto;
    private int quantidade;
    private float vlrVenda;

    public PedidoItemBean() {
    }

    public int getIdPedidoItem() {
        return idPedidoItem;
    }

    public void setIdPedidoItem(int idPedidoItem) {
        this.idPedidoItem = idPedidoItem;
    }

    public int getPedido() {
        return pedido;
    }

    public void setPedido(int pedido) {
        this.pedido = pedido;
    }

    public int getProduto() {
        return produto;
    }

    public void setProduto(int produto) {
        this.produto = produto;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public float getVlrVenda() {
        return vlrVenda;
    }

    public void setVlrVenda(float vlrVenda) {
        this.vlrVenda = vlrVenda;
    }

    public void listarPedidoItem(int idPedidoItem) {
        try {
            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    " select id_pedido_item, "
                    + "      pedido,produto,quantidade,vlr_venda "
                    + " from pedido_item "
                    + "where id_pedido_item = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idPedidoItem);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setIdPedidoItem(rs.getInt(1));
                setPedido(rs.getInt(2));
                setProduto(rs.getInt(3));
                setQuantidade(rs.getInt(4));
                setVlrVenda(rs.getFloat(5));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void alterarPedido() {
        String sql = "";
        try {

            if (getIdPedidoItem() != 0) {
                sql = "    update pedido_item "
                        + "   set pedido = ?"
                        + "       produto = ?"
                        + "       quantidade = ?"
                        + "       vlr_venda = ?"
                        + " where id_pedido = ?";
            } else {
                sql = "    insert into pedido_item "
                        + "  (pedido, produto, quantidade, vlr_venda)"
                        + " values"
                        + "  (?, ?, ?, ?)";
            }

            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, getPedido());
            ps.setInt(2, getProduto());
            ps.setInt(3, getQuantidade());
            ps.setFloat(4, getVlrVenda());
            if (getIdPedidoItem() != 0) {
                ps.setInt(5, getIdPedidoItem());
            }
            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            System.out.println(sql);
            e.printStackTrace();
        }
    }
    
    public void excluirPedidoItem(int idPedidoItem) throws Exception {
        String sql = "delete from pedido_item where id_pedido_item = ?";

        Connection conn;
        Conexao conecta;
        conecta = new Conexao();
        conn = conecta.metodoConecta();

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, idPedidoItem);
        ps.executeUpdate();

        ps.close();
        conn.close();
    }

}

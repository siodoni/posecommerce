/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ecommerce.modelo;

import ecommerce.bd.Conexao;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 *
 * @author ely
 */
public class PedidoBean {
    private int idPedido;
    private Date data;
    private int usuario;

    public PedidoBean() {
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public int getUsuario() {
        return usuario;
    }

    public void setUsuario(int usuario) {
        this.usuario = usuario;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public void listarPedido(int idPedido) {
        try {
            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    " select id_pedido, "
                    + "      data,usuario "
                    + " from pedido "
                    + "where id_pedido = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idPedido);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setIdPedido(rs.getInt(1));
                setData(rs.getDate(2));
                setUsuario( rs.getInt(3));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void listarPedidoUsuario(int usuario) {
        try {
            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            String sql =
                    " select id_pedido, "
                    + "      data,usuario "
                    + " from pedido "
                    + "where usuario = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, usuario);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setIdPedido(rs.getInt(1));
                setData(rs.getDate(2));
                setUsuario( rs.getInt(3));
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
            if (getIdPedido() != 0) {
                sql = "    update pedido "
                        + "   set data = sysdate"
                        + "       usuario = ?"
                        + " where id_pedido = ?";
            } else {
                sql = "    insert into pedido "
                        + "  (data, usuario)"
                        + "values"
                        + "  (sysdate, ?)";
            }

            Connection conn;
            Conexao conecta;
            conecta = new Conexao();
            conn = conecta.metodoConecta();

            PreparedStatement ps = conn.prepareStatement(sql);
            //ps.setDate(1, getData());
            ps.setInt(1, getUsuario());
            if (getIdPedido() != 0) {
                ps.setInt(2, getIdPedido());
            }
            ps.executeUpdate();

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}

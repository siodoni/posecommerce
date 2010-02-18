package ecommerce.bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import javax.naming.NamingException;

/**
 * Classe responsável por conectar-se ao banco de dados.
 */
public class Conexao {

    private static Connection conn = null;
    private static String url;
    private Properties props = new Properties();

    /**
     * Monta a URL de conexão com o banco de dados
     * @param servico Instancia do banco de dados, informe DESV, TEST ou PROD.
     */
    public Conexao() {
        //Conexao.url = "jdbc:oracle:thin:@10.120.0.213:1521:DESV";
        Conexao.url = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
    }

    /**
     * Método responsável por conectar ao banco de dados.
     * @return Connection retorna a conexão com o banco de dados.
     * @throws ClassNotFoundException
     * @throws SQLException
     * @throws NamingException
     */
    public Connection metodoConecta() throws ClassNotFoundException, SQLException, NamingException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        props.put("user", "hr");
        props.put("password", "123");
        //props.put("user", "loja");
        //props.put("password", "loja");
        //props.put("user", "temp");
        //props.put("password", "temp");
        conn = DriverManager.getConnection(Conexao.url, props);
        return conn;
    }

    /**
     * Retorna a URL de conexão com o banco de dados.
     * @return String da URL de conexão.
     */
    public static String getUrl() {
        return url;
    }
}

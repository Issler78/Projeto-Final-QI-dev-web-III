package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
    private final String driver = "com.mysql.cj.jdbc.Driver";
    private final String servidor = "jdbc:mysql://localhost/sistemaescolar";
    private final String usuario = "root";
    private final String senha = "";
    
    public Connection connect() throws Exception {
        try{
            Class.forName(driver);
            
            return DriverManager.getConnection(servidor, usuario, senha);
        } catch(ClassNotFoundException | SQLException e){
            throw new Exception("Erro ao iniciar a conexao com o banco: " + e);
        }
    }
    
    public void close(Connection conn) throws Exception{
        try{
            if(conn != null){
                conn.close();
            }
        } catch (SQLException e) {
            throw new Exception("Erro ao fechar a conexao com o banco");
        }
    }
}

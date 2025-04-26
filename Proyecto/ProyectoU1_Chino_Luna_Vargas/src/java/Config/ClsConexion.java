/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Config;
import java.sql.*;
/**
 *
 * @author HP
 */
public class ClsConexion {
    
    Connection con=null;
    public ClsConexion() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //Class.forName("com.mysql.cj.jdbc.Driver");
            //String url="jdbc:mysql://localhost:3306/db_mensaje";
            String url="jdbc:mysql://dbfitmatch.mysql.database.azure.com:3306/fit?useSSL=true&requireSSL=true";
            con=DriverManager.getConnection(url, "fitmatch", "Diego322");
            System.out.println("conexion exitosa");
            //con = DriverManager.getConnection("jdbc:mysql://dbrufianes.mysql.database.azure.com:3306/dbguardiania?useSSL=true&requireSSL=true", "rufianes", "Rufianes12");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("error conexion "+e.getMessage()); 
        }
    }
    public Connection getConnection(){
        return con;
    }    
}

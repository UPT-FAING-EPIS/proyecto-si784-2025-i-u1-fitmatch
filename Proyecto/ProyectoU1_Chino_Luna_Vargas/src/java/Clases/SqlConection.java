/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SqlConection {
      private static final String URL = "jdbc:mysql://localhost:3306/fit";
    private static final String USER = "root";
    private static final String PASSWORD = ""; 
    
    private static Connection connection = null;
     
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                if (connection == null) {
                    throw new SQLException("No se pudo establecer la conexión");
                }
            } catch (ClassNotFoundException e) {
                throw new ClassNotFoundException("Error: Driver MySQL no encontrado");
            } catch (SQLException e) {
                throw new SQLException("Error de conexión a la base de datos: " + e.getMessage());
            }
        }
        return connection;
    }
    
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                connection = null;
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }

}

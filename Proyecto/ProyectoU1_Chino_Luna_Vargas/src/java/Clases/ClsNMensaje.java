/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Clases;

import Clases.SqlConection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Sio
 */
public class ClsNMensaje {
    
    SqlConection cn = new SqlConection();
    Connection con;
   
    public boolean registrarMensaje(String idEmisor, String idReceptor, String mensajeCifrado, String claveSimetricaEmisor, String claveSimetricaReceptor, String iv) {
        
        boolean resultado = false;
        
        try {
            con=(Connection) cn.getConnection();
            CallableStatement cst = con.prepareCall("{call SP_InsertarMensaje(?,?,?,?,?,?)}");
                cst.setString(1, idEmisor);
                cst.setString(2, idReceptor);
                cst.setString(3, mensajeCifrado);
                cst.setString(4, claveSimetricaEmisor);
                cst.setString(5, claveSimetricaReceptor);
                cst.setString(6, iv);
               
                int insertado = cst.executeUpdate();

                resultado = insertado > 0;//valida q se haya afectado una fila 
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNMensaje.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ClsNMensaje.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return resultado;
    }
    
    public ResultSet listarMensajes(String idEmisor,String idReceptor) {
        
        ResultSet rs = null;
        
        try {
            con=(Connection) cn.getConnection();
            CallableStatement cst = con.prepareCall("{call SP_MensajeChat(?,?)}");
            System.out.println("emisor "+idEmisor);
                        System.out.println("recepptor "+idReceptor);
                cst.setString(1,idEmisor);
                cst.setString(2,idReceptor);
                rs = cst.executeQuery();
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNMensaje.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ClsNMensaje.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
        
    }
    
    public ResultSet mensajesConversacion(String idEmisor,String idReceptor) {
        
        ResultSet rs = null;
        
        try {
            con=(Connection) cn.getConnection();
            CallableStatement cst = con.prepareCall("{call SP_Mensajes_S(?,?)}");
            System.out.println("emisor "+idEmisor);
                        System.out.println("recepptor "+idReceptor);
                cst.setString(1,idEmisor);
                cst.setString(2,idReceptor);
                rs = cst.executeQuery();
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNMensaje.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ClsNMensaje.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
        
    }
    
    public ResultSet listarClavePrivada(String idUsuario) {
        
        ResultSet rs = null;
        
        try {
            con=(Connection) cn.getConnection();
            CallableStatement cst = con.prepareCall("{call listarUsuarioPorId(?)}");
                cst.setString(1,idUsuario);
                rs = cst.executeQuery();
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNMensaje.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ClsNMensaje.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
        
    }
    
}

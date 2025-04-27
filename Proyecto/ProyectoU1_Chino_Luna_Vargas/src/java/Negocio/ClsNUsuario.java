/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Negocio;


import Entidad.ClsEUsuario;
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
public class ClsNUsuario {
    
   
    Connection con;
    PreparedStatement ps;
    Statement st;
    
    public ResultSet IniciarSesion(String usuario,String password) {
               
        ResultSet rs = null;
        
        try {
            con = Clases.SqlConection.getConnection();
            CallableStatement cst = con.prepareCall("{call SP_Autenticar(?,?)}");
                cst.setString(1,usuario);
                cst.setString(2,password);
                rs = cst.executeQuery();
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNUsuario.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ClsNUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
    }
    
    public ResultSet buscarUsuario(int idusuario) {
               
        ResultSet rs = null;
        
        try {
            con = Clases.SqlConection.getConnection();
            CallableStatement cst = con.prepareCall("{call SP_BuscarUsuario(?)}");
                cst.setInt(1,idusuario);
                rs = cst.executeQuery();
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNUsuario.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ClsNUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
    }
    
    public boolean agregarUsuario(ClsEUsuario ObjUsuario) {
        
        boolean resultado = false;
        
        try {
            con = Clases.SqlConection.getConnection();
            CallableStatement cst = con.prepareCall("{call SP_InsertarUsuarioNormal(?,?,?,?,?,?,?,?)}");
                cst.setString(1,ObjUsuario.getUsuario());
                cst.setString(2,ObjUsuario.getPassword());
                cst.setString(3,ObjUsuario.getCorreo());
                cst.setString(4,ObjUsuario.getNombre());
                cst.setString(5,ObjUsuario.getApellido());
                cst.setString(6,ObjUsuario.getClavePrivadaEncriptado());
                cst.setString(7, ObjUsuario.getClavePublica());
                cst.setString(8, ObjUsuario.getCiudad());

               
                int insertado = cst.executeUpdate();

                resultado = insertado > 0;//valida q se haya afectado una fila 
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNUsuario.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ClsNUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return resultado;
    }
    
}


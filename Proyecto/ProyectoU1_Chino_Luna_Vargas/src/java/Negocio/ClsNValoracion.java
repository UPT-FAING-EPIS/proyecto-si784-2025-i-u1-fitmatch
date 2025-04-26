/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Negocio;

import Config.ClsConexion;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Sio
 */
public class ClsNValoracion {
    ClsConexion cn = new ClsConexion();
    Connection con;
    
    
    public ResultSet buscarUsuario(int idvalorador,int idvalorado) {
               
        ResultSet rs = null;
        
        try {
            con=(Connection) cn.getConnection();
            CallableStatement cst = con.prepareCall("{call SP_valoracionBuscar(?,?)}");
                cst.setInt(1,idvalorador);
                cst.setInt(2,idvalorado);
                rs = cst.executeQuery();
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
    }
    
    public ResultSet listarValoraciones(int idvalorado) {
               
        ResultSet rs = null;
        
        try {
            con=(Connection) cn.getConnection();
            CallableStatement cst = con.prepareCall("{call SP_ListaValoracionesDeUsuario(?)}");
                cst.setInt(1,idvalorado);
                rs = cst.executeQuery();
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
    }
    
    public ResultSet verCalculoValoracion(int idvalorado) {
               
        ResultSet rs = null;
        
        try {
            con=(Connection) cn.getConnection();
            CallableStatement cst = con.prepareCall("{call SP_valoracionCalculoUsuario(?)}");
                cst.setInt(1,idvalorado);
                rs = cst.executeQuery();
                
        } 
        catch (SQLException ex) {
            Logger.getLogger(ClsNUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
    }
}

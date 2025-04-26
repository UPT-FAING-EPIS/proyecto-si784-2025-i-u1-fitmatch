/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Negocio.ClsNUsuario;
import Utilidad.CryptoUtils;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import java.sql.*;
/**
 *
 * @author Sio
 */
@WebServlet(name = "LoginPublico", urlPatterns = {"/LoginPublico"})
public class LoginPublico extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();

            ClsNUsuario ObjNusuario = new ClsNUsuario();
            int idUsuarioEmisor = (Integer) session.getAttribute("idUsuario");//el q inicio sesion
            int idUsuarioReceptor = Integer.parseInt(request.getParameter("idUsuarioReceptor"));// el id al q le quiere enviar mensaje
                        
            ResultSet rs = ObjNusuario.buscarUsuario(idUsuarioReceptor);
            
            if(rs!=null && rs.next()){
                
                String clavePublicaReceptor = rs.getString("clavePublica");
                
                session.setAttribute("clavePublicaReceptor", clavePublicaReceptor);
                
                //chatId sera un chat session q se cargara siempre con la id de los participantes del grupo, en orden de mayor a menor.
                String chat = "chatId=";
                
                if(idUsuarioEmisor < idUsuarioReceptor){
                    
                    chat += idUsuarioReceptor+""+idUsuarioEmisor;
                    
                }else{
                    
                    chat += idUsuarioEmisor+""+idUsuarioReceptor;
                    
                }
                System.out.println("chatt: "+chat);
                
                session.setAttribute("UsuarioChat",rs.getString("usuario"));
                session.setAttribute("ExperienciaChat", rs.getString("experiencia"));
                session.setAttribute("FotoChat", rs.getBlob("imagen_perfil"));
                
                response.sendRedirect("chatDinamico.jsp?"+chat+"&userId="+idUsuarioEmisor+"&userIdReceptor="+idUsuarioReceptor);
            }
            else{
                response.sendRedirect("chat.jsp");
            }
                        
        } catch (Exception ex) {
            Logger.getLogger(LoginPublico.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            HttpSession session = request.getSession();

            ClsNUsuario ObjNusuario = new ClsNUsuario();
                
            ResultSet rs =ObjNusuario.IniciarSesion(request.getParameter("usuario"), request.getParameter("password"));
                
            if(rs!=null && rs.next()){//valida q se encuentre en la bd ese usuario con las credencialse
                
                String PIN = request.getParameter("pin");
                String clavePrivadaEncrypt=rs.getString("clavePrivadaEncriptado");
                
                session.setAttribute("idUsuario", rs.getInt("id"));
                session.setAttribute("PIN",PIN );//desde vista
                //session.setAttribute("clavePublica", clavePublicaEmisor);
                session.setAttribute("clavePublica", rs.getString("clavePublica"));
                session.setAttribute("clavePrivadaEncriptado",clavePrivadaEncrypt);
                
                try{//se intenta desencriptar
                    
                    String decryptedPrivateKey = CryptoUtils.decryptPrivateKey(clavePrivadaEncrypt,PIN);
                    System.out.println("Clave privada desencriptada: " + decryptedPrivateKey);
                    session.setAttribute("clavePrivadaDesencriptada",decryptedPrivateKey);
                    response.sendRedirect("ElegirChat.jsp");
                }
                catch(Exception e){
                    System.out.println("El pin no coincide");
                    response.sendRedirect("LoginPruebita.jsp");
                }
            }   
            else{
                System.out.println("No tiene cuenta o no coincide con ninguna");
                response.sendRedirect("LoginPruebita.jsp");
            }
        } 
        catch (Exception ex) {
            Logger.getLogger(LoginPublico.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Clases.SqlConection;
import Negocio.ClsNUsuario;
import Utilidad.CryptoUtils;
import java.io.PrintWriter;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        ClsNUsuario ObjNusuario = new ClsNUsuario();
                
        ResultSet rs =ObjNusuario.IniciarSesion(request.getParameter("usuario"), request.getParameter("password"));
                
        
        try {
            
            if (rs!=null && rs.next()) {
                
                if(rs.getInt("Estado") == 1){
                    
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("usuario", rs.getString("usuario"));
                    session.setAttribute("experiencia", rs.getString("experiencia"));
                    session.setAttribute("level", rs.getString("fitness_level"));

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
                        response.sendRedirect("dashboard.jsp");
                    }
                    catch(Exception e){
                        request.setAttribute("error", "El PIN es incorrecto!");
                        request.getRequestDispatcher("Login.jsp").forward(request, response);
                    }
                }
                else{
                    request.setAttribute("error", "Su usuario se encuentra deshabilitado comuniquese con soporte para obtener información al respecto!");
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
            } 
            else {
                request.setAttribute("error", "Usuario o contraseña incorrectos");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error de conexión: " + e.getMessage());
            request.getRequestDispatcher("Login.jsp").forward(request, response);
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

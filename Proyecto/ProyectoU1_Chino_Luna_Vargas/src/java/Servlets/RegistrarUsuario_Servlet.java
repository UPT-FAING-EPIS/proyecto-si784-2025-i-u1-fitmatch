/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entidad.ClsEUsuario;
import Negocio.ClsNUsuario;
import Utilidad.Utilidad_ClavesRSA;
import Utilidad.Utilidad_IP;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Sio
 */
@WebServlet(name = "RegistrarUsuario_Servlet", urlPatterns = {"/RegistrarUsuario_Servlet"})
public class RegistrarUsuario_Servlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String usuario = request.getParameter("usuario");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
            
        Utilidad_IP Uip = new Utilidad_IP();
            String ipReal = Uip.MtdObtenerIPPublica(request);
            String[] ciudad = Uip.ObtenerCiudadIP(ipReal);//Almaceno la ip publica del cliente en IP
        
        String pin = request.getParameter("pin");
            System.out.println("Pin ingresado: "   + pin);
            
        Utilidad_ClavesRSA UClavesRSA = new Utilidad_ClavesRSA();
            String[] claves = UClavesRSA.generarClavesRSA(pin);    

        ClsEUsuario ObjEUsuario = new ClsEUsuario();
            ObjEUsuario.setApellido(apellido);
            ObjEUsuario.setCiudad(ciudad[1]);
            ObjEUsuario.setNombre(nombre);
            ObjEUsuario.setUsuario(usuario);
            ObjEUsuario.setPassword(password);
            ObjEUsuario.setCorreo(email);
            ObjEUsuario.setClavePrivadaEncriptado(claves[0]);
            ObjEUsuario.setClavePublica(claves[1]);

        ClsNUsuario ObjNUsuario = new ClsNUsuario();    
            if(ObjNUsuario.agregarUsuario(ObjEUsuario)){
                session.setAttribute("estilo","Correcto");
                session.setAttribute("noti","Usuario ha sido creado correctamente!");
            }
            else{
                session.setAttribute("estilo","Error");
                session.setAttribute("noti","Ocurrio un error al crear tú usuario.");
            }
            
        response.sendRedirect("registro.jsp");
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

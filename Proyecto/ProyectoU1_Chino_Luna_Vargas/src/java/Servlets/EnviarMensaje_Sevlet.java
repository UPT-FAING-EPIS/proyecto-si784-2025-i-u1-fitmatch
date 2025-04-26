/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Clases.ClsNMensaje;
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
@WebServlet(name = "EnviarMensaje_Sevlet", urlPatterns = {"/EnviarMensaje_Sevlet"})
public class EnviarMensaje_Sevlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        String idEmisor = request.getParameter("idEmisor");
        String idReceptor = request.getParameter("idReceptor");
        String mensajeCifrado = request.getParameter("mensajeCifrado");
        String claveSimetricaCifradaEmisor = request.getParameter("claveSimetricaEmisor");
        String claveSimetricaCifradaReceptor = request.getParameter("claveSimetricaReceptor");
        String iv = request.getParameter("iv"); 

        System.out.println("idEmisor: " + idEmisor);
        //System.out.println("idReceptor ID: " + idReceptor);
        System.out.println("mensaje: " + mensajeCifrado);

        ClsNMensaje ObjNMensaje = new ClsNMensaje();
        response.setContentType("text/plain"); // Establecer el tipo de contenido de la respuesta
        PrintWriter out = response.getWriter();

        if (ObjNMensaje.registrarMensaje(idEmisor, idReceptor, mensajeCifrado, claveSimetricaCifradaEmisor, claveSimetricaCifradaReceptor, iv)) {
            out.print("Enviado");
        } else {
            out.print("Ocurrió un error");
        }
        out.flush(); 
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

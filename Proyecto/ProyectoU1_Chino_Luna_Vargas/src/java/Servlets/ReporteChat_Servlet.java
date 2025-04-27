/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Clases.SqlConection;
import Config.ClsConexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
/**
 *
 * @author Sio
 */
@MultipartConfig
@WebServlet(name = "ReporteChat_Servlet", urlPatterns = {"/reporteChat_Servlet"})
public class ReporteChat_Servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReporteChat_Servlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReporteChat_Servlet at " + request.getContextPath() + "</h1>");
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
        
        String motivo = request.getParameter("motivo");
        Part evidencia1 = request.getPart("evidencia");
        Part evidencia2 = request.getPart("evidencia[1]");
        int idReportador = Integer.parseInt(request.getParameter("idUsuario"));
        int idReportado = Integer.parseInt(request.getParameter("idReportado"));

        if (motivo == null || motivo.isEmpty() || evidencia1 == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Motivo y primera evidencia son obligatorios");
            return;
        }
        try (Connection conn = SqlConection.getConnection();
             CallableStatement stmt = conn.prepareCall("CALL SP_InsertarReporteChat(?, ?, ?, ?, ?)");) {

            stmt.setInt(1, idReportador);
            stmt.setInt(2, idReportado);
            stmt.setString(3, motivo);
            stmt.setBlob(4, evidencia1.getInputStream());
            stmt.setBlob(5, evidencia2 != null ? evidencia2.getInputStream() : null);

            stmt.executeUpdate();
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Reporte almacenado correctamente");
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al registrar el reporte: " + e.getMessage());
            Logger.getLogger(ReporteChat_Servlet.class.getName()).log(Level.SEVERE, null, e);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReporteChat_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

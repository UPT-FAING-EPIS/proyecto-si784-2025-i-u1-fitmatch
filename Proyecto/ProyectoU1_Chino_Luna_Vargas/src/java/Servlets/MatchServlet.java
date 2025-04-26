/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Clases.SqlConection;
import java.io.PrintWriter;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "MatchServlet", urlPatterns = {"/match"})
public class MatchServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MatchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MatchServlet at " + request.getContextPath() + "</h1>");
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
        
        Connection conn = null;
        PreparedStatement stmt = null;
        System.out.println("User ID: "+request.getSession().getAttribute("userId"));
        System.out.println("Mattched ID: "+request.getParameter("matchedUserId"));

        try {
            Integer userId = (Integer) request.getSession().getAttribute("userId");
            Integer matchedUserId = Integer.valueOf(request.getParameter("matchedUserId"));
            boolean liked = Boolean.parseBoolean(request.getParameter("liked"));
            Integer compatibilityScore = Integer.valueOf(request.getParameter("compatibilityScore"));

            conn = SqlConection.getConnection();
            String sql = "CALL InsertMatch(?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, matchedUserId);
            stmt.setBoolean(3, liked);
            stmt.setInt(4, compatibilityScore);

            stmt.executeUpdate();
            
            // Redirigir con un parámetro de timestamp para forzar la recarga
            response.sendRedirect("dashboard.jsp?t=" + System.currentTimeMillis());
            
        } catch (Exception e) {
            // Log the error for debugging
            e.printStackTrace();
            
            // Redirigir con mensaje de error
            response.sendRedirect("dashboard.jsp?error=" + java.net.URLEncoder.encode("Error al procesar el match: " + e.getMessage(), "UTF-8"));
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) SqlConection.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
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

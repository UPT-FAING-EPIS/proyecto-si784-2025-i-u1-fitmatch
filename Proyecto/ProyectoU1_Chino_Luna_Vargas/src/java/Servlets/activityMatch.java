/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Clases.SqlConection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "activityMatch", urlPatterns = {"/activityMatch"})
public class activityMatch extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
              Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Get parameters from session and request
            int userId = (Integer) request.getSession().getAttribute("userId");
            int matchedUserId = Integer.parseInt(request.getParameter("matchedUserId"));
            int activityId = Integer.parseInt(request.getParameter("activityId"));
            boolean liked = Boolean.parseBoolean(request.getParameter("liked"));

            conn = SqlConection.getConnection();

            // Register the match in matches_actividades table
            String sql = "INSERT INTO matches_actividades (user_id, matched_user_id, actividad_id, estado) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, matchedUserId);
            stmt.setInt(3, activityId);
            stmt.setString(4, liked ? "pendiente" : "rechazado");
            stmt.executeUpdate();

            // If it was a like, check for mutual match
            if (liked) {
                sql = "SELECT * FROM matches_actividades WHERE user_id = ? AND matched_user_id = ? AND actividad_id = ? AND estado = 'pendiente'";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, matchedUserId);
                stmt.setInt(2, userId);
                stmt.setInt(3, activityId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    // There's a mutual match, update both records
                    sql = "UPDATE matches_actividades SET estado = 'match' WHERE " +
                          "((user_id = ? AND matched_user_id = ?) OR (user_id = ? AND matched_user_id = ?)) " +
                          "AND actividad_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, userId);
                    stmt.setInt(2, matchedUserId);
                    stmt.setInt(3, matchedUserId);
                    stmt.setInt(4, userId);
                    stmt.setInt(5, activityId);
                    stmt.executeUpdate();

                    // Redirect to chat or show match notification
                    response.sendRedirect("matchSuccess.jsp?activityId=" + activityId);
                    return;
                }
            }

            // Redirect back to activity page
            response.sendRedirect("activity.jsp?id=" + activityId);

        } catch (Exception e) {
            // Log the error and redirect to error page
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) SqlConection.closeConnection();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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

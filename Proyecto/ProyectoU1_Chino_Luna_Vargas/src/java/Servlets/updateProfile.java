/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.io.PrintWriter;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import Clases.SqlConection;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "updateProfile", urlPatterns = {"/updateProfile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024, // 1 MB
        maxRequestSize = 1024 * 1024 // 1 MB
)

public class updateProfile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet updateProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateProfile at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        String experienceLevel = request.getParameter("experienceLevel");
        String gym = request.getParameter("gym");
        String trainingType = request.getParameter("trainingType");
        String trainingSchedule = request.getParameter("trainingSchedule");
        Part filePart = request.getPart("profileImage");

        try (Connection conn = SqlConection.getConnection()) {
            String sql;
            PreparedStatement stmt;

            if (filePart != null && filePart.getSize() > 0) {
                sql = "UPDATE DatosUsuarios SET fitness_level = ?, experiencia = ?, "
                        + "tipo_entrenamiento = ?, horario_entrenamiento = ?, imagen_perfil = ? "
                        + "WHERE usuario_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, experienceLevel);
                stmt.setString(2, gym);
                stmt.setString(3, trainingType);
                stmt.setString(4, trainingSchedule);

                InputStream fileContent = filePart.getInputStream();
                stmt.setBlob(5, fileContent);
                stmt.setInt(6, userId);
            } else {
                sql = "UPDATE DatosUsuarios SET fitness_level = ?, experiencia = ?, "
                        + "tipo_entrenamiento = ?, horario_entrenamiento = ? "
                        + "WHERE usuario_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, experienceLevel);
                stmt.setString(2, gym);
                stmt.setString(3, trainingType);
                stmt.setString(4, trainingSchedule);
                stmt.setInt(5, userId);
            }

            stmt.executeUpdate();
            response.sendRedirect("profile.jsp");

        } catch (Exception e) {
            request.setAttribute("error", "Error al actualizar el perfil: " + e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

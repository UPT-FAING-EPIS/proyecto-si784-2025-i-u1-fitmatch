/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;


import java.io.PrintWriter;
import Clases.SqlConection;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "CreatePost", urlPatterns = {"/CreatePost"})
@MultipartConfig
public class CreatePost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreatePost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreatePost at " + request.getContextPath() + "</h1>");
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
        try {
            Integer userId = (Integer) request.getSession().getAttribute("userId");
            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String content = request.getParameter("content");
            Part filePart = request.getPart("image");
            
            try (Connection conn = SqlConection.getConnection()) {
                String sql = "INSERT INTO Publicaciones (usuario_id, contenido, imagen) VALUES (?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                stmt.setString(2, content);
                
                if (filePart != null && filePart.getSize() > 0) {
                    InputStream fileContent = filePart.getInputStream();
                    stmt.setBlob(3, fileContent);
                } else {
                    stmt.setNull(3, java.sql.Types.BLOB);
                }
                
                stmt.executeUpdate();
            }
            
            response.sendRedirect("feed.jsp");
            
        } catch (Exception e) {
            throw new ServletException("Error creating post", e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

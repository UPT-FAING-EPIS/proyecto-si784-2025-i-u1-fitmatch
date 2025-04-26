/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;


import java.io.PrintWriter;
import Clases.SqlConection;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
/**
 *
 * @author ASUS
 */
@WebServlet(name = "saveWorkout", urlPatterns = {"/saveWorkout"})
public class saveWorkout extends HttpServlet {

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
        
        System.out.println("saveWorkout servlet called"); // Debug log
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Debug print session info
        System.out.println("Session ID: " + session.getId());
        System.out.println("User ID from session: " + userId);
        
        // Redirect to login if not authenticated
        if (userId == null) {
            System.out.println("User not authenticated, redirecting to login"); // Debug log
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // Get form parameters
        String exerciseId = request.getParameter("ejercicio_id");
        String weightStr = request.getParameter("peso");
        String setsStr = request.getParameter("series");
        String repsStr = request.getParameter("repeticiones");
        String notas = request.getParameter("notas");
        
        // Debug prints
        System.out.println("Form parameters received:");
        System.out.println("Usuario ID: " + userId);
        System.out.println("Ejercicio ID: " + exerciseId);
        System.out.println("Peso: " + weightStr);
        System.out.println("Series: " + setsStr);
        System.out.println("Repeticiones: " + repsStr);
        System.out.println("Notas: " + notas);
        
        try {
            // Validate input
            if (exerciseId == null || weightStr == null || setsStr == null || repsStr == null) {
                throw new IllegalArgumentException("Todos los campos son requeridos");
            }
            
            double peso = Double.parseDouble(weightStr);
            int series = Integer.parseInt(setsStr);
            int repeticiones = Integer.parseInt(repsStr);
            int ejercicio_id = Integer.parseInt(exerciseId);
            
            // Validate ranges
            if (peso <= 0 || series <= 0 || repeticiones <= 0) {
                throw new IllegalArgumentException("Los valores deben ser mayores que 0");
            }
            
            // Get database connection
            try (Connection conn = SqlConection.getConnection()) {
                System.out.println("Database connection established"); // Debug log
                
                // Call stored procedure
                String spCall = "{CALL SP_Save_Workout(?, ?, ?, ?, ?, ?)}";
                try (CallableStatement stmt = conn.prepareCall(spCall)) {
                    stmt.setInt(1, userId);
                    stmt.setInt(2, ejercicio_id);
                    stmt.setInt(3, series);
                    stmt.setInt(4, repeticiones);
                    stmt.setDouble(5, peso);
                    stmt.setString(6, notas);
                    
                    System.out.println("Executing stored procedure"); // Debug log
                    stmt.execute();
                    System.out.println("Stored procedure executed successfully"); // Debug log
                    
                    // Set success message
                    session.setAttribute("message", "Entrenamiento guardado exitosamente");
                    session.setAttribute("messageType", "success");
                }
            }
            
        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException: " + e.getMessage()); // Debug log
            session.setAttribute("message", "Por favor ingrese valores numéricos válidos");
            session.setAttribute("messageType", "error");
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            System.out.println("IllegalArgumentException: " + e.getMessage()); // Debug log
            session.setAttribute("message", e.getMessage());
            session.setAttribute("messageType", "error");
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("General Exception: " + e.getMessage()); // Debug log
            session.setAttribute("message", "Error al guardar el entrenamiento: " + e.getMessage());
            session.setAttribute("messageType", "error");
            e.printStackTrace();
        }
        
        // Redirect back to workout tracking page
        System.out.println("Redirecting to workout-tracking.jsp"); // Debug log
        response.sendRedirect("workout-tracking.jsp");
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

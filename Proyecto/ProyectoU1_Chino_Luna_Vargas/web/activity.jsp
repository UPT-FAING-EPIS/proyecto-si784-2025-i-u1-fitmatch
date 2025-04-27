<%-- 
    Document   : activity
    Created on : 12 feb 2025, 10:01:39 p.m.
    Author     : ASUS
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.Base64"%>
<%@page import="Clases.SqlConection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
     <!-- NUEVO JSP -->
    <title>FitMatch - Actividad</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        .profile-card {
            aspect-ratio: 1;
            width: 100%;
            max-width: 400px;
        }
    </style>
</head>
<body class="min-h-screen bg-gray-100">
    <%
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String activityId = request.getParameter("id");
        if (activityId == null) {
            response.sendRedirect("dashboard.jsp");
            return;
        }
    %>

    <!-- Header -->
    <header class="bg-white border-b">
        <div class="max-w-6xl mx-auto px-4 py-3">
            <div class="flex items-center justify-between">
                <div class="flex items-center gap-2">
                    <a href="dashboard.jsp" class="text-gray-600 hover:text-blue-600">
                        <i data-lucide="arrow-left" class="h-6 w-6"></i>
                    </a>
                    <i data-lucide="dumbbell" class="h-8 w-8 text-blue-600"></i>
                    <span class="text-xl font-bold text-blue-600">FITMATCH</span>
                </div>
                
                <div class="flex items-center gap-6">
                    <a href="feed.jsp" class="flex items-center gap-2 text-gray-600 hover:text-blue-600">
                        <i data-lucide="layout-grid" class="h-5 w-5"></i>
                        <span>Feed</span>
                    </a>
                    <a href="messages.jsp" class="flex items-center gap-2 text-gray-600 hover:text-blue-600">
                        <i data-lucide="message-circle" class="h-5 w-5"></i>
                        <span>Mensajes</span>
                    </a>
                    <a href="profile.jsp" class="text-gray-600 hover:text-blue-600">
                        <i data-lucide="settings" class="h-5 w-5"></i>
                    </a>
                    <a href="LogoutServlet" class="text-gray-600 hover:text-blue-600">Salir</a>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="max-w-6xl mx-auto px-4 py-8">
        <div class="flex gap-8">
            <!-- Profile Card Section -->
            <div class="flex-grow flex flex-col items-center">
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    
                    try {
                        conn = SqlConection.getConnection();
                        
                        // Obtener información de la actividad
                        String sqlActivity = "SELECT * FROM actividades WHERE id = ?";
                        stmt = conn.prepareStatement(sqlActivity);
                        stmt.setString(1, activityId);
                        rs = stmt.executeQuery();
                        
                        if (rs.next()) {
                %>
                            <div class="w-full max-w-xl mb-8">
                                <h1 class="text-3xl font-bold text-gray-800 flex items-center gap-3">
                                    <span class="text-4xl"><%= rs.getString("emoji") %></span>
                                    <span class="capitalize"><%= rs.getString("nombre").replace("_", " ") %></span>
                                </h1>
                                <p class="text-gray-600 mt-2"><%= rs.getString("descripcion") %></p>
                            </div>
                <%
                        }

                        // Obtener perfiles para esta actividad
                        String sql = "SELECT u.id, u.usuario, d.experiencia, d.fitness_level, d.distancia, " +
                                   "d.imagen_perfil, d.horario_entrenamiento, d.tipo_entrenamiento " +
                                   "FROM Usuarios u " +
                                   "LEFT JOIN DatosUsuarios d ON u.id = d.usuario_id " +
                                   "LEFT JOIN ActividadesUsuarios a ON u.id = a.usuario_id " +
                                   "WHERE u.id != ? " +
                                   "AND u.id NOT IN (SELECT matched_user_id FROM matches_actividades WHERE user_id = ? AND actividad_id = ?) " +
                                   "AND a.usuario_id IS NOT NULL";
                        
                        stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, (Integer)session.getAttribute("userId"));
                        stmt.setInt(2, (Integer)session.getAttribute("userId"));
                        stmt.setString(3, activityId);
                        rs = stmt.executeQuery();
                        
                        if (rs.next()) {
                            String imageBase64 = "";
                            Blob imageBlob = rs.getBlob("imagen_perfil");
                            if (imageBlob != null) {
                                byte[] imageBytes = imageBlob.getBytes(1, (int)imageBlob.length());
                                imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                            }
                %>
                            <!-- Profile Card -->
                            <div class="profile-card bg-white rounded-3xl shadow-lg overflow-hidden relative">
                                <!-- Profile Image -->
                                <% if (!imageBase64.isEmpty()) { %>
                                    <img src="data:image/jpeg;base64,<%= imageBase64 %>"
                                         alt="Profile"
                                         class="w-full h-full object-cover">
                                <% } else { %>
                                    <div class="w-full h-full bg-gray-200 flex items-center justify-center">
                                        <i data-lucide="user" class="h-32 w-32 text-gray-400"></i>
                                    </div>
                                <% } %>
                                
                                <!-- Profile Info Overlay -->
                                <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-6">
                                    <h2 class="text-2xl font-bold text-white"><%= rs.getString("usuario") %></h2>
                                    <div class="flex gap-3 mt-2">
                                        <span class="px-3 py-1 bg-white/20 rounded-full text-sm text-white">
                                            <i data-lucide="clock" class="h-4 w-4 inline mr-1"></i>
                                            <%= rs.getString("experiencia") %>
                                        </span>
                                        <span class="px-3 py-1 bg-white/20 rounded-full text-sm text-white">
                                            <i data-lucide="map-pin" class="h-4 w-4 inline mr-1"></i>
                                            <%= rs.getString("distancia") %>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="flex justify-center gap-8 mt-6">
                                <form action="activityMatch" method="post">
                                    <input type="hidden" name="matchedUserId" value="<%= rs.getInt("id") %>">
                                    <input type="hidden" name="activityId" value="<%= activityId %>">
                                    <input type="hidden" name="liked" value="false">
                                    <button type="submit" 
                                            class="w-16 h-16 flex items-center justify-center rounded-full bg-white shadow-lg hover:bg-red-50 border-2 border-red-500">
                                        <i data-lucide="x" class="h-8 w-8 text-red-500"></i>
                                    </button>
                                </form>
                                
                                <form action="activityMatch" method="post">
                                    <input type="hidden" name="matchedUserId" value="<%= rs.getInt("id") %>">
                                    <input type="hidden" name="activityId" value="<%= activityId %>">
                                    <input type="hidden" name="liked" value="true">
                                    <button type="submit"
                                            class="w-16 h-16 flex items-center justify-center rounded-full bg-white shadow-lg hover:bg-blue-50 border-2 border-blue-500">
                                        <i data-lucide="heart" class="h-8 w-8 text-blue-500"></i>
                                    </button>
                                </form>
                            </div>
                <%
                        } else {
                %>
                            <div class="text-center mt-8">
                                <h2 class="text-2xl font-bold text-gray-800">No hay más perfiles disponibles</h2>
                                <p class="text-gray-600 mt-2">¡Vuelve más tarde para encontrar compañeros para esta actividad!</p>
                                <a href="dashboard.jsp" class="inline-block mt-4 px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
                                    Volver al inicio
                                </a>
                            </div>
                <%
                        }
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) SqlConection.closeConnection();
                    }
                %>
            </div>

            <!-- Activity Info Sidebar -->
            <div class="w-80">
                <div class="bg-white rounded-2xl shadow-lg p-6">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4">Información de la Actividad</h3>
                    
                    <!-- Stats -->
                    <div class="space-y-4">
                        <div class="p-4 bg-gray-50 rounded-xl">
                            <h4 class="text-sm font-medium text-gray-600">Participantes Activos</h4>
                            <p class="text-2xl font-bold text-gray-800 mt-1">24</p>
                        </div>
                        
                        <div class="p-4 bg-gray-50 rounded-xl">
                            <h4 class="text-sm font-medium text-gray-600">Matches Realizados</h4>
                            <p class="text-2xl font-bold text-gray-800 mt-1">12</p>
                        </div>
                        
                        <div class="p-4 bg-gray-50 rounded-xl">
                            <h4 class="text-sm font-medium text-gray-600">Actividades Programadas</h4>
                            <p class="text-2xl font-bold text-gray-800 mt-1">8</p>
                        </div>
                    </div>
                    
                    <!-- Tips -->
                    <div class="mt-6">
                        <h4 class="text-sm font-medium text-gray-600 mb-2">Tips para Matches</h4>
                        <ul class="space-y-2 text-sm text-gray-600">
                            <li class="flex items-start gap-2">
                                <i data-lucide="check-circle" class="h-5 w-5 text-green-500 flex-shrink-0"></i>
                                <span>Completa tu perfil con tus horarios preferidos</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <i data-lucide="check-circle" class="h-5 w-5 text-green-500 flex-shrink-0"></i>
                                <span>Indica tu nivel de experiencia en la actividad</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <i data-lucide="check-circle" class="h-5 w-5 text-green-500 flex-shrink-0"></i>
                                <span>Mantén actualizada tu disponibilidad</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>

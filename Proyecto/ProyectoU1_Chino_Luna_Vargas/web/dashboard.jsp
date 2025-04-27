<%-- 
    Document   : dashboard
    Created on : 10 feb 2025, 2:17:06 p.m.
    Author     : ASUS
--%>

<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="Clases.SqlConection" %>

<!DOCTYPE html>
<html>
<head>
    <!-- MODIFICADO -->
    <title>FitMatch - Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="min-h-screen bg-gradient-to-b from-blue-500 to-purple-600">
    <%
        // Verificar si el usuario está logueado
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Obtener usuarios potenciales para match
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = SqlConection.getConnection();
            /*String sql = "SELECT u.id, u.usuario, d.experiencia, d.fitness_level, d.distancia, " +
             "d.imagen_perfil, d.horario_entrenamiento, d.tipo_entrenamiento, " +
             "a.ir_bicicletear, a.noche_preworkout, a.libre_hoy " +
             "FROM Usuarios u " +
             "LEFT JOIN DatosUsuarios d ON u.id = d.usuario_id " +
             "LEFT JOIN ActividadesUsuarios a ON u.id = a.usuario_id " +
             "WHERE u.id != ? " +
             "AND u.id NOT IN (SELECT matched_user_id FROM Matches WHERE user_id = ?)";
            */
            
            String sql = "SELECT u.id, u.usuario, d.experiencia, d.fitness_level, d.distancia, d.imagen_perfil, d.horario_entrenamiento, d.tipo_entrenamiento, "
           + "a.ir_bicicletear, a.noche_preworkout, a.libre_hoy "
           + "FROM Usuarios u "
           + "LEFT JOIN DatosUsuarios d ON u.id = d.usuario_id "
           + "LEFT JOIN ActividadesUsuarios a ON u.id = a.usuario_id "
           + "WHERE u.id != ? "
           + "AND u.id NOT IN ( "
           + "    SELECT matched_user_id FROM Matches WHERE user_id = ? "
           + "    UNION "
           + "    SELECT user_id FROM Matches WHERE matched_user_id = ? "
           + ") "
           + "AND u.id NOT IN ( "
           + "    SELECT matched_user_id FROM Matches WHERE user_id = ? AND status IN ('accepted', 'rejected') "
           + "    UNION "
           + "    SELECT user_id FROM Matches WHERE matched_user_id = ? AND status IN ('accepted', 'rejected') "
           + ")";

            stmt = conn.prepareStatement(sql);
            int userId = (Integer) session.getAttribute("userId");
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            stmt.setInt(3, userId);
            stmt.setInt(4, userId);
            stmt.setInt(5, userId);

            rs = stmt.executeQuery();
            
            if (rs.next()) {
                // Obtener y convertir la imagen de perfil
                String imageBase64 = "";
                Blob imageBlob = rs.getBlob("imagen_perfil");
                if (imageBlob != null) {
                    byte[] imageBytes = imageBlob.getBytes(1, (int)imageBlob.length());
                    imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                }
    %>

    <% 
        String error = request.getParameter("error");
        if (error != null && !error.isEmpty()) {
    %>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
            <span class="block sm:inline"><%= error %></span>
        </div>
    <%
        }
    %>

    <!-- Header -->
    <header class="bg-white shadow-sm">
        <div class="max-w-6xl mx-auto px-4 py-4 flex items-center justify-between">
            <div class="flex items-center space-x-2">
                <i data-lucide="dumbbell" class="h-8 w-8 text-blue-600"></i>
                <h1 class="text-2xl font-bold text-blue-600">FITMATCH</h1>
            </div>
            <div class="flex items-center space-x-6">
                <a href="feed.jsp" class="flex items-center space-x-1 text-gray-600 hover:text-blue-600">
                    <i data-lucide="layout-grid" class="h-6 w-6"></i>
                    <span class="text-sm font-medium">Feed</span>
                </a>
                <a href="messages.jsp" class="flex items-center space-x-1 text-gray-600 hover:text-blue-600">
                    <i data-lucide="message-circle" class="h-6 w-6"></i>
                    <span class="text-sm font-medium">Mensajes</span>
                </a>
                <a href="profile.jsp" class="flex items-center space-x-1 text-gray-600 hover:text-blue-600">
                    <i data-lucide="settings" class="h-6 w-6"></i>
                </a>
                <a href="LogoutServlet" class="text-gray-600 hover:text-blue-600">Salir</a>
            </div>
        </div>
    </header>

    <!-- Main Content with Sidebar Layout -->
    <div class="max-w-6xl mx-auto px-4 py-6 flex gap-8">
        <!-- Activities Sidebar -->
        <div class="w-80">
            <div class="bg-white rounded-2xl shadow-lg p-4 sticky top-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Actividades</h2>
                <%
                    PreparedStatement stmtActivities = null;
                    ResultSet rsActivities = null;
                    try {
                        String sqlActivities = "SELECT * FROM actividades WHERE estado = 1";
                        stmtActivities = conn.prepareStatement(sqlActivities);
                        rsActivities = stmtActivities.executeQuery();
                        
                        while(rsActivities.next()) {
                %>
                            <a href="activity.jsp?id=<%= rsActivities.getInt("id") %>" 
                               class="block w-full text-left p-4 rounded-xl hover:bg-gray-50 transition-colors mb-2">
                                <div class="flex items-center gap-3">
                                    <span class="text-2xl"><%= rsActivities.getString("emoji") %></span>
                                    <div>
                                        <h3 class="font-medium capitalize"><%= rsActivities.getString("nombre").replace("_", " ") %></h3>
                                        <p class="text-sm text-gray-500"><%= rsActivities.getString("descripcion") %></p>
                                    </div>
                                </div>
                            </a>
                <%
                        }
                    } finally {
                        if (rsActivities != null) rsActivities.close();
                        if (stmtActivities != null) stmtActivities.close();
                    }
                %>
            </div>
        </div>

        <!-- Main Profile Card Section -->
        <div class="flex-1">
            <!-- Profile Card -->
            <div class="bg-white rounded-3xl shadow-lg overflow-hidden relative">
                <!-- Profile Image Section -->
                <div class="relative w-[780px] h-[450px] mx-auto">
                    <% if (imageBase64.isEmpty()) { %>
                        <img src="https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800&auto=format&fit=crop"
                             alt="Profile"
                             class="w-full h-full object-cover">
                    <% } else { %>
                        <img src="data:image/jpeg;base64,<%= imageBase64 %>"
                             alt="Profile"
                             class="w-full h-full object-cover">
                    <% } %>
                    <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-6">
                        <div class="text-white space-y-2">
                            <h2 class="text-3xl font-bold"><%= rs.getString("usuario") %></h2>
                            <div class="flex items-center space-x-4">
                                <div class="flex items-center">
                                    <i data-lucide="clock" class="h-5 w-5 mr-1"></i>
                                    <span><%= rs.getString("experiencia") %></span>
                                </div>
                                <div class="flex items-center">
                                    <i data-lucide="trophy" class="h-5 w-5 mr-1"></i>
                                    <span><%= rs.getString("fitness_level") %></span>
                                </div>
                                <div class="flex items-center">
                                    <i data-lucide="map-pin" class="h-5 w-5 mr-1"></i>
                                    <span><%= rs.getString("distancia") %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Info Expandible -->
                <div class="relative">
                    <!-- Toggle Button -->
                    <button id="toggleInfo" class="absolute -top-6 right-6 p-2 bg-white rounded-full shadow-lg z-10 transition-transform">
                        <i data-lucide="chevron-up" class="h-6 w-6 text-blue-600 transition-transform" id="toggleIcon"></i>
                    </button>

                    <!-- Expandible Content -->
                    <div id="expandableInfo" class="hidden bg-white p-4 transition-all duration-300 ease-in-out">
                        <!-- Training Type -->
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-700 mb-2">Tipo de Entrenamiento</h3>
                            <span class="px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm">
                                <%= rs.getString("tipo_entrenamiento") != null ? rs.getString("tipo_entrenamiento") : "No especificado" %>
                            </span>
                        </div>

                        <!-- Schedule -->
                        <div class="mb-4">
                            <h3 class="text-sm font-medium text-gray-700 mb-2">Horario Preferido</h3>
                            <div class="flex items-center space-x-2">
                                <i data-lucide="clock" class="h-4 w-4 text-gray-400"></i>
                                <span class="text-sm text-gray-600">
                                    <%= rs.getString("horario_entrenamiento") != null ? rs.getString("horario_entrenamiento") : "No especificado" %>
                                </span>
                            </div>
                        </div>

                        <!-- Compatibility Score -->
                        <%
                           String getCurrentUserDataSql = "SELECT fitness_level, horario_entrenamiento, tipo_entrenamiento FROM DatosUsuarios WHERE usuario_id = ?";
                        PreparedStatement userStmt = conn.prepareStatement(getCurrentUserDataSql);
                        userStmt.setInt(1, (Integer)session.getAttribute("userId"));
                        ResultSet userRs = userStmt.executeQuery();

                        String currentUserLevel = null;
                        String currentUserSchedule = null;
                        String currentUserTrainingType = null;

                        if (userRs.next()) {
                            currentUserLevel = userRs.getString("fitness_level");
                            currentUserSchedule = userRs.getString("horario_entrenamiento");
                            currentUserTrainingType = userRs.getString("tipo_entrenamiento");
                        }

                        Integer compatibilityScore = 0;

                        if (currentUserLevel != null && rs.getString("fitness_level") != null && 
                            currentUserLevel.equals(rs.getString("fitness_level"))) {
                            compatibilityScore += 33;
                        }

                        if (currentUserSchedule != null && rs.getString("horario_entrenamiento") != null && 
                            currentUserSchedule.equals(rs.getString("horario_entrenamiento"))) {
                            compatibilityScore += 33;
                        }

                        if (currentUserTrainingType != null && rs.getString("tipo_entrenamiento") != null && 
                            currentUserTrainingType.equals(rs.getString("tipo_entrenamiento"))) {
                            compatibilityScore += 34;
                        }

                        userRs.close();
                        userStmt.close();
                        %>
                        <div class="p-3 rounded-lg <%= compatibilityScore >= 75 ? "bg-green-50" : compatibilityScore >= 50 ? "bg-yellow-50" : "bg-red-50" %>">
                            <div class="flex items-center justify-between">
                                <span class="text-sm font-medium">Compatibilidad</span>
                                <span class="text-sm font-bold <%= compatibilityScore >= 75 ? "text-green-700" : compatibilityScore >= 50 ? "text-yellow-700" : "text-red-700" %>">
                                    <%= compatibilityScore %>%
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex justify-center space-x-6 mt-6">
                <form action="match" method="post" class="inline">
                    <input type="hidden" name="matchedUserId" value="<%= rs.getInt("id") %>">
                    <input type="hidden" name="liked" value="false">
                    <input type="hidden" name="compatibilityScore" value="0">
                    <button type="submit" 
                            class="p-4 bg-white rounded-full shadow-lg hover:bg-red-50 transition-colors">
                        <i data-lucide="x" class="h-8 w-8 text-red-500"></i>
                    </button>
                </form>
                
                <form action="match" method="post" class="inline">
                    <input type="hidden" name="matchedUserId" value="<%= rs.getInt("id") %>">
                    <input type="hidden" name="liked" value="true">
                    <input type="hidden" name="compatibilityScore" value="<%= compatibilityScore %>">
                    <button type="submit"
                            class="p-4 bg-white rounded-full shadow-lg hover:bg-blue-50 transition-colors">
                        <i data-lucide="heart" class="h-8 w-8 text-blue-500"></i>
                    </button>
                </form>
            </div>
        </div>
    </div>

    <% 
            } else {
    %>
        <div class="flex items-center justify-center min-h-screen">
            <div class="text-center">
                <h2 class="text-2xl font-bold text-gray-700">No hay más perfiles disponibles</h2>
                <p class="text-gray-500 mt-2">¡Vuelve más tarde!</p>
            </div>
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

    <script>
        // Initialize Lucide icons
        lucide.createIcons();
     </script>
    <script>
            document.addEventListener('DOMContentLoaded', function() {
                const toggleButton = document.getElementById('toggleInfo');
                const expandableInfo = document.getElementById('expandableInfo');
                const toggleIcon = document.getElementById('toggleIcon');
                let isExpanded = false;

                toggleButton.addEventListener('click', function() {
                    isExpanded = !isExpanded;

                    // Toggle visibility
                    if (isExpanded) {
                        expandableInfo.classList.remove('hidden');
                        toggleIcon.style.transform = 'rotate(180deg)';
                    } else {
                        expandableInfo.classList.add('hidden');
                        toggleIcon.style.transform = 'rotate(0deg)';
                    }
                });
            });

            // Initialize Lucide icons
            lucide.createIcons();
        </script>
</body>

</html>

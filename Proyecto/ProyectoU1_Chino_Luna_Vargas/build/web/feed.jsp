<%-- 
    Document   : feed
    Created on : 10 feb 2025, 10:40:04 p.m.
    Author     : ASUS
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Clases.SqlConection"%>
<%@page import="Clases.SqlConection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- MODIFICADO -->
<html>
<head>
    <title>FitMatch - Feed</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="min-h-screen bg-gray-50">
    <%
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
    %>

    <div class="flex">
        <!-- Sidebar -->
        <aside class="w-64 h-screen bg-white shadow-md fixed left-0">
            <div class="p-4">
                <div class="flex items-center space-x-2 mb-6">
                    <i data-lucide="dumbbell" class="h-8 w-8 text-blue-600"></i>
                    <h1 class="text-2xl font-bold text-blue-600">FITMATCH</h1>
                </div>
                
                <nav class="space-y-4">
                    <a href="dashboard.jsp" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="home" class="h-6 w-6"></i>
                        <span>Inicio</span>
                    </a>
                    <a href="messages.jsp" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="message-circle" class="h-6 w-6"></i>
                        <span>Mensajes</span>
                    </a>
                    <a href="feed.jsp" class="flex items-center space-x-3 text-blue-600 p-2 rounded-lg bg-blue-50">
                        <i data-lucide="layout-grid" class="h-6 w-6"></i>
                        <span>Feed</span>
                    </a>
                    <a href="create-post.jsp" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="plus-circle" class="h-6 w-6"></i>
                        <span>Crear</span>
                    </a>
                    <a href="profile.jsp" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="settings" class="h-6 w-6"></i>
                        <span>Configuración</span>
                    </a>
                    <a href="workout.jsp" class="flex items-center space-x-3 text-blue-600 p-2 rounded-lg bg-blue-50">
                        <i data-lucide="timer" class="h-6 w-6"></i>
                        <span>Entrenar</span>
                    </a>
                    <a href="logout" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="log-out" class="h-6 w-6"></i>
                        <span>Salir</span>
                    </a>
                </nav>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="ml-64 flex-1 p-6">
            <!-- Create Post Card -->
            <div class="max-w-2xl mx-auto mb-8">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <form action="CreatePost" method="POST" enctype="multipart/form-data" class="space-y-4">
                        <div class="flex items-center space-x-3 mb-4">
                            <%
                                try (Connection conn = SqlConection.getConnection()) {
                                    int userId = (Integer)session.getAttribute("userId");
                                    String userQuery = "SELECT u.usuario, d.imagen_perfil FROM Usuarios u LEFT JOIN DatosUsuarios d ON u.id = d.usuario_id WHERE u.id = ?";
                                    PreparedStatement userStmt = conn.prepareStatement(userQuery);
                                    userStmt.setInt(1, userId);
                                    ResultSet userRs = userStmt.executeQuery();
                                    
                                    if (userRs.next()) {
                                        String imageBase64 = "";
                                        Blob imageBlob = userRs.getBlob("imagen_perfil");
                                        if (imageBlob != null) {
                                            byte[] imageBytes = imageBlob.getBytes(1, (int)imageBlob.length());
                                            imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                                        }
                            %>
                            <div class="w-10 h-10 rounded-full overflow-hidden">
                                <% if (imageBase64.isEmpty()) { %>
                                    <img src="https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800&auto=format&fit=crop"
                                         alt="Profile"
                                         class="w-full h-full object-cover">
                                <% } else { %>
                                    <img src="data:image/jpeg;base64,<%= imageBase64 %>"
                                         alt="Profile"
                                         class="w-full h-full object-cover">
                                <% } %>
                            </div>
                            <a href="user-profile.jsp?userId=<%= userId %>" class="font-medium text-gray-800 hover:text-blue-600">
                                <%= userRs.getString("usuario") %>
                            </a>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("Error: " + e.getMessage());
                                }
                            %>
                        </div>
                        <textarea
                            name="content"
                            placeholder="¿Qué estás pensando?"
                            class="w-full p-4 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            rows="3"
                        ></textarea>
                        <div class="flex items-center justify-between">
                            <div class="flex items-center space-x-2">
                                <label class="cursor-pointer flex items-center space-x-2 text-gray-600 hover:text-blue-600">
                                    <i data-lucide="image" class="h-6 w-6"></i>
                                    <span>Añadir foto</span>
                                    <input type="file" name="image" accept="image/*" class="hidden">
                                </label>
                            </div>
                            <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                                Publicar
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Posts Feed -->
            <%
                try (Connection conn = SqlConection.getConnection()) {
                    String sql = "SELECT p.id, p.usuario_id, u.usuario, d.imagen_perfil, d.experiencia, d.fitness_level, " +
                               "p.contenido, p.fecha_publicacion, p.likes, p.imagen " +
                               "FROM Publicaciones p " +
                               "JOIN Usuarios u ON p.usuario_id = u.id " +
                               "LEFT JOIN DatosUsuarios d ON u.id = d.usuario_id " +
                               "ORDER BY p.fecha_publicacion DESC";
                    
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        String profileImageBase64 = "";
                        Blob profileImageBlob = rs.getBlob("imagen_perfil");
                        if (profileImageBlob != null) {
                            byte[] imageBytes = profileImageBlob.getBytes(1, (int)profileImageBlob.length());
                            profileImageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                        }

                        String postImageBase64 = "";
                        Blob postImageBlob = rs.getBlob("imagen");
                        if (postImageBlob != null) {
                            byte[] imageBytes = postImageBlob.getBytes(1, (int)postImageBlob.length());
                            postImageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                        }
            %>
            <div class="max-w-2xl mx-auto">
                <div class="bg-white rounded-lg shadow-md mb-6 overflow-hidden">
                    <div class="p-4">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 rounded-full overflow-hidden">
                                <% if (profileImageBase64.isEmpty()) { %>
                                    <img src="https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800&auto=format&fit=crop"
                                         alt="Profile"
                                         class="w-full h-full object-cover">
                                <% } else { %>
                                    <img src="data:image/jpeg;base64,<%= profileImageBase64 %>"
                                         alt="Profile"
                                         class="w-full h-full object-cover">
                                <% } %>
                            </div>
                            <div>
                                <h3 class="font-medium text-gray-800">
                                    <a href="user-profile.jsp?userId=<%= rs.getInt("usuario_id") %>" class="hover:text-blue-600">
                                        <%= rs.getString("usuario") %>
                                    </a>
                                </h3>
                                <p class="text-sm text-gray-500">
                                    <%= rs.getString("fitness_level") %> • <%= rs.getString("experiencia") %>
                                </p>
                            </div>
                        </div>
                    </div>

                    <p class="px-4 py-2 text-gray-800">
                        <%= rs.getString("contenido") %>
                    </p>

                    <% if (!postImageBase64.isEmpty()) { %>
                        <div class="aspect-w-16 aspect-h-9">
                            <img src="data:image/jpeg;base64,<%= postImageBase64 %>"
                                 alt="Post image"
                                 class="w-full h-full object-cover">
                        </div>
                    <% } %>

                    <div class="px-4 py-3 border-t border-gray-100 flex items-center justify-between">
                        <div class="flex items-center space-x-2">
                            <button class="flex items-center space-x-1 text-gray-600 hover:text-red-500">
                                <i data-lucide="heart" class="h-5 w-5"></i>
                                <span><%= rs.getInt("likes") %></span>
                            </button>
                        </div>
                        <span class="text-sm text-gray-500">
                            <%= rs.getTimestamp("fecha_publicacion").toString() %>
                        </span>
                    </div>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
        </main>
    </div>

    <script>
        // Initialize Lucide icons
        lucide.createIcons();

        // Preview image before upload
        document.querySelector('input[type="file"]').addEventListener('change', function(e) {
            if (e.target.files && e.target.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    // You could add preview functionality here if desired
                };
                reader.readAsDataURL(e.target.files[0]);
            }
        });
    </script>
</body>
</html>
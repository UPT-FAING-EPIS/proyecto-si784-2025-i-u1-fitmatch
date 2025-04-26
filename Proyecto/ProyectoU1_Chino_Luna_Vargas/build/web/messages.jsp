<%-- 
    Document   : messages
    Created on : 10 feb 2025, 10:32:48 p.m.
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Clases.SqlConection" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<!DOCTYPE html>
<html>
    <head>
        <title>FitMatch - Mensajes</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
    </head>
    <body class="min-h-screen bg-gray-50">
        <%
            // Verificar si el usuario está logueado
            if (session.getAttribute("userId") == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            Integer userId = (Integer) session.getAttribute("userId");
        %>

        <!-- Header -->
        <header class="bg-white shadow-sm">
            <div class="max-w-5xl mx-auto px-4 py-4 flex items-center justify-between">
                <div class="flex items-center space-x-2">
                    <a href="dashboard.jsp" class="flex items-center space-x-2">
                        <i data-lucide="dumbbell" class="h-8 w-8 text-blue-600"></i>
                        <h1 class="text-2xl font-bold text-blue-600">FITMATCH</h1>
                    </a>
                </div>
                <div class="flex items-center space-x-6">
                    <i data-lucide="message-circle" class="h-6 w-6 text-blue-600"></i>
                    <a href="profile.jsp">
                        <i data-lucide="settings" class="h-6 w-6 text-gray-600 hover:text-blue-600"></i>
                    </a>
                    <a href="LogoutServlet" class="text-gray-600 hover:text-blue-600">Salir</a>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="max-w-5xl mx-auto px-4 py-6">

            <div class="flex h-screen bg-gray-100"">
                <!-- Panel de contactos -->
                <div class="w-1/3 bg-white shadow-md p-4 flex flex-col h-full">
                    <h2 class="text-xl font-bold flex items-center mb-4">Matches<span class="ml-auto"><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M21 12.38V9a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2h8.38M15 18l6 6m0 0l-6-6m6 6V15" />
                            </svg></span></h2>
                    <div class="relative mb-4">
                        <input type="text" id="searchInput" placeholder="Buscar contactos..." class="w-full p-2 rounded-lg border border-gray-300 pl-10" onkeyup="buscarContactos()">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="absolute left-3 top-3 w-5 h-5 text-gray-400">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-4.35-4.35M15 10.5a4.5 4.5 0 11-9 0 4.5 4.5 0 019 0z" />
                        </svg>
                    </div>
                    
                    <ul id="contactList" class="overflow-y-auto flex-1" style="max-height: 70vh;">

                    <%
                        try (Connection conn = SqlConection.getConnection()) {
                            String matchesSql = "SELECT DISTINCT u.id, u.usuario, d.imagen_perfil " +
                                              "FROM Usuarios u " +
                                              "JOIN Matches m ON (m.matched_user_id = u.id OR m.user_id = u.id) " +
                                              "LEFT JOIN DatosUsuarios d ON u.id = d.usuario_id " +
                                              "WHERE (m.user_id = ? OR m.matched_user_id = ?) " +
                                              "AND m.liked = true " +
                                              "AND m.status = 'accepted'";
                            
                            PreparedStatement matchesStmt = conn.prepareStatement(matchesSql);
                            matchesStmt.setInt(1, userId);
                            matchesStmt.setInt(2, userId);
                            ResultSet matchesRs = matchesStmt.executeQuery();

                            while (matchesRs.next()) {
                                int matchId = matchesRs.getInt("id");
                                String matchName = matchesRs.getString("usuario");
                                Blob imageBlob = matchesRs.getBlob("imagen_perfil");
                                String imageBase64 = "";
                                if (imageBlob != null) {
                                    byte[] imageBytes = imageBlob.getBytes(1, (int)imageBlob.length());
                                    imageBase64 = java.util.Base64.getEncoder().encodeToString(imageBytes);
                                }
                    %>
                    

                        <li class="contact-item flex items-center p-3 border-b hover:bg-gray-200 cursor-pointer" onclick="abrirChat(<%=matchId%>)">
                            <% if (imageBase64.isEmpty()) { %>
                                    <img src="https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800&auto=format&fit=crop"
                                         alt="Profile"
                                         class="w-10 h-10 rounded-full object-cover mr-3">
                                <% } else { %>
                                    <img src="data:image/jpeg;base64,<%= imageBase64 %>"
                                         alt="Profile"
                                         class="w-10 h-10 rounded-full object-cover mr-3">
                                <% } %>
                            <%= matchName %>
                            <span class="ml-auto bg-blue-500 text-white text-xs px-2 py-1 rounded-full">2</span>
                        </li>
                        
                        <%
                            }
                        } catch (Exception e) {
                            out.println("Error: " + e.getMessage());
                        }
                    %>
                        
                    </ul>
                </div>

                <!-- Panel del chat -->
                <div class="w-3/4 h-full overflow-hidden">
                    <iframe id="chatFrame" src="LoginPublico?idUsuarioReceptor=${idUsuario}" class="w-full h-full border-none overflow-y-auto" style="max-height: 100vh;"></iframe>
                </div>

                <script>
                    function abrirChat(id) {
                        document.getElementById('chatFrame').src = 'LoginPublico?idUsuarioReceptor='+id;
                    }

                    function buscarContactos() {
                        let input = document.getElementById('searchInput').value.toLowerCase();
                        let contactos = document.querySelectorAll('.contact-item');

                        contactos.forEach(contacto => {
                            let texto = contacto.textContent.toLowerCase();
                            contacto.style.display = texto.includes(input) ? '' : 'none';
                        });
                    }
                </script>
            </div>
        </main>

        <script>
            // Initialize Lucide icons
            lucide.createIcons();
        </script>
    </body>
</html>
<%-- 
    Document   : user-profile
    Created on : 11 feb 2025, 10:02:57 p.m.
    Author     : ASUS
--%>

<%@page import="Negocio.ClsNValoracion"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Clases.SqlConection"%>
<!DOCTYPE html>
<!-- MODIFICADO -->
<html>
    <head>
        <title>FitMatch - Perfil de Usuario</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <link rel="icon" href="fitmatch-logo.ico" type="image/x-icon">
        <style>
            .group:hover .tooltip {
                display: block; 
            }
            .tooltip {
                display: none; 
                white-space: nowrap; /* evitatexto dividio en varias líneas */
                z-index: 10; 
            }
        </style>
    </head>
    <body class="min-h-screen bg-gray-50">
        <%
            if (session.getAttribute("userId") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String profileUserId = request.getParameter("userId");
            if (profileUserId == null) {
                response.sendRedirect("feed.jsp");
                return;
            }

            try (Connection conn = SqlConection.getConnection()) {
                String userQuery = "SELECT u.usuario,d.verif, d.imagen_perfil, d.experiencia, d.fitness_level, d.distancia "
                        + "FROM Usuarios u "
                        + "LEFT JOIN DatosUsuarios d ON u.id = d.usuario_id "
                        + "WHERE u.id = ?";

                PreparedStatement userStmt = conn.prepareStatement(userQuery);
                userStmt.setString(1, profileUserId);
                ResultSet userRs = userStmt.executeQuery();

                if (userRs.next()) {
                    String username = userRs.getString("usuario");
                    String imageBase64 = "";
                    Blob imageBlob = userRs.getBlob("imagen_perfil");
                    int verificado = userRs.getInt("verif");
                    if (imageBlob != null) {
                        byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                        imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                    }
        %>

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
                    <a href="feed.jsp" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
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
                    <a href="logout" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="log-out" class="h-6 w-6"></i>
                        <span>Salir</span>
                    </a>
                </nav>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="ml-64 flex-1 p-6">
            <!-- Profile Header -->
            <div class="max-w-4xl mx-auto">
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <div class="flex items-start space-x-6">
                        <div class="w-32 h-32 rounded-full overflow-hidden">
                            <% if (imageBase64.isEmpty()) { %>
                            <img src="https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800&auto=format&fit=crop"
                                 alt="Profile"
                                 class="w-full h-full object-cover">
                            <% } else {%>
                            <img src="data:image/jpeg;base64,<%= imageBase64%>"
                                 alt="Profile"
                                 class="w-full h-full object-cover">
                            <% }%>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between mb-4">
                                <div class="flex items-center relative">
                                    <h1 class="text-2xl font-bold"><%= username%></h1>
                                    <%
                                        if (verificado == 1) {%>   
                                    <div class="relative group">
                                        <img width="24" height="24" src="https://img.icons8.com/material-rounded/48/228BE6/verified-account.png" alt="verified-account" class="ml-2" />
                                        <div class="tooltip hidden absolute left-full ml-2 bg-black text-white text-sm rounded py-1 px-2">
                                            Esta persona ha sido verificada tomando en cuenta sus valoraciones.
                                        </div>
                                    </div>
                                    <% }%>
                                </div>
                                <button class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
                                    Seguir
                                </button>
                            </div>
                            <div class="grid grid-cols-3 gap-4 mb-4 text-center">
                                <div>
                                    <div class="font-bold text-xl">31</div>
                                    <div class="text-gray-600">Entrenos</div>
                                </div>
                                <div>
                                    <div class="font-bold text-xl">21.3K</div>
                                    <div class="text-gray-600">Seguidores</div>
                                </div>
                                <div>
                                    <div class="font-bold text-xl">3</div>
                                    <div class="text-gray-600">Siguiendo</div>
                                </div>
                            </div>
                            <div class="space-y-2">
                                <div class="flex items-center space-x-2">
                                    <i data-lucide="award" class="h-5 w-5 text-gray-600"></i>
                                    <span class="text-gray-600">Nivel: <%= userRs.getString("fitness_level")%></span>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <i data-lucide="timer" class="h-5 w-5 text-gray-600"></i>
                                    <span class="text-gray-600">Experiencia: <%= userRs.getString("experiencia")%></span>
                                </div>
                                <div class="flex items-center space-x-2">
                                    <i data-lucide="map-pin" class="h-5 w-5 text-gray-600"></i>
                                    <span class="text-gray-600">Distancia: <%= userRs.getString("distancia")%></span>
                                </div>
                            </div>

                            <div x-data="{ openModal: false }">
                                <!-- Botón para abrir el modal -->
                                <button class="mt-4 px-4 py-2 bg-gray-800 text-white rounded-lg hover:bg-gray-900" 
                                        @click="openModal = true">
                                    Ver Valoraciones
                                </button>

                                <!-- Modal de valoraciones -->
                                <div x-show="openModal" 
                                     style="display: none;" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50">
                                    <div class="bg-white rounded-lg p-6 w-96 max-w-full">
                                        <div class="flex justify-between items-center mb-4">
                                            <h2 class="text-xl font-bold">Valoraciones</h2>
                                            <button @click="openModal = false" class="text-gray-500 hover:text-gray-700">✖</button>
                                        </div>

                                        <!-- Contenedor con scroll -->
                                        <div class="max-h-64 overflow-y-auto space-y-4">
                                            <%
                                                ClsNValoracion ObjNValoracion = new ClsNValoracion();
                                                ResultSet rsValoraciones = ObjNValoracion.listarValoraciones(Integer.parseInt(request.getParameter("userId")));

                                                while (rsValoraciones.next()) {
                                                    int estrellas = rsValoraciones.getInt("estrellas");
                                                    String comentario = rsValoraciones.getString("detalle");
                                                    String fecha = rsValoraciones.getString("fecha");
                                                    String nombre = rsValoraciones.getString("nombre") + " " + rsValoraciones.getString("apellido");
                                            %>
                                            <div class="border-b pb-2">
                                                <div class="flex items-center space-x-2">
                                                    <span class="font-bold"><%= nombre%></span>
                                                    <div class="flex text-yellow-400">
                                                        <% for (int i = 1; i <= 5; i++) { %>
                                                        <% if (i <= estrellas) { %> ★ <% } else { %> ☆ <% } %>
                                                        <% }%>
                                                    </div>
                                                </div>
                                                <p class="text-gray-600 text-sm"><%= comentario%></p>
                                                <span class="text-xs text-gray-500"><%= fecha%></span>
                                            </div>
                                            <% } %>
                                        </div>

                                        <div class="mt-4 text-right">
                                            <button @click="openModal = false" 
                                                     class="px-4 py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700">
                                                Cerrar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



                <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.12.0/dist/cdn.min.js" defer></script>


                <!-- Training Stats -->
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <h2 class="text-xl font-bold mb-4">Estadísticas de Entrenamiento</h2>
                    <div id="trainingChart" style="height: 300px;"></div>
                </div>

                <!-- Recent Workouts -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h2 class="text-xl font-bold mb-4">Entrenamientos Recientes</h2>
                    <%
                        String workoutsQuery = "SELECT contenido, fecha_publicacion, likes "
                                + "FROM Publicaciones "
                                + "WHERE usuario_id = ? "
                                + "ORDER BY fecha_publicacion DESC "
                                + "LIMIT 5";

                        PreparedStatement workoutsStmt = conn.prepareStatement(workoutsQuery);
                        workoutsStmt.setString(1, profileUserId);
                        ResultSet workoutsRs = workoutsStmt.executeQuery();

                        while (workoutsRs.next()) {
                    %>
                    <div class="border-b border-gray-200 py-4 last:border-0">
                        <div class="flex items-center justify-between mb-2">
                            <h3 class="font-semibold"><%= workoutsRs.getString("contenido")%></h3>
                            <span class="text-sm text-gray-500">
                                <%= workoutsRs.getTimestamp("fecha_publicacion").toString()%>
                            </span>
                        </div>
                        <div class="flex items-center space-x-4 text-sm text-gray-600">
                            <div class="flex items-center space-x-1">
                                <i data-lucide="heart" class="h-4 w-4"></i>
                                <span><%= workoutsRs.getInt("likes")%> likes</span>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </main>

        <script>
            // Initialize Lucide icons
            lucide.createIcons();

            // Initialize training chart
            Highcharts.chart('trainingChart', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Horas de Entrenamiento por Semana'
                },
                xAxis: {
                    categories: ['nov 24', 'dic 8', 'dic 22', 'ene 5', 'ene 19', 'feb 2'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Horas'
                    }
                },
                series: [{
                        name: 'Horas',
                        data: [0, 4.5, 6, 5.5, 1.5, 3],
                        color: '#3B82F6'
                    }]
            });
        </script>
    </body>
</html>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
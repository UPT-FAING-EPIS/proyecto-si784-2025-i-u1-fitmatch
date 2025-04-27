<%-- 
    Document   : profile
    Created on : 10 feb 2025, 11:00:51 p.m.
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Clases.SqlConection" %>
<!-- MODIFICADO -->
<html>
<head>
    <title>FitMatch - Perfil</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="min-h-screen bg-gray-50">
    <% 
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Integer userId = (Integer)session.getAttribute("userId");
    String currentExperience = "";
    String currentGym = "";
    String currentDistance = "";
    String imageBase64 = "";
   String currentTrainingType = "";
    String currentSchedule = "";
    
    try (Connection conn = SqlConection.getConnection()) {
        String sql = "SELECT experiencia, fitness_level, distancia, imagen_perfil, tipo_entrenamiento, horario_entrenamiento FROM DatosUsuarios WHERE usuario_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            currentExperience = rs.getString("fitness_level");
            currentGym = rs.getString("experiencia");
            currentDistance = rs.getString("distancia");
            currentTrainingType = rs.getString("tipo_entrenamiento");
            currentSchedule = rs.getString("horario_entrenamiento");
            Blob imageBlob = rs.getBlob("imagen_perfil");
            if (imageBlob != null) {
                byte[] imageBytes = imageBlob.getBytes(1, (int)imageBlob.length());
                imageBase64 = java.util.Base64.getEncoder().encodeToString(imageBytes);
                }
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
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
            <nav class="flex items-center space-x-6">
                <a href="workout-tracking.jsp" class="text-gray-600 hover:text-blue-600">
                    <i data-lucide="activity" class="h-6 w-6"></i>
                </a>
                <a href="messages.jsp">
                    <i data-lucide="message-circle" class="h-6 w-6 text-gray-600 hover:text-blue-600"></i>
                </a>
                <i data-lucide="settings" class="h-6 w-6 text-blue-600"></i>
                <a href="LogoutServlet" class="text-gray-600 hover:text-blue-600">Salir</a>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <main class="max-w-2xl mx-auto px-4 py-8">
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="p-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-6">Configuración del Perfil</h2>
                
                <form action="updateProfile" method="post" enctype="multipart/form-data" class="space-y-6">
                    <!-- Profile Photo Section -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            Foto de Perfil
                        </label>
                        <div class="flex items-center space-x-6">
                            <div class="w-24 h-24 rounded-full overflow-hidden bg-gray-100">
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
                            <div>
                                <input type="file" id="profileImage" name="profileImage" accept="image/*"
                                    class="block w-full text-sm text-gray-500
                                        file:mr-4 file:py-2 file:px-4
                                        file:rounded-full file:border-0
                                        file:text-sm file:font-semibold
                                        file:bg-blue-50 file:text-blue-700
                                        hover:file:bg-blue-100">
                                <p class="mt-1 text-sm text-gray-500">PNG, JPG hasta 1MB</p>
                            </div>
                        </div>
                    </div>

                    <!-- Experience Level -->
                    <div>
                        <label for="experienceLevel" class="block text-sm font-medium text-gray-700 mb-2">
                            Nivel de Experiencia
                        </label>
                        <select id="experienceLevel" name="experienceLevel"
                            class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 rounded-md">
                            <option value="Principiante" <%= currentExperience.equals("Principiante") ? "selected" : "" %>>Principiante</option>
                            <option value="Intermedio" <%= currentExperience.equals("Intermedio") ? "selected" : "" %>>Intermedio</option>
                            <option value="Avanzado" <%= currentExperience.equals("Avanzado") ? "selected" : "" %>>Avanzado</option>
                        </select>
                    </div>

                    <!-- Gym -->
                    <div>
                        <label for="gym" class="block text-sm font-medium text-gray-700 mb-2">
                            Experiencia
                        </label>
                        <input type="text" id="gym" name="gym" value="<%= currentGym %>"
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                            placeholder="Nombre de tu gimnasio">
                    </div>

                    <!-- Distance -->
                    <div>
                        <label for="distance" class="block text-sm font-medium text-gray-700 mb-2">
                            Distancia Máxima de Búsqueda
                        </label>
                        <select id="distance" name="distance"
                            class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 rounded-md">
                            <option value="1km" <%= currentDistance.equals("1km") ? "selected" : "" %>>1 km</option>
                            <option value="5km" <%= currentDistance.equals("5km") ? "selected" : "" %>>5 km</option>
                            <option value="10km" <%= currentDistance.equals("10km") ? "selected" : "" %>>10 km</option>
                            <option value="20km" <%= currentDistance.equals("20km") ? "selected" : "" %>>20 km</option>
                            <option value="50km" <%= currentDistance.equals("50km") ? "selected" : "" %>>50 km</option>
                        </select>
                    </div>
                        
                        <div>
                        <label for="trainingType" class="block text-sm font-medium text-gray-700 mb-2">
                            Tipo de Entrenamiento Preferido
                        </label>
                        <select id="trainingType" name="trainingType"
                            class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 rounded-md">
                            <option value="Pesas" <%= currentTrainingType != null && currentTrainingType.equals("Pesas") ? "selected" : "" %>>Pesas</option>
                            <option value="Cardio" <%= currentTrainingType != null && currentTrainingType.equals("Cardio") ? "selected" : "" %>>Cardio</option>
                            <option value="CrossFit" <%= currentTrainingType != null && currentTrainingType.equals("CrossFit") ? "selected" : "" %>>CrossFit</option>
                            <option value="Calistenia" <%= currentTrainingType != null && currentTrainingType.equals("Calistenia") ? "selected" : "" %>>Calistenia</option>
                            <option value="Funcional" <%= currentTrainingType != null && currentTrainingType.equals("Funcional") ? "selected" : "" %>>Funcional</option>
                        </select>
                    </div>

                    <!-- Training Schedule -->
                    <div>
                        <label for="trainingSchedule" class="block text-sm font-medium text-gray-700 mb-2">
                            Horario de Entrenamiento Preferido
                        </label>
                        <select id="trainingSchedule" name="trainingSchedule"
                            class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 rounded-md">
                            <option value="5-7AM" <%= currentSchedule != null && currentSchedule.equals("5-7AM") ? "selected" : "" %>>5:00 AM - 7:00 AM</option>
                            <option value="6-8AM" <%= currentSchedule != null && currentSchedule.equals("6-8AM") ? "selected" : "" %>>6:00 AM - 8:00 AM</option>
                            <option value="7-9AM" <%= currentSchedule != null && currentSchedule.equals("7-9AM") ? "selected" : "" %>>7:00 AM - 9:00 AM</option>
                            <option value="8-10AM" <%= currentSchedule != null && currentSchedule.equals("8-10AM") ? "selected" : "" %>>8:00 AM - 10:00 AM</option>
                            <option value="9-11AM" <%= currentSchedule != null && currentSchedule.equals("9-11AM") ? "selected" : "" %>>9:00 AM - 11:00 AM</option>
                            <option value="10-12PM" <%= currentSchedule != null && currentSchedule.equals("10-12PM") ? "selected" : "" %>>10:00 AM - 12:00 PM</option>
                            <option value="11-1PM" <%= currentSchedule != null && currentSchedule.equals("11-1PM") ? "selected" : "" %>>11:00 AM - 1:00 PM</option>
                            <option value="12-2PM" <%= currentSchedule != null && currentSchedule.equals("12-2PM") ? "selected" : "" %>>12:00 PM - 2:00 PM</option>
                            <option value="1-3PM" <%= currentSchedule != null && currentSchedule.equals("1-3PM") ? "selected" : "" %>>1:00 PM - 3:00 PM</option>
                            <option value="2-4PM" <%= currentSchedule != null && currentSchedule.equals("2-4PM") ? "selected" : "" %>>2:00 PM - 4:00 PM</option>
                            <option value="3-5PM" <%= currentSchedule != null && currentSchedule.equals("3-5PM") ? "selected" : "" %>>3:00 PM - 5:00 PM</option>
                            <option value="4-6PM" <%= currentSchedule != null && currentSchedule.equals("4-6PM") ? "selected" : "" %>>4:00 PM - 6:00 PM</option>
                            <option value="5-7PM" <%= currentSchedule != null && currentSchedule.equals("5-7PM") ? "selected" : "" %>>5:00 PM - 7:00 PM</option>
                            <option value="6-8PM" <%= currentSchedule != null && currentSchedule.equals("6-8PM") ? "selected" : "" %>>6:00 PM - 8:00 PM</option>
                            <option value="7-9PM" <%= currentSchedule != null && currentSchedule.equals("7-9PM") ? "selected" : "" %>>7:00 PM - 9:00 PM</option>
                            <option value="8-10PM" <%= currentSchedule != null && currentSchedule.equals("8-10PM") ? "selected" : "" %>>8:00 PM - 10:00 PM</option>
                        </select>
                    </div>

                    <!-- Save Button -->
                    <div class="pt-4">
                        <button type="submit"
                            class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            Guardar Cambios
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script>
        // Initialize Lucide icons
        lucide.createIcons();
    </script>
</body>
</html>
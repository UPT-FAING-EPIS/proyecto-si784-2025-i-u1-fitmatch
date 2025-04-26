<%-- 
    Document   : workout-tracking
    Created on : 11 feb 2025, 7:51:59 p.m.
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Clases.SqlConection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitMatch - Seguimiento de Ejercicios</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
</head>
<body class="min-h-screen bg-gray-50">
    <%
    // Verificar sesión
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Integer userId = (Integer)session.getAttribute("userId");
    String selectedExercise = request.getParameter("exercise") != null ? 
                            request.getParameter("exercise") : "1";
    
    // Preparar datos para el gráfico
    String data = "";
    String exerciseName = "";
    try (Connection conn = SqlConection.getConnection()) {
        CallableStatement cstmt = conn.prepareCall("{CALL SP_Exercise_Progress(?, ?)}");
        cstmt.setInt(1, Integer.parseInt(selectedExercise));
        cstmt.setInt(2, userId);
        ResultSet rs = cstmt.executeQuery();
        
        StringBuilder seriesData = new StringBuilder();
        boolean hasData = false;
        
        while (rs.next()) {
            if (!hasData) {
                exerciseName = rs.getString("nombre_ejercicio");
                seriesData.append("{name:'").append(exerciseName)
                         .append("',data:[");
                hasData = true;
            }
            
            String fecha = rs.getString("fecha");
            double peso = rs.getDouble("peso");
            
            String timestamp = "Date.UTC(" + fecha.substring(0, 4) + "," + 
                             (Integer.parseInt(fecha.substring(5, 7)) - 1) + "," + 
                             fecha.substring(8, 10) + ")";
            
            if (seriesData.toString().endsWith("[")) {
                seriesData.append("[").append(timestamp).append(",").append(peso).append("]");
            } else {
                seriesData.append(",[").append(timestamp).append(",").append(peso).append("]");
            }
        }
        
        if (hasData) {
            seriesData.append("]}");
            data = seriesData.toString();
        } else {
            data = "{name:'Sin datos',data:[]}";
        }
        
    } catch (Exception e) {
        out.println("Error al cargar datos: " + e.getMessage());
        data = "{name:'Error',data:[]}";
    }
    %>

    <!-- Header -->
    <header class="bg-white shadow-sm">
        <div class="max-w-7xl mx-auto px-4 py-4 flex items-center justify-between">
            <div class="flex items-center space-x-2">
                <a href="index.jsp" class="flex items-center space-x-2">
                    <i data-lucide="dumbbell" class="h-8 w-8 text-blue-600"></i>
                    <h1 class="text-2xl font-bold text-blue-600">FITMATCH</h1>
                </a>
            </div>
            <nav class="flex items-center space-x-6">
                <a href="profile.jsp" class="text-gray-600 hover:text-blue-600">
                    <i data-lucide="user" class="h-6 w-6"></i>
                </a>
                <a href="LogoutServlet" class="text-gray-600 hover:text-blue-600">Cerrar Sesión</a>
            </nav>
        </div>
    </header>

    <!-- Mensajes de estado -->
    <% if (session.getAttribute("message") != null) { %>
        <div class="max-w-7xl mx-auto px-4 py-4">
            <div class="rounded-md p-4 <%= session.getAttribute("messageType").equals("success") ? "bg-green-50" : "bg-red-50" %>">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <% if (session.getAttribute("messageType").equals("success")) { %>
                            <i data-lucide="check-circle" class="h-5 w-5 text-green-400"></i>
                        <% } else { %>
                            <i data-lucide="x-circle" class="h-5 w-5 text-red-400"></i>
                        <% } %>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium <%= session.getAttribute("messageType").equals("success") ? "text-green-800" : "text-red-800" %>">
                            <%= session.getAttribute("message") %>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <% 
        session.removeAttribute("message");
        session.removeAttribute("messageType");
        %>
    <% } %>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 py-8">
        <!-- Exercise Selection and Progress Graph -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-8">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-800">Progreso de Ejercicios</h2>
                <form id="exerciseForm" method="get" class="w-64">
                    <select id="exerciseSelect" name="exercise" onchange="this.form.submit()" 
                            class="w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 rounded-md">
                        <% 
                        try (Connection conn = SqlConection.getConnection()) {
                            String sql = "SELECT id, nombre FROM ejercicios ORDER BY nombre";
                            PreparedStatement stmt = conn.prepareStatement(sql);
                            ResultSet rs = stmt.executeQuery();
                            while(rs.next()) {
                                String selected = rs.getString("id").equals(selectedExercise) ? "selected" : "";
                        %>
                            <option value="<%= rs.getString("id") %>" <%= selected %>>
                                <%= rs.getString("nombre") %>
                            </option>
                        <%
                            }
                        }
                        %>
                    </select>
                </form>
            </div>
            
            <div id="progressChart" style="min-height: 400px;"></div>
        </div>

        <!-- Record New Workout -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Registrar Entrenamiento</h2>
            
            <form action="saveWorkout" method="post" class="space-y-6" onsubmit="return validateForm(this)">
                <input type="hidden" name="userId" value="<%= userId %>">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Exercise Selection -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            Ejercicio
                        </label>
                        <select name="ejercicio_id" required
                                class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 rounded-md">
                            <%
                            try (Connection conn = SqlConection.getConnection()) {
                                String sql = "SELECT id, nombre FROM ejercicios ORDER BY nombre";
                                PreparedStatement stmt = conn.prepareStatement(sql);
                                ResultSet rs = stmt.executeQuery();
                                while(rs.next()) {
                            %>
                                <option value="<%= rs.getString("id") %>">
                                    <%= rs.getString("nombre") %>
                                </option>
                            <%
                                }
                            }
                            %>
                        </select>
                    </div>

                    <!-- Weight -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            Peso (kg)
                        </label>
                        <input type="number" name="peso" step="0.5" required min="0"
                               class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                    </div>

                    <!-- Sets -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            Series
                        </label>
                        <input type="number" name="series" required min="1"
                               class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                    </div>

                    <!-- Reps -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            Repeticiones
                        </label>
                        <input type="number" name="repeticiones" required min="1"
                               class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                    </div>
                </div>

                <!-- Notes -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">
                        Notas
                    </label>
                    <textarea name="notas" rows="3"
                              class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"></textarea>
                </div>

                <!-- Submit Button -->
                <div>
                    <button type="submit"
                            class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        Guardar Entrenamiento
                    </button>
                </div>
            </form>
        </div>

        <!-- Recent Workouts Table -->
        <div class="bg-white rounded-lg shadow-md p-6 mt-8">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Entrenamientos Recientes</h2>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fecha</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Ejercicio</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Series</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Repeticiones</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Peso</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Notas</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <%
                        try (Connection conn = SqlConection.getConnection()) {
                            String sql = "SELECT se.fecha, e.nombre, de.serie, de.repeticiones, de.peso, se.notas " +
                                       "FROM sesiones_entrenamiento se " +
                                       "INNER JOIN detalles_ejercicio de ON se.id = de.sesion_id " +
                                       "INNER JOIN ejercicios e ON de.ejercicio_id = e.id " +
                                       "WHERE se.usuario_id = ? " +
                                       "ORDER BY se.fecha DESC, e.nombre, de.serie " +
                                       "LIMIT 20";
                            PreparedStatement stmt = conn.prepareStatement(sql);
                            stmt.setInt(1, userId);
                            ResultSet rs = stmt.executeQuery();
                            while(rs.next()) {
                        %>
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <%= rs.getString("fecha") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                    <%= rs.getString("nombre") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <%= rs.getInt("serie") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <%= rs.getInt("repeticiones") %>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <%= rs.getDouble("peso") %> kg
                                </td>
                                <td class="px-6 py-4 text-sm text-gray-500 max-w-xs truncate">
                                    <%= rs.getString("notas") != null ? rs.getString("notas") : "" %>
                                </td>
                            </tr>
                        <%
                            }
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        // Initialize Lucide icons
        lucide.createIcons();

        // Initialize Highcharts
        Highcharts.chart('progressChart', {
            chart: {
                type: 'line',
                zoomType: 'xy'
            },
            title: {
                text: 'Progreso de Peso - <%= exerciseName %>'
            },
            xAxis: {
                type: 'datetime',
                title: {
                    text: 'Fecha'
                },
                dateTimeLabelFormats: {
                    day: '%e %b, %Y',
                    week: '%e %b, %Y',
                    month: '%b %Y',
                    year: '%Y'
                }
            },
            yAxis: {
                title: {
                    text: 'Peso (kg)'
                },
                min: 0
            },
            tooltip: {
                headerFormat: '<b>{series.name}</b><br />',
                pointFormat: '{point.y} kg<br/>{point.x:%e %b, %Y}'
            },
            plotOptions: {
                series: {
                    marker: {
                        enabled: true
                    },
                    connectNulls: true,
                    label: {
                        connectorAllowed: false
                    }
                }
            },
            series: [
                <%=data %>
            ],
            responsive: {
                rules: [{
                    condition: {
                        maxWidth: 500
                    },
                    chartOptions: {
                        legend: {
                            layout: 'horizontal',
                            align: 'center',
                            verticalAlign: 'bottom'
                        }
                    }
                }]
            }
        });

        // Form validation
        function validateForm(form) {
            console.log('Form submission started');
            
            // Get form values
            const peso = form.peso.value;
            const series = form.series.value;
            const repeticiones = form.repeticiones.value;
            
            // Validate values
            if (peso <= 0 || series <= 0 || repeticiones <= 0) {
                alert('Todos los valores deben ser mayores que 0');
                return false;
            }
            
            console.log('Form validation passed, submitting...');
            return true;
        }

        // Handle exercise selection change
        document.getElementById('exerciseSelect').addEventListener('change', function() {
            document.getElementById('exerciseForm').submit();
        });

        // Add form submission logging
        document.querySelector('form').addEventListener('submit', function(e) {
            console.log('Form submitted');
        });
    </script>
</body>
</html>
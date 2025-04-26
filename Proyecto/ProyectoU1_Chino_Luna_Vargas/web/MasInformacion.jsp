<%-- 
    Document   : MasInformacion
    Created on : 5 feb 2025, 12:23:15
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GymMatch - Más Información</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div class="max-w-7xl mx-auto px-4 py-12">
        <div class="text-center mb-16">
            <h1 class="text-4xl font-bold text-blue-600 mb-4">Más Información</h1>
            <p class="text-xl text-gray-600">Todo lo que necesitas saber sobre FitMatch</p>
        </div>
        
        <div class="grid md:grid-cols-2 gap-12">
            <div class="bg-white p-8 rounded-xl shadow-md">
                <h2 class="text-2xl font-bold mb-6">Cómo Funciona</h2>
                <div class="space-y-6">
                    <div class="flex items-start">
                        <i data-lucide="check-circle" class="w-6 h-6 text-blue-600 mr-4 flex-shrink-0"></i>
                        <div>
                            <h3 class="font-semibold mb-2">Crea tu perfil</h3>
                            <p class="text-gray-600">
                                Añade tus fotos, describe tus objetivos fitness y tus rutinas favoritas
                            </p>
                        </div>
                    </div>
                    <div class="flex items-start">
                        <i data-lucide="clock" class="w-6 h-6 text-blue-600 mr-4 flex-shrink-0"></i>
                        <div>
                            <h3 class="font-semibold mb-2">Encuentra matches</h3>
                            <p class="text-gray-600">
                                Desliza perfiles y conecta con personas que comparten tus intereses
                            </p>
                        </div>
                    </div>
                    <div class="flex items-start">
                        <i data-lucide="map-pin" class="w-6 h-6 text-blue-600 mr-4 flex-shrink-0"></i>
                        <div>
                            <h3 class="font-semibold mb-2">Entrena juntos</h3>
                            <p class="text-gray-600">
                                Organiza sesiones de entrenamiento y conoce a tu match en persona
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="space-y-8">
                <div class="bg-white p-8 rounded-xl shadow-md">
                    <h2 class="text-2xl font-bold mb-4">Preguntas Frecuentes</h2>
                    <div class="space-y-4">
                        <details class="group">
                            <summary class="flex justify-between items-center font-medium cursor-pointer list-none">
                                <span>¿Es gratis FitMatch?</span>
                                <span class="transition group-open:rotate-180">▼</span>
                            </summary>
                            <p class="text-gray-600 mt-3">
                                FitMatch es gratis para usar, pero ofrecemos funciones premium para una experiencia mejorada.
                            </p>
                        </details>
                        <details class="group">
                            <summary class="flex justify-between items-center font-medium cursor-pointer list-none">
                                <span>¿Cómo funciona el sistema de matches?</span>
                                <span class="transition group-open:rotate-180">▼</span>
                            </summary>
                            <p class="text-gray-600 mt-3">
                                Cuando dos usuarios se dan like mutuamente, se crea un match y pueden comenzar a chatear.
                            </p>
                        </details>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Initialize Lucide Icons -->
    <script>
        lucide.createIcons();
    </script>
</body>
</html>
<%@include file="Footer.jsp" %>
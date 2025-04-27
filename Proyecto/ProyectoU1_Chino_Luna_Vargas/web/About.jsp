<%-- 
    Document   : About
    Created on : 9 feb 2025, 11:01:37 p.m.
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GymMatch - Sobre Nosotros</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div class="max-w-7xl mx-auto px-4 py-12">
        <div class="text-center mb-16">
            <h1 class="text-4xl font-bold text-blue-600 mb-4">Sobre FitMatch</h1>
            <p class="text-xl text-gray-600">
                Conectando personas apasionadas por el fitness y el estilo de vida saludable
            </p>
        </div>
        
        <div class="grid md:grid-cols-2 gap-12 mb-16">
            <div>
                <img
                    src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48"
                    alt="Gym community"
                    class="rounded-xl shadow-lg"
                />
            </div>
            <div class="flex flex-col justify-center">
                <h2 class="text-3xl font-bold mb-6">Nuestra Misión</h2>
                <p class="text-gray-600 text-lg mb-6">
                    En FitMatch, creemos que el fitness es mejor cuando se comparte. Nuestra plataforma está
                    diseñada para conectar personas que comparten la pasión por el ejercicio y el estilo de
                    vida saludable.
                </p>
                <div class="grid gap-4">
                    <div class="flex items-center">
                        <div class="bg-blue-100 p-3 rounded-full mr-4">
                            <i data-lucide="target" class="w-6 h-6 text-blue-600"></i>
                        </div>
                        <span class="text-gray-700">Conexiones significativas basadas en objetivos comunes</span>
                    </div>
                    <div class="flex items-center">
                        <div class="bg-blue-100 p-3 rounded-full mr-4">
                            <i data-lucide="users" class="w-6 h-6 text-blue-600"></i>
                        </div>
                        <span class="text-gray-700">Comunidad activa y motivadora</span>
                    </div>
                    <div class="flex items-center">
                        <div class="bg-blue-100 p-3 rounded-full mr-4">
                            <i data-lucide="shield" class="w-6 h-6 text-blue-600"></i>
                        </div>
                        <span class="text-gray-700">Ambiente seguro y respetuoso</span>
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
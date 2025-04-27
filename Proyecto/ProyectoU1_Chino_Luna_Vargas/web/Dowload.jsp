<%-- 
    Document   : Dowload
    Created on : 9 feb 2025, 10:58:20 p.m.
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FitMatch - Descarga la App</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div class="w-full">
        <!-- Hero Section -->
        <div class="min-h-[70vh] bg-gradient-to-b from-blue-50 to-white relative overflow-hidden">
            <div class="max-w-7xl mx-auto px-4 pt-32 pb-16">
                <div class="text-center mb-16">
                    <span class="text-blue-600 font-semibold mb-4 block">Nuevo FitMatch 2.0</span>
                    <h1 class="text-6xl font-bold mb-6">Una nueva era del
                        <br><span style="background: linear-gradient(to right, #2563eb, #60a5fa); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">fitness social</span>
                    </h1>
                    <p class="text-xl text-gray-600 max-w-2xl mx-auto mb-8">
                        Descarga la aplicación líder en conexiones fitness. Disponible para Android y PC.
                    </p>
                    <div class="flex flex-col sm:flex-row justify-center gap-4">
                        <button class="bg-blue-600 text-white px-8 py-4 rounded-xl font-semibold hover:bg-blue-500 transition-colors flex items-center justify-center">
                            <i data-lucide="download" class="w-5 h-5 mr-2"></i>
                            Descargar para Android
                        </button>
                        <button class="bg-gray-900 text-white px-8 py-4 rounded-xl font-semibold hover:bg-gray-800 transition-colors flex items-center justify-center">
                            <i data-lucide="download" class="w-5 h-5 mr-2"></i>
                            Descargar para PC
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Features Grid -->
        <div class="py-20 bg-white">
            <div class="max-w-7xl mx-auto px-4">
                <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <div class="bg-gradient-to-br from-blue-50 to-white p-8 rounded-3xl">
                        <div class="bg-blue-600 w-12 h-12 rounded-2xl flex items-center justify-center mb-6">
                            <i data-lucide="shield" class="w-6 h-6 text-white"></i>
                        </div>
                        <h3 class="text-xl font-semibold mb-4">Verificación de Usuarios</h3>
                        <p class="text-gray-600">Sistema de verificación avanzado para garantizar una comunidad auténtica y segura.</p>
                    </div>
                    <div class="bg-gradient-to-br from-blue-50 to-white p-8 rounded-3xl">
                        <div class="bg-blue-600 w-12 h-12 rounded-2xl flex items-center justify-center mb-6">
                            <i data-lucide="zap" class="w-6 h-6 text-white"></i>
                        </div>
                        <h3 class="text-xl font-semibold mb-4">Matches Inteligentes</h3>
                        <p class="text-gray-600">Algoritmo que conecta usuarios según nivel, objetivos y horarios de entrenamiento.</p>
                    </div>
                    <div class="bg-gradient-to-br from-blue-50 to-white p-8 rounded-3xl">
                        <div class="bg-blue-600 w-12 h-12 rounded-2xl flex items-center justify-center mb-6">
                            <i data-lucide="message-circle" class="w-6 h-6 text-white"></i>
                        </div>
                        <h3 class="text-xl font-semibold mb-4">Chat en Tiempo Real</h3>
                        <p class="text-gray-600">Comunicación instantánea con tus matches y compartir rutinas de ejercicios.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Comparison Section -->
        <div class="py-20 bg-gradient-to-b from-white to-blue-50">
            <div class="max-w-7xl mx-auto px-4">
                <h2 class="text-4xl font-bold text-center mb-16">Elige tu plan ideal</h2>
                <div class="grid md:grid-cols-2 gap-8">
                    <div class="bg-white p-8 rounded-3xl shadow-lg">
                        <div class="text-center mb-8">
                            <h3 class="text-2xl font-bold mb-4">FitMatch Básico</h3>
                            <p class="text-gray-600">Perfecto para comenzar</p>
                            <div class="text-4xl font-bold mt-4">Gratis</div>
                        </div>
                        <ul class="space-y-4">
                            <li class="flex items-center">
                                <i data-lucide="award" class="w-5 h-5 text-blue-600 mr-2"></i>
                                <span>10 matches por día</span>
                            </li>
                            <li class="flex items-center">
                                <i data-lucide="award" class="w-5 h-5 text-blue-600 mr-2"></i>
                                <span>Mensajes básicos</span>
                            </li>
                            <li class="flex items-center">
                                <i data-lucide="award" class="w-5 h-5 text-blue-600 mr-2"></i>
                                <span>Perfil verificado</span>
                            </li>
                        </ul>
                    </div>
                    <div class="bg-gradient-to-br from-blue-600 to-blue-400 text-white p-8 rounded-3xl shadow-lg">
                        <div class="text-center mb-8">
                            <h3 class="text-2xl font-bold mb-4">FitMatch Pro</h3>
                            <p class="text-blue-100">Para usuarios exigentes</p>
                            <div class="text-4xl font-bold mt-4">S/.70 mes</div>
                        </div>
                        <ul class="space-y-4">
                            <li class="flex items-center">
                                <i data-lucide="award" class="w-5 h-5 text-white mr-2"></i>
                                <span>Matches ilimitados</span>
                            </li>
                            <li class="flex items-center">
                                <i data-lucide="award" class="w-5 h-5 text-white mr-2"></i>
                                <span>Chat</span>
                            </li>
                            <li class="flex items-center">
                                <i data-lucide="award" class="w-5 h-5 text-white mr-2"></i>
                                <span>Rutinas compartidas</span>
                            </li>
                            <li class="flex items-center">
                                <i data-lucide="award" class="w-5 h-5 text-white mr-2"></i>
                                <span>Estadísticas avanzadas</span>
                            </li>
                        </ul>
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
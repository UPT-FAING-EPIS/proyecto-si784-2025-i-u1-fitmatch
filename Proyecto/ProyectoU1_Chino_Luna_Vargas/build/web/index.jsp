<%-- 
    Document   : index
    Created on : 5 feb 2025, 12:15:55
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GymMatch - Tu compañero ideal de gimnasio</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div class="w-full">
        <!-- Hero Section -->
        <div class="min-h-screen relative overflow-hidden bg-gradient-to-b from-blue-50 to-white">
            <div class="max-w-7xl mx-auto px-4 pt-32 pb-16">
                <div class="text-center mb-16 space-y-4">
                    <h1 class="text-6xl md:text-7xl font-bold mb-6" style="background: linear-gradient(to right, #2563eb, #60a5fa); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                        FitMatch
                    </h1>
                    <p class="text-3xl md:text-4xl font-semibold text-gray-900 mb-4">
                        Tu compañero ideal de gimnasio<br>está a un match de distancia.
                    </p>
                    <p class="text-xl text-gray-600 max-w-3xl mx-auto">
                        Únete a la comunidad fitness más grande de Perú. Encuentra personas que comparten tu pasión por el entrenamiento y alcanza tus objetivos juntos.
                    </p>
                </div>

                <div class="flex justify-center mb-16">
                    <div class="relative w-[380px] h-[580px] bg-white rounded-[2.5rem] shadow-2xl hover:shadow-3xl transition-all transform hover:scale-105">
                        <img
                            src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b"
                            alt="Profile"
                            class="w-full h-[480px] object-cover rounded-t-[2.5rem]"
                        />
                        <div class="absolute inset-0 rounded-t-[2.5rem] bg-gradient-to-b from-transparent via-transparent to-black/50"></div>
                        <div class="absolute bottom-24 left-0 right-0 p-4">
                            <h3 class="text-2xl font-bold text-white">María, 25</h3>
                            <p class="text-gray-200">Entrenadora personal | Crossfit lover 🏋️‍♀️</p>
                        </div>
                        <div class="absolute bottom-6 left-0 right-0 flex justify-center space-x-6">
                            <button class="bg-white/90 backdrop-blur-sm p-4 rounded-full shadow-lg hover:scale-110 transition-all">
                                <i data-lucide="x" class="w-8 h-8 text-red-500"></i>
                            </button>
                            <button class="bg-white/90 backdrop-blur-sm p-4 rounded-full shadow-lg hover:scale-110 transition-all">
                                <i data-lucide="message-circle" class="w-8 h-8 text-blue-500"></i>
                            </button>
                            <button class="bg-white/90 backdrop-blur-sm p-4 rounded-full shadow-lg hover:scale-110 transition-all">
                                <i data-lucide="heart" class="w-8 h-8 text-green-500"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Section -->
            <div class="bg-blue-600 text-white py-20">
                <div class="max-w-7xl mx-auto px-4">
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
                        <div>
                            <div class="text-4xl font-bold mb-2">500K+</div>
                            <div class="text-blue-100">Usuarios activos</div>
                        </div>
                        <div>
                            <div class="text-4xl font-bold mb-2">1M+</div>
                            <div class="text-blue-100">Matches realizados</div>
                        </div>
                        <div>
                            <div class="text-4xl font-bold mb-2">4.8</div>
                            <div class="text-blue-100">Valoración media</div>
                        </div>
                        <div>
                            <div class="text-4xl font-bold mb-2">50K+</div>
                            <div class="text-blue-100">Reseñas positivas</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Features Section -->
            <div class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4">
                    <h2 class="text-4xl font-bold text-center mb-16">Una nueva forma de entrenar</h2>
                    <div class="grid md:grid-cols-3 gap-12">
                        <div class="bg-gradient-to-br from-blue-50 to-white p-8 rounded-3xl shadow-lg hover:shadow-xl transition-all hover:-translate-y-1">
                            <div class="bg-blue-600 w-16 h-16 rounded-2xl flex items-center justify-center mx-auto mb-6">
                                <i data-lucide="dumbbell" class="w-8 h-8 text-white"></i>
                            </div>
                            <h3 class="text-xl font-semibold mb-4">Objetivos Compartidos</h3>
                            <p class="text-gray-600">Encuentra personas con tus mismas metas fitness y motívense mutuamente para alcanzarlas.</p>
                        </div>
                        <div class="bg-gradient-to-br from-blue-50 to-white p-8 rounded-3xl shadow-lg hover:shadow-xl transition-all hover:-translate-y-1">
                            <div class="bg-blue-600 w-16 h-16 rounded-2xl flex items-center justify-center mx-auto mb-6">
                                <i data-lucide="users" class="w-8 h-8 text-white"></i>
                            </div>
                            <h3 class="text-xl font-semibold mb-4">Comunidad Elite</h3>
                            <p class="text-gray-600">Únete a una comunidad verificada de entusiastas del fitness y profesionales del deporte.</p>
                        </div>
                        <div class="bg-gradient-to-br from-blue-50 to-white p-8 rounded-3xl shadow-lg hover:shadow-xl transition-all hover:-translate-y-1">
                            <div class="bg-blue-600 w-16 h-16 rounded-2xl flex items-center justify-center mx-auto mb-6">
                                <i data-lucide="trophy" class="w-8 h-8 text-white"></i>
                            </div>
                            <h3 class="text-xl font-semibold mb-4">Progreso Real</h3>
                            <p class="text-gray-600">Comparte tus logros y celebra los éxitos de tu compañero de entrenamiento.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- CTA Section -->
            <div class="bg-gradient-to-r from-blue-600 to-blue-400 text-white py-20">
                <div class="max-w-7xl mx-auto px-4 text-center">
                    <h2 class="text-4xl font-bold mb-8">Comienza tu viaje fitness hoy</h2>
                    <p class="text-xl mb-8 text-blue-100">Descarga GymMatch y encuentra tu compañero ideal de entrenamiento</p>
                    <div class="flex flex-col sm:flex-row justify-center gap-4">
                        <button class="bg-white text-blue-600 px-8 py-4 rounded-xl font-semibold hover:bg-blue-50 transition-colors">
                            Descargar Ahora
                        </button>
                        <button class="bg-blue-500 text-white px-8 py-4 rounded-xl font-semibold hover:bg-blue-400 transition-colors">
                            Saber Más
                        </button>
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
<%-- 
    Document   : create-post
    Created on : 10 feb 2025, 11:26:52 p.m.
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Clases.SqlConection"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
    <title>FitMatch - Crear Publicación</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        .drag-area {
            border: 2px dashed #ccc;
            transition: all 0.3s ease;
        }
        .drag-area.dragover {
            border-color: #3b82f6;
            background-color: rgba(59, 130, 246, 0.1);
        }
    </style>
</head>
<body class="min-h-screen bg-gray-50">
    <%
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
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
                    <a href="feed.jsp" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="layout-grid" class="h-6 w-6"></i>
                        <span>Feed</span>
                    </a>
                    <a href="create-post.jsp" class="flex items-center space-x-3 text-blue-600 p-2 rounded-lg bg-blue-50">
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
        <main class="ml-64 flex-1 p-6 flex items-center justify-center">
            <div class="max-w-2xl w-full">
                <!-- Step 1: Select Image -->
                <div id="step1" class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="p-4 border-b border-gray-200">
                        <h2 class="text-xl font-semibold text-center">Crea una nueva publicación</h2>
                    </div>
                    
                    <div class="p-6">
                        <form id="uploadForm" class="space-y-4">
                            <div class="drag-area flex flex-col items-center justify-center h-96 rounded-lg cursor-pointer">
                                <div id="preview" class="hidden w-full h-full">
                                    <img id="imagePreview" class="w-full h-full object-contain" alt="Preview">
                                </div>
                                <div id="placeholder" class="flex flex-col items-center justify-center space-y-4">
                                    <div class="flex items-center space-x-2">
                                        <i data-lucide="image" class="h-12 w-12 text-gray-400"></i>
                                        <i data-lucide="video" class="h-12 w-12 text-gray-400"></i>
                                    </div>
                                    <p class="text-lg text-gray-600">Arrastra las fotos y los videos aquí</p>
                                    <label class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 cursor-pointer">
                                        Seleccionar de la computadora
                                        <input type="file" id="fileInput" accept="image/*" class="hidden">
                                    </label>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Step 2: Add Description -->
                <div id="step2" class="hidden bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="p-4 border-b border-gray-200 flex justify-between items-center">
                        <button id="backButton" class="text-blue-600 hover:text-blue-700">
                            <i data-lucide="arrow-left" class="h-6 w-6"></i>
                        </button>
                        <h2 class="text-xl font-semibold">Crear nueva publicación</h2>
                        <button id="shareButton" class="text-blue-600 hover:text-blue-700 font-semibold">
                            Compartir
                        </button>
                    </div>
                    
                    <div class="flex">
                        <div class="w-2/3 border-r border-gray-200">
                            <div class="aspect-w-1 aspect-h-1">
                                <img id="finalPreview" class="w-full h-full object-contain" alt="Final preview">
                            </div>
                        </div>
                        
                        <div class="w-1/3 p-4">
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
                                <div class="w-8 h-8 rounded-full overflow-hidden">
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
                                <span class="font-medium"><%= userRs.getString("usuario") %></span>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println("Error: " + e.getMessage());
                                    }
                                %>
                            </div>
                            
                            <textarea
                                id="caption"
                                placeholder="Escribe una descripción..."
                                class="w-full h-32 p-2 border border-gray-200 rounded-lg resize-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            ></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <form id="submitForm" action="CreatePost" method="POST" enctype="multipart/form-data" class="hidden">
        <input type="file" name="image" id="hiddenFileInput">
        <input type="text" name="content" id="hiddenContent">
    </form>

    <script>
        // Initialize Lucide icons
        lucide.createIcons();

        // DOM Elements
        const step1 = document.getElementById('step1');
        const step2 = document.getElementById('step2');
        const dragArea = document.querySelector('.drag-area');
        const fileInput = document.getElementById('fileInput');
        const preview = document.getElementById('preview');
        const placeholder = document.getElementById('placeholder');
        const imagePreview = document.getElementById('imagePreview');
        const finalPreview = document.getElementById('finalPreview');
        const backButton = document.getElementById('backButton');
        const shareButton = document.getElementById('shareButton');
        const caption = document.getElementById('caption');
        const submitForm = document.getElementById('submitForm');
        const hiddenFileInput = document.getElementById('hiddenFileInput');
        const hiddenContent = document.getElementById('hiddenContent');

        let selectedFile = null;

        // Drag and drop handlers
        dragArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            dragArea.classList.add('dragover');
        });

        dragArea.addEventListener('dragleave', () => {
            dragArea.classList.remove('dragover');
        });

        dragArea.addEventListener('drop', (e) => {
            e.preventDefault();
            dragArea.classList.remove('dragover');
            const file = e.dataTransfer.files[0];
            if (file && file.type.startsWith('image/')) {
                handleFile(file);
            }
        });

        // File input handler
        fileInput.addEventListener('change', (e) => {
            const file = e.target.files[0];
            if (file) {
                handleFile(file);
            }
        });

        // Handle selected file
        function handleFile(file) {
            selectedFile = file;
            const reader = new FileReader();
            reader.onload = (e) => {
                imagePreview.src = e.target.result;
                finalPreview.src = e.target.result;
                preview.classList.remove('hidden');
                placeholder.classList.add('hidden');
                // Go to step 2
                step1.classList.add('hidden');
                step2.classList.remove('hidden');
            };
            reader.readAsDataURL(file);
        }

        // Back button handler
        backButton.addEventListener('click', () => {
            step2.classList.add('hidden');
            step1.classList.remove('hidden');
            preview.classList.add('hidden');
            placeholder.classList.remove('hidden');
            selectedFile = null;
            fileInput.value = '';
            caption.value = '';
        });

        // Share button handler
        shareButton.addEventListener('click', () => {
            if (selectedFile) {
                const dataTransfer = new DataTransfer();
                dataTransfer.items.add(selectedFile);
                hiddenFileInput.files = dataTransfer.files;
                hiddenContent.value = caption.value;
                submitForm.submit();
            }
        });
    </script>
</body>
</html>

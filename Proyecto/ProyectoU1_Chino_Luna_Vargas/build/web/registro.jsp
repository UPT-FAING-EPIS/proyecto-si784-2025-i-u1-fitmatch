<%-- 
    Document   : registro
    Created on : 9 feb 2025, 11:14:29 p.m.
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registro</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    </head>
    <body class="bg-gray-50">
        <div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
            <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-xl shadow-md">
                <div>
                    <h2 class="text-center text-3xl font-bold text-blue-600">
                        Crear Cuenta
                    </h2>
                    <p class="mt-2 text-center text-sm text-gray-600">
                        ¿Ya tienes una cuenta?
                        <a href="Login.jsp" class="font-medium text-blue-600 hover:text-blue-500">
                            Inicia sesión aquí
                        </a>
                    </p>
                </div>
                
                <%
                
                if(session.getAttribute("noti") != null){
                    
                        if(session.getAttribute("estilo").equals("Correcto")){%>
                        
                            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg">
                        
                        <%}else{%>
                            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg">
                        <%}%>
                    
                        <%=session.getAttribute("noti") %>
                        <%session.setAttribute("noti",null);%>
                        <%session.setAttribute("estilo",null);%>
                    </div>
                <%}%>
                
                <form id="registroForm" class="bg-white p-6 rounded-lg shadow-md w-96 space-y-4" action="RegistrarUsuario_Servlet" method="POST">
                    <div class="rounded-md shadow-sm space-y-4">
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label for="nombre" class="block text-sm font-medium text-gray-700">Nombre</label>
                                <input id="nombre" name="nombre" type="text" oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" placeholder="Juan" required>
                            </div>
                            <div>
                                <label for="apellido" class="block text-sm font-medium text-gray-700">Apellido</label>
                                <input id="apellido" name="apellido" type="text" oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" placeholder="Pérez" required>
                            </div>
                        </div>
                        <div>
                            <label for="usuario" class="block text-sm font-medium text-gray-700">Usuario</label>
                            <input id="usuario" name="usuario" type="text" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" placeholder="Ingresa un Usuario">
                        </div>
                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700">Correo Electrónico</label>
                            <input id="email" name="email" type="email" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" placeholder="tucorreo@ejemplo.com">
                        </div>
                        <div>
                            <label for="password" class="block text-sm font-medium text-gray-700">Contraseña</label>
                            <input id="password" name="password" type="password" required class="mt-1 w-full px-4 py-2 border rounded-lg" placeholder="••••••••">
                        </div>
                        <div>
                            <label for="confirm_password" class="block text-sm font-medium text-gray-700">Confirmar Contraseña</label>
                            <input id="confirm_password" name="confirm_password" type="password" required class="mt-1 w-full px-4 py-2 border rounded-lg" placeholder="••••••••">
                            <p id="passwordError" class="text-red-500 text-sm hidden">Las contraseñas no coinciden.</p>
                        </div>
                    </div>
                    <!--
                    <div class="flex items-center">
                        <input id="terms" name="terms" type="checkbox" required class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                        <label for="terms" class="ml-2 block text-sm text-gray-900">
                            Acepto los <a href="#" class="text-blue-600 hover:text-blue-500">términos y condiciones</a>
                        </label>
                    </div>-->
                    <div>
                        <button type="button" id="openModalBtn" class="w-full py-2 bg-blue-600 text-white rounded-lg disabled:opacity-50" >Siguiente Paso</button>
                    </div>

                    <!-- Modal de PIN -->
                    <div id="pinModal" class="fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center hidden">
                        <div class="bg-white p-6 rounded-lg shadow-lg w-96 text-center">
                            <h2 class="text-lg font-semibold">Introduce tu PIN</h2>
                            <p class="text-sm text-gray-600 mt-2">
                                Este PIN será tu clave cifrada. Nunca lo compartas con nadie y nadie te lo pedirá. Si lo olvidas, necesitarás atención al cliente.
                            </p>
                            <div class="mt-4 flex justify-center space-x-2">
                                <input type="text" maxlength="1" class="pin-input w-10 h-10 text-center border rounded-lg text-xl" oninput="this.value = this.value.replace(/[^0-9]/g, '')" autofocus>
                                <input type="text" maxlength="1" class="pin-input w-10 h-10 text-center border rounded-lg text-xl" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                                <input type="text" maxlength="1" class="pin-input w-10 h-10 text-center border rounded-lg text-xl" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                                <input type="text" maxlength="1" class="pin-input w-10 h-10 text-center border rounded-lg text-xl" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                                <input type="text" maxlength="1" class="pin-input w-10 h-10 text-center border rounded-lg text-xl" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                                <input type="text" maxlength="1" class="pin-input w-10 h-10 text-center border rounded-lg text-xl" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                                <input type="hidden" id="pin" name="pin">
                            </div>
                            <p id="pinError" class="text-red-500 text-sm mt-2 hidden">Completa todos los campos.</p>
                            <div class="mt-4 flex justify-center space-x-2">
                                <button id="closeModalBtn" class="px-4 py-2 bg-gray-300 rounded-lg">Cancelar</button>
                                <button id="confirmPinBtn" class="px-4 py-2 bg-blue-600 text-white rounded-lg">Confirmar</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <script>
            const form = document.getElementById("registroForm");
            const password = document.getElementById("password");
            const confirmPassword = document.getElementById("confirm_password");
            const openModalBtn = document.getElementById("openModalBtn");
            const pinInputs = document.querySelectorAll(".pin-input");

            openModalBtn.addEventListener("click", () => {
                let valid = true;

                document.querySelectorAll(".error-message").forEach(msg => msg.remove());

                // Validar campos requeridos
                form.querySelectorAll("input[required]").forEach(input => {
                    if (input.value.trim() === "") {
                        valid = false;
                        const errorMessage = document.createElement("p");
                        errorMessage.textContent = "Este campo es obligatorio.";
                        errorMessage.classList.add("text-red-500", "text-sm", "error-message");
                        input.parentElement.appendChild(errorMessage);
                    }
                });

                if (password.value !== confirmPassword.value) {
                    valid = false;
                    const errorMessage = document.createElement("p");
                    errorMessage.textContent = "Las contraseñas no coinciden.";
                    errorMessage.classList.add("text-red-500", "text-sm", "error-message");
                    confirmPassword.parentElement.appendChild(errorMessage);
                }

                if (valid) {
                    document.getElementById("pinModal").classList.remove("hidden");
                    pinInputs[0].focus();
                }
            });

            pinInputs.forEach((input, index) => {
                input.addEventListener("input", () => {
                    if (input.value.length === 1 && index < pinInputs.length - 1) {
                        pinInputs[index + 1].focus();
                    }
                });
            });

            // Validar PIN y enviar formulario
            document.getElementById("confirmPinBtn").addEventListener("click", () => {
                const pinCompleted = [...pinInputs].every(input => input.value.length === 1);
                document.getElementById("pinError").classList.toggle("hidden", pinCompleted);
                if (pinCompleted) {
                    document.getElementById("pinModal").classList.add("hidden");
                    form.submit();
                }
            });

            // cerrar modal
            document.getElementById("closeModalBtn").addEventListener("click", () => {
                document.getElementById("pinModal").classList.add("hidden");
            });
        </script>

        <script>
            form.addEventListener("input", () => {
                const passwordsMatch = password.value === confirmPassword.value;
                document.getElementById("passwordError").classList.toggle("hidden", passwordsMatch);
            });

            document.getElementById("confirmPinBtn").addEventListener("click", function () {
                let pinInputs = document.querySelectorAll(".pin-input");
                let pinValue = "";
                pinInputs.forEach(input => pinValue += input.value);

                if (pinValue.length === 6) {
                    document.getElementById("pin").value = pinValue;
                    document.getElementById("registroForm").submit(); // Envía el formulario
                } else {
                    document.getElementById("pinError").classList.remove("hidden");
                }
            });

        </script>
    </body>
</html>
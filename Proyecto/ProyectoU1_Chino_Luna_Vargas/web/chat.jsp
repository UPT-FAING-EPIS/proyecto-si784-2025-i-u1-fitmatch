<%-- 
    Document   : chat
    Created on : 11 feb. 2025, 10:31:38 p. m.
    Author     : Sio
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chat</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 h-screen flex flex-col">

        <% String idContacto = request.getParameter("id");%>
        <div class="bg-blue-600 text-white p-4 text-lg font-bold">
            Chat con Contacto <%= idContacto%>
        </div>
        <!-- Contenedor de mensajes con scroll -->
        <div id="chatBox" class="flex-1 p-4 overflow-y-auto max-h-[70vh] flex flex-col space-y-1">
            <!-- Mensajes del receptor (izquierda) -->
            <div class="bg-white text-black px-2 py-1 rounded shadow-md self-start break-words max-w-[75%]">
                Hola, ¿cómo estás?
            </div>
            <div class="bg-white text-black px-2 py-1 rounded shadow-md self-start break-words max-w-[75%]">
                Hola, ¿cómo estás?
            </div>

            <!-- Mensajes del emisor (derecha) -->
            <div class="bg-gray-300 text-black px-2 py-1 rounded shadow-md self-end break-words max-w-[75%]">
                ¡Bien! ¿Y tú?
            </div>
            <div class="bg-gray-300 text-black px-2 py-1 rounded shadow-md self-end break-words max-w-[75%]">
                ¡Bien! ¿Y tú? gaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
            </div>
            <div class="bg-gray-300 text-black px-2 py-1 rounded shadow-md self-end break-words max-w-[75%]">
                ¡Bien! ¿Y tú? gaaagaaaaaaaaaaaaaaaaaaaaaaaaaagaaaaaaaaaaaaaaaaaaaaaaaaaagaaaaaaaaaaaaaaaaaaaaaaaaaagaaaaaaaaaaaaaaaaaaaaaaaaaagaaaaaaaaaaaaaaaaaaaaaaaaaagaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
            </div>
        </div>

        <!-- Barra de entrada de mensajes -->
        <div class="bg-white p-4 border-t flex items-center">
            <input type="text" id="message" class="flex-1 p-2 border rounded mr-2" placeholder="Escribe un mensaje...">
            <button class="bg-blue-500 text-white px-4 py-2 rounded" onclick="sendMessage()">Enviar Mensaje</button>
        </div>

        <script>
            document.getElementById('chatBox').scrollTop = document.getElementById('chatBox').scrollHeight;
        </script>
    </body>
</html>

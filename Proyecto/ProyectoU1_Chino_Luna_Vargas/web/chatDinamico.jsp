<%-- 
    Document   : chatDinamico
    Created on : 8 feb. 2025, 12:37:42 a. m.
    Author     : Sio
--%>
<%@ page import="java.sql.*" %>
<%@page import="Clases.ClsNMensaje"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Chat</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            let params = new URLSearchParams(window.location.search);
            let chatId = params.get("chatId");
            let userId = params.get("userId");
            let userIdReceptor = params.get("userIdReceptor");

            //let ws = new WebSocket("ws://" + window.location.host + "/ProyectoU3_Vargas_Loyola_Castillo_Colque_Espinoza/chat/" + chatId + "/" + userId);
            let ws = new WebSocket("wss://" + window.location.host + "/chat/" + chatId + "/" + userId);

            console.log(window.location);


            const clavePublicaEmisor = "${sessionScope.clavePublica}";
            const clavePublicaReceptor = "${sessionScope.clavePublicaReceptor}";
            console.log(clavePublicaEmisor);
            console.log(clavePublicaReceptor);

            async function generateSymmetricKey() {
                return await window.crypto.subtle.generateKey(
                        {
                            name: "AES-CBC",
                            length: 256
                        },
                        true, // exportable
                        ["encrypt"]
                        );
            }

            async function encryptSymmetricKey(symmetricKey, publicKeyStr) {
                // Convertir la clave pública de base64 a un objeto CryptoKey
                const publicKeyBuffer = new Uint8Array(atob(publicKeyStr).split('').map(char => char.charCodeAt(0)));
                const publicKey = await window.crypto.subtle.importKey(
                        "spki",
                        publicKeyBuffer,
                        {
                            name: "RSA-OAEP",
                            hash: "SHA-256"
                        },
                        false,
                        ["encrypt"]
                        );

                // Exportar la clave simétrica como bytes
                const rawSymmetricKey = await window.crypto.subtle.exportKey("raw", symmetricKey);

                // Cifrar la clave simétrica con RSA
                const encryptedSymmetricKey = await window.crypto.subtle.encrypt(
                        {
                            name: "RSA-OAEP"
                        },
                        publicKey,
                        rawSymmetricKey
                        );

                return encryptedSymmetricKey;
            }

            async function encryptMessage(message, symmetricKey) {
                // Generar IV aleatorio
                const iv = window.crypto.getRandomValues(new Uint8Array(16));

                // Cifrar el mensaje
                const encodedMessage = new TextEncoder().encode(message);
                const encryptedMessage = await window.crypto.subtle.encrypt(
                        {
                            name: "AES-CBC",
                            iv: iv
                        },
                        symmetricKey,
                        encodedMessage
                        );

                return {
                    encryptedMessage,
                    iv
                };
            }

            ws.onmessage = function (event) {
                let chatBox = document.getElementById("chatBox");
                let formattedMessage = event.data.split(": "); 
                let senderId = formattedMessage[0]; 
                let messageText = formattedMessage[1]; 
                console.log(messageText);
                let messageClass = senderId === userId ? "self-end bg-blue-500 text-white" : "self-start bg-gray-300 text-black";
                console.log(messageClass);

                let newMessage = "<div class='px-3 py-2 rounded shadow-md " + messageClass + " max-w-xs break-words'>" + messageText + "</div>";

                console.log(newMessage);

                chatBox.innerHTML += newMessage;

                chatBox.scrollTop = chatBox.scrollHeight;
            };

            async function sendMessage() {
                let messageInput = document.getElementById("message");
                let message = messageInput.value;
                let chatBox = document.getElementById("chatBox");

                // Mostrar el mensaje como "Enviando"
                let messageElement = document.createElement("div");
                messageElement.textContent = "Enviando: " + message;
                chatBox.appendChild(messageElement);


                // Generar clave simétrica
                const symmetricKey = await generateSymmetricKey();

                // Cifrar el mensaje y obtener IV
                const {encryptedMessage, iv} = await encryptMessage(message, symmetricKey);

                // Cifrar la clave simétrica con ambas claves públicas
                const encryptedSymKeyEmisor = await encryptSymmetricKey(symmetricKey, clavePublicaEmisor);
                const encryptedSymKeyReceptor = await encryptSymmetricKey(symmetricKey, clavePublicaReceptor);

                // Convertir todo a base64 para enviar
                const mensajeCifrado = btoa(String.fromCharCode(...new Uint8Array(encryptedMessage)));
                const claveSimetricaEmisor = btoa(String.fromCharCode(...new Uint8Array(encryptedSymKeyEmisor)));
                const claveSimetricaReceptor = btoa(String.fromCharCode(...new Uint8Array(encryptedSymKeyReceptor)));
                const ivBase64 = btoa(String.fromCharCode(...iv));

                fetch('EnviarMensaje_Sevlet', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: new URLSearchParams({
                        idEmisor: userId,
                        idReceptor: userIdReceptor,
                        mensajeCifrado: mensajeCifrado,
                        claveSimetricaEmisor: claveSimetricaEmisor,
                        claveSimetricaReceptor: claveSimetricaReceptor,
                        iv: ivBase64
                    })
                }).then(response => {
                    return response.text();
                }).then(data => {

                    if (data === "Enviado") {
                        ws.send(message);
                        messageElement.textContent = '';
                    } else {
                        messageElement.textContent = message + " " + data;
                    }

                }).catch(error => {
                    console.error('Error de conexión con el servlet:', error);
                    messageElement.textContent = 'Error de envío: ' + message;
                });

                messageInput.value = '';

            }
        </script>
    </head>
    <body>
        <div class="bg-blue-600 text-white p-4 text-lg font-bold">
            <!--Chat: <%= request.getParameter("chatId")%>-->
            
            <% 
                Blob imageBlob = (Blob) session.getAttribute("FotoChat");
                                String imageBase64 = "";
                                if (imageBlob != null) {
                                    byte[] imageBytes = imageBlob.getBytes(1, (int)imageBlob.length());
                                    imageBase64 = java.util.Base64.getEncoder().encodeToString(imageBytes);
                                }

                    if (imageBase64.isEmpty()) { %>
                                    <img src="https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800&auto=format&fit=crop"
                                         alt="Profile"
                                         class="w-10 h-10 rounded-full object-cover mr-3">
                                <% } else { %>
                                    <img src="data:image/jpeg;base64,<%= imageBase64 %>"
                                         alt="Profile"
                                         class="w-10 h-10 rounded-full object-cover mr-3">
                                <% } %>
            <%= session.getAttribute("UsuarioChat")%>
            <br>
            Experiencia: <%= session.getAttribute("ExperienciaChat")%>
            <!-- Botón de Reporte -->
            <button onclick="mostrarFormularioReporte()" 
                    class="absolute top-2 right-2 bg-red-500 text-white p-2 rounded-full">
                🚩
            </button>
        </div>

        <!-- Contenedor de mensajes con scroll -->
        <div id="chatBox" class="flex-1 p-4 overflow-y-auto max-h-[70vh] flex flex-col space-y-1">
        </div>


        <!-- Modal para Reporte -->
        <div id="modalReporte" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
            <div class="bg-white p-6 rounded-lg shadow-lg w-96">
                <h2 class="text-lg font-bold mb-4">Reportar Mensaje</h2>
                <label>Motivo:</label>
                <select id="motivoReporte" class="w-full p-2 border rounded mb-3">
                    <option value="">Seleccionar</option>
                    <option value="Spam">Spam</option>
                    <option value="Acoso">Acoso</option>
                    <option value="Extorsion">Extorsión</option>
                    <option value="Otros">Otros</option>
                </select>
                <label>Subir Evidencia (1-2 fotos):</label>
                <input type="file" id="evidencia" accept="image/*" multiple class="w-full p-2 border rounded mb-3">
                <button onclick="enviarReporte()" class="bg-blue-600 text-white p-2 rounded w-full">Enviar</button>
                <button onclick="cerrarModalReporte()" class="mt-2 bg-gray-400 text-white p-2 rounded w-full">Cancelar</button>
            </div>
        </div>

        <script>
        function mostrarFormularioReporte() {
            document.getElementById('modalReporte').classList.remove('hidden');
        }

        function cerrarModalReporte() {
            document.getElementById('modalReporte').classList.add('hidden');
        }

        async function enviarReporte() {
            const motivo = document.getElementById('motivoReporte').value;
            const evidencia = document.getElementById('evidencia').files;

            if (!motivo) {
                alert('Debe seleccionar un motivo.');
                return;
            }
            if (evidencia.length < 1 || evidencia.length > 2) {
                alert('Debe subir entre 1 y 2 fotos.');
                return;
            }

            const formData = new FormData();
            formData.append('motivo', motivo);
            formData.append('idUsuario', userId);
            formData.append('idReportado', userIdReceptor);

            for (let i = 0; i < evidencia.length; i++) {
                formData.append('evidencia', evidencia[i]);
            }

            try {
                const response = await fetch('reporteChat_Servlet', {
                    method: 'POST',
                    body: formData
                });
                if (response.ok) {
                    alert('Reporte enviado exitosamente.');
                    cerrarModalReporte();
                } else {
                    alert('Error al enviar reporte.');
                }
            } catch (error) {
                alert('Error de conexión.');
            }
        }
        </script>
        
        
        <!-- Barra de entrada de mensajes -->
        <div class="bg-white p-4 border-t flex items-center">

            <input type="text" id="message" class="flex-1 p-2 border rounded mr-2" placeholder="Escribe un mensaje...">
            <button class="bg-blue-500 text-white px-4 py-2 rounded" onclick="sendMessage()">Enviar Mensaje</button>

        </div>

        <script>
            document.getElementById('chatBox').scrollTop = document.getElementById('chatBox').scrollHeight;
        </script>
        <!--<h4>Receptor:${sessionScope.clavePublicaReceptor}</h4>

        <h3>Clave Publica Emisor:${sessionScope.clavePublica}</h3>-->
        <script>
            async function decryptMessage(
                    encryptedMessage,
                    encryptedSymmetricKey,
                    iv,
                    privateKeyPEM
                    ) {
                const encryptedData = Uint8Array.from(atob(encryptedMessage), c => c.charCodeAt(0));
                const encryptedKey = Uint8Array.from(atob(encryptedSymmetricKey), c => c.charCodeAt(0));
                const ivArray = Uint8Array.from(atob(iv), c => c.charCodeAt(0));

                const privateKeyBuffer = _pemToBuffer(privateKeyPEM);
                const privateKey = await window.crypto.subtle.importKey(
                        "pkcs8",
                        privateKeyBuffer,
                        {
                            name: "RSA-OAEP",
                            hash: "SHA-256"
                        },
                        false,
                        ["decrypt"]
                        );

                const symmetricKeyBuffer = await window.crypto.subtle.decrypt(
                        {
                            name: "RSA-OAEP"
                        },
                        privateKey,
                        encryptedKey
                        );

                const symmetricKey = await window.crypto.subtle.importKey(
                        "raw",
                        symmetricKeyBuffer,
                        {
                            name: "AES-CBC",
                            length: 256
                        },
                        false,
                        ["decrypt"]
                        );

                const decryptedBuffer = await window.crypto.subtle.decrypt(
                        {
                            name: "AES-CBC",
                            iv: ivArray
                        },
                        symmetricKey,
                        encryptedData
                        );

                return new TextDecoder().decode(decryptedBuffer);
            }

            function _pemToBuffer(pem) {
                const b64 = pem
                        .replace('-----BEGIN PRIVATE KEY-----', '')
                        .replace('-----END PRIVATE KEY-----', '')
                        .replace(/\s/g, '');
                return Uint8Array.from(atob(b64), c => c.charCodeAt(0));
            }
        </script>
        <script>
            var privateKeyPEM = '${sessionScope.clavePrivadaDesencriptada}';
            var mensajes = [];
            <%
                ClsNMensaje ObjNMensaje = new ClsNMensaje();
                ResultSet rs = ObjNMensaje.mensajesConversacion(request.getParameter("userId"), request.getParameter("userIdReceptor"));

                while (rs != null && rs.next()) {
                    String encryptedSymKey;
                    if (rs.getInt(2) == (Integer) session.getAttribute("idUsuario")) {//esto si esq el mensaje es mio 
                        encryptedSymKey = rs.getString("claveSimetricaEmisor");
                    } else {
                        encryptedSymKey = rs.getString("claveSimetricaReceptor");
                    }

                    String encryptedMessage = rs.getString(4);
                    String iv = rs.getString("iv");
            %>

            mensajes.push({
                encryptedMessage: "<%= encryptedMessage%>",
                encryptedSymKey: "<%= encryptedSymKey%>",
                iv: "<%= iv%>",
                emisorId: <%= rs.getInt(2)%> // Agregar el ID del emisor
            });

            <% }%>

        </script>
        <script>
            async function decryptMessages() {
                let chatBox = document.getElementById("chatBox");
                const currentUserId = <%= session.getAttribute("idUsuario")%>; // Obtener el ID del usuario actual

                for (const mensaje of mensajes) {
                    try {
                        let decryptedMessage = await decryptMessage(
                                mensaje.encryptedMessage,
                                mensaje.encryptedSymKey,
                                mensaje.iv,
                                privateKeyPEM
                                );
                        // Crear un div para el mensaje
                        let mensajeElemento = document.createElement("div");

                        // Determinar si el mensaje es del emisor o receptor
                        const isEmisor = mensaje.emisorId === currentUserId;

                        // Aplicar las clases correspondientes
                        if (isEmisor) {
                            mensajeElemento.className = "bg-gray-300 text-black px-2 py-1 rounded shadow-md self-end break-words max-w-[75%]";
                        } else {
                            mensajeElemento.className = "bg-white text-black px-2 py-1 rounded shadow-md self-start break-words max-w-[75%]";
                        }

                        mensajeElemento.textContent = decryptedMessage;
                        chatBox.appendChild(mensajeElemento);
                        chatBox.scrollTop = chatBox.scrollHeight;
                    } catch (error) {
                        console.error("Error al descifrar mensaje:", error);
                    }
                }
            }

            document.addEventListener("DOMContentLoaded", decryptMessages);
        </script>
    </body>
</html>
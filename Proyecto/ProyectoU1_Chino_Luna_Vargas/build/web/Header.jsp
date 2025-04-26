<%-- 
    Document   : Header
    Created on : 5 feb 2025, 12:14:48
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>FitMatch Header</title>
 
    <style>
        body, html {
            margin: 0;
            padding: 0;
        }
        .bg-fitmatch-blue {
            background-color: #1D4ED8;
        }
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }
        .header-links {
            display: flex;
            gap: 15px;
            color: white;
            font-size: 0.875rem;
        }
        .header-links a {
            color: white;
            text-decoration: none;
        }
        .header-links a:hover {
            opacity: 0.7;
        }
        .login-btn {
            background-color: black;
            color: #1D4ED8;
            padding: 4px 12px;
            border-radius: 4px;
            text-decoration: none;
        }
    </style>
    </head>
    <body>
        <header class="bg-fitmatch-blue">
        <div class="header-container">
            <div class="logo-container">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="white" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 2L2 7L12 12L22 7L12 2Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M2 17L12 22L22 17" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M2 12L12 17L22 12" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <span style="color: white; font-weight: bold; font-size: 18px;">FitMatch</span>
            </div>
            <div class="header-links">
                <a href="index.jsp">Home</a>
                <a href="About.jsp">Sobre Nosotros</a>
                <a href="Soporte.jsp">Soporte</a>
                <a href="MasInformacion.jsp">Más información</a>
                <a href="Dowload.jsp">Descarga</a>
                <a href="Login.jsp" class="login-btn">Iniciar Sesion</a>
            </div>
        </div>
    </header>
    </body>
</html>

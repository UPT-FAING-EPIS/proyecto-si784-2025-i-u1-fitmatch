<%-- 
    Document   : GimnasioCercanos
    Created on : 12 feb 2025, 4:56:08 p.m.
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>Gimnasios Cercanos</title>
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.css" />
    <style>
        <!-- FALTA AGREGAR AL HEADER -->
        #map {
            height: 500px;
            width: 100%;
            border-radius: 12px;
        }
        .gym-info {
            padding: 10px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 10px;
        }
        .distance-badge {
            background: #3b82f6;
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.875rem;
        }
        .gym-list {
            max-height: 400px;
            overflow-y: auto;
            padding: 10px;
        }
    </style>
</head>
<body>
    <div class="container mx-auto p-4">
        <div class="bg-white rounded-lg shadow-lg p-6">
            <h2 class="text-2xl font-bold mb-4">Gimnasios Cercanos</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- Mapa -->
                <div class="md:col-span-2">
                    <div id="map"></div>
                </div>
                <!-- Lista de gimnasios -->
                <div class="gym-list">
                    <div id="gymList"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Leaflet JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.js"></script>
    <script>
        // Función para obtener la ubicación del usuario
        async function getUserLocation() {
            return new Promise((resolve, reject) => {
                if (!navigator.geolocation) {
                    reject('Geolocalización no soportada');
                }

                navigator.geolocation.getCurrentPosition(resolve, reject);
            });
        }

        // Función para calcular la distancia entre dos puntos
        function calculateDistance(lat1, lon1, lat2, lon2) {
            const R = 6371; // Radio de la tierra en km
            const dLat = (lat2 - lat1) * Math.PI / 180;
            const dLon = (lon2 - lon1) * Math.PI / 180;
            const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                    Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
                    Math.sin(dLon/2) * Math.sin(dLon/2);
            const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
            return R * c;
        }

        // Función para buscar gimnasios cercanos usando Overpass API
        async function findNearbyGyms(lat, lon) {
            const radius = 5000; // 5km radio
            const query = `
                [out:json][timeout:25];
                (
                    node["leisure"="fitness_centre"](around:${radius},${lat},${lon});
                    way["leisure"="fitness_centre"](around:${radius},${lat},${lon});
                    relation["leisure"="fitness_centre"](around:${radius},${lat},${lon});
                );
                out body;
                >;
                out skel qt;
            `;

            const response = await fetch('https://overpass-api.de/api/interpreter', {
                method: 'POST',
                body: query
            });

            const data = await response.json();
            return data.elements;
        }

        // Inicializar el mapa
        async function initMap() {
            try {
                // Obtener ubicación del usuario
                const position = await getUserLocation();
                const { latitude, longitude } = position.coords;

                // Crear mapa
                const map = L.map('map').setView([latitude, longitude], 13);
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '© OpenStreetMap contributors'
                }).addTo(map);

                // Marcador del usuario
                L.marker([latitude, longitude])
                    .bindPopup('Tu ubicación')
                    .addTo(map);

                // Buscar gimnasios cercanos
                const gyms = await findNearbyGyms(latitude, longitude);
                const gymListElement = document.getElementById('gymList');
                let gymListHTML = '';

                gyms.forEach(gym => {
                    if (gym.type === 'node') {
                        const distance = calculateDistance(latitude, longitude, gym.lat, gym.lon);
                        
                        // Añadir marcador al mapa
                        L.marker([gym.lat, gym.lon])
                            .bindPopup(gym.tags.name || 'Gimnasio')
                            .addTo(map);

                        // Añadir a la lista
                        gymListHTML += `
                            <div class="gym-info">
                                <h3 class="font-bold">${gym.tags.name || 'Gimnasio'}</h3>
                                <p class="text-gray-600">${gym.tags.address || ''}</p>
                                <span class="distance-badge">${distance.toFixed(1)} km</span>
                            </div>
                        `;
                    }
                });

                gymListElement.innerHTML = gymListHTML;

            } catch (error) {
                console.error('Error:', error);
                alert('Error al cargar el mapa: ' + error.message);
            }
        }

        // Iniciar la aplicación
        initMap();
    </script>
</body>

<%-- 
    Document   : workout
    Created on : 11 feb 2025, 10:39:43 p.m.
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
<!-- MODIFICADO -->
<html>
<head>
    <title>FitMatch - Entrenamiento</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="min-h-screen bg-gray-50">
    <%
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
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
                    <a href="create-post.jsp" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="plus-circle" class="h-6 w-6"></i>
                        <span>Crear</span>
                    </a>
                    <a href="profile.jsp" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="settings" class="h-6 w-6"></i>
                        <span>Configuración</span>
                    </a>
                    <a href="workout.jsp" class="flex items-center space-x-3 text-blue-600 p-2 rounded-lg bg-blue-50">
                        <i data-lucide="timer" class="h-6 w-6"></i>
                        <span>Entrenar</span>
                    </a>
                    <a href="logout" class="flex items-center space-x-3 text-gray-600 hover:text-blue-600 p-2 rounded-lg hover:bg-gray-50">
                        <i data-lucide="log-out" class="h-6 w-6"></i>
                        <span>Salir</span>
                    </a>
                </nav>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="ml-64 flex-1 p-6">
            <div class="max-w-4xl mx-auto">
                <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                    <div class="flex justify-between items-center mb-6">
                        <div>
                            <h2 class="text-2xl font-bold text-gray-800">Entrenamiento</h2>
                            <p class="text-gray-600" id="workoutTimer">Tiempo total: 00:00:00</p>
                        </div>
                        <div class="flex items-center space-x-4">
                            <div class="text-center">
                                <p class="text-sm text-gray-600 mb-1">Tiempo de descanso</p>
                                <select id="restTimeSelect" class="rounded-lg border-gray-300 focus:border-blue-500 focus:ring-blue-500">
                                    <option value="60">1 min</option>
                                    <option value="120" selected>2 min</option>
                                    <option value="180">3 min</option>
                                    <option value="240">4 min</option>
                                    <option value="300">5 min</option>
                                </select>
                            </div>
                            <button id="startWorkout" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                                <i data-lucide="play" class="h-5 w-5"></i>
                                <span>Iniciar</span>
                            </button>
                        </div>
                    </div>

                    <div id="restTimer" class="hidden mb-6 p-4 bg-blue-50 rounded-lg">
                        <div class="flex items-center justify-between">
                            <p class="text-lg font-semibold text-blue-800">Tiempo de descanso:</p>
                            <p class="text-2xl font-bold text-blue-800" id="restTimeDisplay">02:00</p>
                        </div>
                    </div>

                    <div class="mb-6">
                        <div class="flex items-center space-x-2">
                            <input type="text" id="exerciseName" placeholder="Nombre del ejercicio" class="flex-1 rounded-lg border-gray-300 focus:border-blue-500 focus:ring-blue-500">
                            <button id="addExercise" class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2">
                                <i data-lucide="plus" class="h-5 w-5"></i>
                                <span>Agregar ejercicio</span>
                            </button>
                        </div>
                    </div>

                    <div id="exercisesList" class="space-y-4">
                        <!-- Exercises will be added here dynamically -->
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Initialize Lucide icons
        lucide.createIcons();

        let workoutStartTime = null;
        let workoutTimer = null;
        let restTimer = null;
        let exercises = [];

       function formatTime(seconds) {
            const hrs = Math.floor(seconds / 3600);
            const mins = Math.floor((seconds % 3600) / 60);
            const secs = seconds % 60;

            // Using concatenation instead of template literals to avoid any potential syntax issues
            return String(hrs).padStart(2, '0') + ':' + 
                   String(mins).padStart(2, '0') + ':' + 
                   String(secs).padStart(2, '0');
        }

        function updateWorkoutTimer() {
            if (!workoutStartTime) return;
            const elapsed = Math.floor((Date.now() - workoutStartTime) / 1000);
            document.getElementById('workoutTimer').textContent = 'Tiempo total: ' + formatTime(elapsed);
        }

        function startRestTimer(setElement) {
            const restTime = parseInt(document.getElementById('restTimeSelect').value);
            let timeLeft = restTime;
            
            document.getElementById('restTimer').classList.remove('hidden');
            
            if (restTimer) clearInterval(restTimer);
            
            restTimer = setInterval(() => {
                timeLeft--;
                document.getElementById('restTimeDisplay').textContent = formatTime(timeLeft);
                
                if (timeLeft <= 0) {
                    clearInterval(restTimer);
                    document.getElementById('restTimer').classList.add('hidden');
                    setElement.classList.remove('animate-pulse');
                }
            }, 1000);
        }

        document.getElementById('startWorkout').addEventListener('click', function() {
            const button = this;
            const icon = button.querySelector('i');
            const text = button.querySelector('span');

            if (!workoutStartTime) {
                workoutStartTime = Date.now();
                workoutTimer = setInterval(updateWorkoutTimer, 1000);
                icon.setAttribute('data-lucide', 'pause');
                text.textContent = 'Pausar';
                button.classList.remove('bg-blue-600', 'hover:bg-blue-700');
                button.classList.add('bg-yellow-600', 'hover:bg-yellow-700');
            } else {
                clearInterval(workoutTimer);
                workoutStartTime = null;
                icon.setAttribute('data-lucide', 'play');
                text.textContent = 'Iniciar';
                button.classList.remove('bg-yellow-600', 'hover:bg-yellow-700');
                button.classList.add('bg-blue-600', 'hover:bg-blue-700');
            }
            lucide.createIcons();
        });

        document.getElementById('addExercise').addEventListener('click', function() {
            const exerciseName = document.getElementById('exerciseName').value.trim();
            if (!exerciseName) return;

            const exerciseId = Date.now().toString();
            const exercise = {
                id: exerciseId,
                name: exerciseName,
                sets: []
            };

            exercises.push(exercise);
            
            const exerciseElement = document.createElement('div');
            exerciseElement.className = 'bg-gray-50 rounded-lg p-4';
            exerciseElement.innerHTML = `
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-lg font-semibold">${exerciseName}</h3>
                    <button class="add-set px-3 py-1 bg-blue-600 text-white rounded-lg hover:bg-blue-700 text-sm"
                            data-exercise-id="${exerciseId}">
                        Agregar serie
                    </button>
                </div>
                <div class="sets-container space-y-2">
                    <!-- Sets will be added here -->
                </div>
            `;

            document.getElementById('exercisesList').appendChild(exerciseElement);
            document.getElementById('exerciseName').value = '';

            // Add first set automatically
            addSet(exerciseId);
        });

        function addSet(exerciseId) {
            const exercise = exercises.find(e => e.id === exerciseId);
            if (!exercise) return;

            const setId = Date.now().toString();
            const set = {
                id: setId,
                completed: false,
                weight: 0,
                reps: 0
            };

            exercise.sets.push(set);

            const setElement = document.createElement('div');
            setElement.className = 'flex items-center space-x-4';
            setElement.innerHTML = `
                <div class="flex-shrink-0">
                    <input type="checkbox" class="set-checkbox w-5 h-5 text-blue-600"
                           data-exercise-id="${exerciseId}" data-set-id="${setId}">
                </div>
                <div class="flex-shrink-0 w-16">
                    <input type="number" placeholder="kg" class="w-full rounded-md border-gray-300 text-sm"
                           data-exercise-id="${exerciseId}" data-set-id="${setId}" data-field="weight">
                </div>
                <div class="flex-shrink-0 w-16">
                    <input type="number" placeholder="reps" class="w-full rounded-md border-gray-300 text-sm"
                           data-exercise-id="${exerciseId}" data-set-id="${setId}" data-field="reps">
                </div>
            `;

            const setsContainer = document.querySelector(`[data-exercise-id="${exerciseId}"]`)
                .closest('.bg-gray-50')
                .querySelector('.sets-container');
            setsContainer.appendChild(setElement);
        }

        document.addEventListener('click', function(e) {
            if (e.target.classList.contains('add-set')) {
                const exerciseId = e.target.dataset.exerciseId;
                addSet(exerciseId);
            }

            if (e.target.classList.contains('set-checkbox')) {
                const exerciseId = e.target.dataset.exerciseId;
                const setId = e.target.dataset.setId;
                const exercise = exercises.find(e => e.id === exerciseId);
                const set = exercise?.sets.find(s => s.id === setId);
                
                if (set) {
                    set.completed = e.target.checked;
                    if (set.completed) {
                        e.target.closest('.flex').classList.add('animate-pulse');
                        startRestTimer(e.target.closest('.flex'));
                    }
                }
            }
        });

        document.addEventListener('change', function(e) {
            if (e.target.hasAttribute('data-field')) {
                const exerciseId = e.target.dataset.exerciseId;
                const setId = e.target.dataset.setId;
                const field = e.target.dataset.field;
                const value = parseInt(e.target.value) || 0;

                const exercise = exercises.find(e => e.id === exerciseId);
                const set = exercise?.sets.find(s => s.id === setId);
                
                if (set) {
                    set[field] = value;
                }
            }
        });

        // Save workout when completed
        window.addEventListener('beforeunload', function() {
            if (workoutStartTime) {
                const duration = Math.floor((Date.now() - workoutStartTime) / 1000);
                const workoutData = {
                    duration,
                    exercises: exercises.map(ex => ({
                        name: ex.name,
                        sets: ex.sets.map(set => ({
                            weight: set.weight,
                            reps: set.reps,
                            completed: set.completed
                        }))
                    }))
                };

                // Send workout data to server
                fetch('SaveWorkouta', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(workoutData)
                }).catch(console.error);
            }
        });
    </script>
</body>
</html>

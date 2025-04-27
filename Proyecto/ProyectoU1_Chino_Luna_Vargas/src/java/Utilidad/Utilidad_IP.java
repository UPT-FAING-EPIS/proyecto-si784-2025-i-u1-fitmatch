/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utilidad;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import io.ipinfo.api.IPinfo;
import io.ipinfo.api.errors.RateLimitedException;
import io.ipinfo.api.model.IPResponse;
import javax.servlet.http.HttpServletRequest;
import org.json.JSONObject;
/**
 *
 * @author Sio
 */
public class Utilidad_IP {
    
    public String MtdObtenerIPPublica() { // METODO PARA OBTENER LA IP PUBLICA

        String publicIp = null;
        try {

            URL url = new URL("https://api.ipify.org");//API PARA LA IP
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            publicIp = in.readLine(); 
            in.close();
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
        return publicIp;
    }
    
    public String MtdObtenerIPPublica(HttpServletRequest request) { //solo ip
        String clientIp = request.getHeader("X-Forwarded-For");

        // Si el encabezado está vacío o es nulo, intenta obtener la IP remota
        if (clientIp == null || clientIp.isEmpty()) {
            clientIp = request.getRemoteAddr(); // Obtener la IP remota
        }

        // Si hay múltiples IPs en X-Forwarded-For, tomamos la primera
        if (clientIp != null && clientIp.contains(",")) {
            clientIp = clientIp.split(",")[0]; // Tomar la primera IP
        }

        // Eliminar el puerto si está presente
        if (clientIp != null && clientIp.contains(":")) {
            clientIp = clientIp.split(":")[0];
        }

        return clientIp; // Retornar solo la IP del cliente
    }
    
//
//    public String MtdObtenerIPPublica2() { // METODO PARA OBTENER LA IP PUBLICA
//        String publicIp = null;
//        try {
//            // Crear un cliente HTTP
//            HttpClient client = HttpClient.newHttpClient();
//
//            // Crear la solicitud
//            HttpRequest request = HttpRequest.newBuilder()
//                    .uri(URI.create("https://api.ipify.org"))
//                    .GET()
//                    .build();
//
//            // Enviar la solicitud y recibir la respuesta
//            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//
//            // Obtener la IP pública de la respuesta
//            publicIp = response.body();
//        } catch (Exception e) {
//            System.out.println("Error: " + e.getMessage());
//        }
//        return publicIp;
//    }
    
    public String[] ObtenerCiudadIP(String IpReal){
        String[] ciudad = new String[5];
        
        // Agrega tu token aquí
        IPinfo ipInfo = new IPinfo.Builder()
                .setToken("c1327b3a54cbf6")
                .build();
        try {
            IPResponse response = ipInfo.lookupIP(IpReal); 
            
            System.out.println("Tu IP publica: " + response.getIp());
            System.out.println("Ciudad: " + response.getCity());
            System.out.println("Región: " + response.getRegion());
            System.out.println("País: " + response.getCountryCode());
            System.out.println("Direccion Completa: " + response.getAbuse().getAddress()+"");

            ciudad[0] = response.getIp()+"";
            ciudad[1] = response.getCity()+""; //ciudad
            ciudad[2] = response.getRegion()+"";
            ciudad[3] = response.getCountryCode()+"";
            
            String[] direccion = (response.getAbuse().getAddress()+"").split(",");
            ciudad[4] = direccion[0]; // la direccion exacta

            return ciudad;
            
        } catch (RateLimitedException ex) {
            System.out.println("Se agoto la api pipip.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return ciudad;
    }
    
    public String obtenerDireccion(double latitud, double longitud) {
        String urlString = "https://nominatim.openstreetmap.org/reverse?format=json&lat=" 
                            + latitud + "&lon=" + longitud + "&addressdetails=1";

        try {
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();

            // Convertir la respuesta a JSON
            JSONObject json = new JSONObject(response.toString());
            return json.getJSONObject("address").getString("road") + "";
        } catch (Exception e) {
            e.printStackTrace();
            return "No se pudo obtener la dirección.";
        }
    }
    
}

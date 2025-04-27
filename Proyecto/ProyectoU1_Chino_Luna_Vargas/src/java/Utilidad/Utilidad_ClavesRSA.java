/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utilidad;

import java.security.KeyPair;
import java.util.Base64;

/**
 *
 * @author Sio
 */
public class Utilidad_ClavesRSA {
    
    public String[] generarClavesRSA(String PIN){
        
        String[] claves = new String[2]; //1. clave privada cifrada con pin, 2. clave publica
        
        try{

            KeyPair keyPair = CryptoUtils.generateRSAKeyPair();
            String publicKey = Base64.getEncoder().encodeToString(keyPair.getPublic().getEncoded());
            String privateKey = Base64.getEncoder().encodeToString(keyPair.getPrivate().getEncoded());

            // Cifrar clave privada con PIN
            String clavePrivadaCifrada = CryptoUtils.encryptPrivateKey(privateKey, PIN);

            claves[0] = clavePrivadaCifrada;
            claves[1] = publicKey;

        }
        catch (Exception e) {
            System.out.println("Error: "+e.getMessage());
        }
        
        return claves;
    }
    
    
}

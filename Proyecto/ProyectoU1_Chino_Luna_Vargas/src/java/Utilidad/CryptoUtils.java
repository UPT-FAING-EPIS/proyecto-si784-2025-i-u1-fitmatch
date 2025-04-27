/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utilidad;

/**
 *
 * @author Sio
 */
import java.nio.charset.StandardCharsets;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.security.*;
import java.util.Base64;
import javax.crypto.spec.IvParameterSpec;

public class CryptoUtils {

    // Generar par de claves RSA
    public static KeyPair generateRSAKeyPair() throws NoSuchAlgorithmException {
        KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance("RSA");
        keyPairGen.initialize(2048);
        return keyPairGen.generateKeyPair();
    }

    // Cifrar con RSA
    public static String encryptRSA(String data, PublicKey publicKey) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        return Base64.getEncoder().encodeToString(cipher.doFinal(data.getBytes()));
    }

    // Descifrar con RSA
    public static byte[] decryptRSA(String encryptedBase64, PrivateKey privateKey) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] encryptedBytes = Base64.getDecoder().decode(encryptedBase64);
        return cipher.doFinal(encryptedBytes); // Retorna la clave simétrica en bytes
    }

    // Generar clave simétrica AES
    public static SecretKey generateAESKey() throws NoSuchAlgorithmException {
        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
        keyGen.init(256);
        return keyGen.generateKey();
    }

    // Cifrar con AES
    public static String encryptAES(String data, SecretKey secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        return Base64.getEncoder().encodeToString(cipher.doFinal(data.getBytes()));
    }

    // Descifrar con AES
    public static String decryptAES(String encryptedData, SecretKey secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        return new String(cipher.doFinal(Base64.getDecoder().decode(encryptedData)));
    }
    
    
    //mensaje
    public static String decryptMensaje(String encryptedBase64, byte[] iv, SecretKey secretKey) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, secretKey, new IvParameterSpec(iv));

        byte[] encryptedBytes = Base64.getDecoder().decode(encryptedBase64);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);

        return new String(decryptedBytes, StandardCharsets.UTF_8);
    }

    // Cifrar clave privada con PIN usando AES
    public static String encryptPrivateKey(String privateKey, String pin) throws Exception {
        SecretKey secretKey = generateAESKeyFromPin(pin);
        return encryptAES(privateKey, secretKey);
    }

    // Descifrar clave privada con PIN usando AES
    public static String decryptPrivateKey(String encryptedPrivateKey, String pin) throws Exception {
        SecretKey secretKey = generateAESKeyFromPin(pin);
        return decryptAES(encryptedPrivateKey, secretKey);
    }

    // Generar clave AES a partir del PIN (derivación de clave simple)
    private static SecretKey generateAESKeyFromPin(String pin) throws Exception {
        byte[] keyBytes = pin.getBytes();
        MessageDigest sha = MessageDigest.getInstance("SHA-256");
        keyBytes = sha.digest(keyBytes);
        return new javax.crypto.spec.SecretKeySpec(keyBytes, "AES");
    }
}

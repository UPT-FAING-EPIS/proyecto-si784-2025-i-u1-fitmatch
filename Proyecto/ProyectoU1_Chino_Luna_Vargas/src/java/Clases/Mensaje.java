/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Clases;

/**
 *
 * @author ASUS
 */
import java.sql.Timestamp;

public class Mensaje {
    private int id;
    private int senderId;
    private int receiverId;
    private String contenido;
    private Timestamp fechaEnvio;
    private boolean leido;

    public Mensaje(int id, int senderId, int receiverId, String contenido, Timestamp fechaEnvio, boolean leido) {
        this.id = id;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.contenido = contenido;
        this.fechaEnvio = fechaEnvio;
        this.leido = leido;
    }

    // Getters
    public int getId() { return id; }
    public int getSenderId() { return senderId; }
    public int getReceiverId() { return receiverId; }
    public String getContenido() { return contenido; }
    public Timestamp getFechaEnvio() { return fechaEnvio; }
    public boolean isLeido() { return leido; }
}
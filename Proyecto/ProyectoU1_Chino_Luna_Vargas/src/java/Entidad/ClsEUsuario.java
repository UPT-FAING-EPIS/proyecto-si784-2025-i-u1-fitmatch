/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

/**
 *
 * @author Sio
 */
public class ClsEUsuario {

    private int id;
    private String usuario;
    //private String fecha_registro;
    private String password;
    private String correo;
    private String nombre;
    private String apellido;
    private String nivel;
    private String ciudad;
    private String clavePrivadaEncriptado;
    private String clavePublica;

    public ClsEUsuario() {
    }

    public ClsEUsuario(int id, String usuario, String password, String correo, String nombre, String apellido, String nivel, String ciudad, String clavePrivadaEncriptado, String clavePublica) {
        this.id = id;
        this.usuario = usuario;
        this.password = password;
        this.correo = correo;
        this.nombre = nombre;
        this.apellido = apellido;
        this.nivel = nivel;
        this.ciudad = ciudad;
        this.clavePrivadaEncriptado = clavePrivadaEncriptado;
        this.clavePublica = clavePublica;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getNivel() {
        return nivel;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClavePrivadaEncriptado() {
        return clavePrivadaEncriptado;
    }

    public void setClavePrivadaEncriptado(String clavePrivadaEncriptado) {
        this.clavePrivadaEncriptado = clavePrivadaEncriptado;
    }

    public String getClavePublica() {
        return clavePublica;
    }

    public void setClavePublica(String clavePublica) {
        this.clavePublica = clavePublica;
    }

}

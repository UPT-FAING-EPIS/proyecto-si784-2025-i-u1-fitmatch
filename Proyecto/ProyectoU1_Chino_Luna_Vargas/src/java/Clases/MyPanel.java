/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Clases;

/**
 *
 * @author ASUS
 */
import java.awt.Color;
import java.awt.GradientPaint;
import java.awt.Graphics;
import java.awt.Graphics2D;
import javax.swing.JPanel;

public class MyPanel extends JPanel {
      @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g;
        
        int width = getWidth();
        int height = getHeight();
        
        GradientPaint gradient = new GradientPaint(0, 0, new Color(138, 43, 226), width, height, new Color(75, 0, 130));
        g2d.setPaint(gradient);
        g2d.fillRect(0, 0, width, height);
    }
}

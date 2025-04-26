/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Clases;

import java.awt.Color;
import java.awt.GradientPaint;
import java.awt.Graphics;
import java.awt.Graphics2D;
import javax.swing.JFrame;
import javax.swing.JPanel;

/**
 *
 * @author ASUS
 */
public class GradientPanel extends JPanel{
     private Color color1 = new Color(0,153,153);
    private Color color2 = Color.RED;
    
    @Override
    public void paint(Graphics g) {
        super.paint(g);
        
        Graphics2D g2D = (Graphics2D) g;
        
        int w = getWidth();
        int h = getHeight();
        
        GradientPaint gp = new GradientPaint(0, 0, color1, 0, h, color2);
        
        g2D.setPaint(gp);
        g2D.fillRect(0, 0, w, h);
    }
    
    public static void main(String[] args) {
        JFrame frame = new JFrame();
        GradientPanel mColor = new GradientPanel();
        frame.add(mColor);
        frame.setSize(500, 500);
        frame.setLocationRelativeTo(null);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}

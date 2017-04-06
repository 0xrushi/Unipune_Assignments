
/*

                           dP       oo          d8888b. dP   dP 
                           88                       `88 88   88 
88d888b. dP    dP .d8888b. 88d888b. dP .d8888b. .aaadP' 88aaa88 
88'  `88 88    88 Y8ooooo. 88'  `88 88 88'  `"" 88'          88 
88       88.  .88       88 88    88 88 88.  ... 88.          88 
dP       `88888P' `88888P' dP    dP dP `88888P' Y88888P      dP 
==================================================================
                                                                
*/

import java.awt.*;
import java.awt.event.*;
import java.util.Arrays;
import javax.swing.*;

/**
 * Creates points and draws lines with right-clicks and then draws the polygon with a left mouse click
 */

public class DrawPolygon extends JApplet implements MouseListener {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int nextPointIndex;             //Index of the next location to be added into the array of points
    private int[] nextPointsX;              //Int array of X coordinate locations of the points
    private int[] nextPointsY;              //Int array of Y coordinate locations of the points
    private Point nextPoint;                //Point returned by e.getPoint() upon left-click
    private Polygon drawnShape;             //Polygon object to be drawn upon user right-click
    private JPanel menuPanel;               //Panel that holds colorPick and reset buttons 
    private Color fillColor;                //Color that is used to fill the Polygon shape
    private Boolean finishedDrawing;        //Boolean that marks whether the right mouse button was clicked
    
    private final int MAX_POINTS = 100;     //Max number of clicks allowed in the array of coordinates
    
    /**
     * init()
     * Sets the initial values of arrays, boolean, and color variables and a MouseListener while it 
     * creates the JPanel and JButtons with ActionListeners, after it sets visibility true
     */
    @Override
    public void init() {
        //Creates the int-array for the X & Y points        
        nextPointsX = new int[MAX_POINTS];
        nextPointsY = new int[MAX_POINTS];
        
        //Fills the int-arrays with 0's and the nextPointIndex as 0
        Arrays.fill(nextPointsX, 0);
        Arrays.fill(nextPointsY, 0);
        nextPointIndex = 0;
        
        //Initializes the fillColor as black and the Boolean finishedDrawing as false
        fillColor = Color.BLACK;
        finishedDrawing = false;
        
        addMouseListener(this);     //adds MouseListener to the Applet
        
        //Creates the JPanel and JButtons
        menuPanel = new JPanel();
        
        //adds ActionListeners to the JButtons
        
        //Sets the FlowLayout and adds the JButtons to the JPanel, and adds the JPanel to the Applet
        menuPanel.setLayout(new FlowLayout());
        add(menuPanel);
        
        //Sets the JPanel and JApplet as visible
        menuPanel.setVisible(true);
        setVisible(true);
    }
    
    /**
     * paint(Graphics g)
     * if nextPointIndex is not 0, draws PolyLine with the points, else if finishedDrawing is true, then
     * draws Polygon drawnShape and then fills it with the chosen (or default) color
     */
    @Override
    public void paint(Graphics g) {
        super.paint(g);
        if ( nextPointIndex > 0 && !finishedDrawing ) { //Draws lines between points with drawPolyLine
            g.drawPolyline(nextPointsX, nextPointsY, nextPointIndex);
        }
        else if ( finishedDrawing ) {                   //Draws the Polygon and fills it with fillColor
            g.setColor(Color.BLACK);
            g.drawPolygon(drawnShape);
            g.fillPolygon(drawnShape);
        }
        
    }
    
    /**
     * mousePressed(MouseEvent e)
     * if mousePressed is the left button and its the first point, e.getButton() sets the first X & Y
     * coordinates and the nextPointIndex as 1
     * else if mousePressed is the left button and finishedDrawing is not true, takes the next point and
     * increments the index count and repaints since there are more than 2 points
     * if mousePressed is the right button then creates the Polygon with the X & Y point arrays and 
     * sets finishedDrawing as true
     * @param e 
     */
    @Override
    public void mousePressed(MouseEvent e) {
        //First point, does not call repaint()
        if( e.getButton() == MouseEvent.BUTTON1 && nextPointIndex == 0 ) {
            nextPoint = e.getPoint();
            nextPointsX[0] = nextPoint.x;
            nextPointsY[0] = nextPoint.y;
            
            nextPointIndex = 1;
        }
        //After the first point, before last point, calls repaint()
        else if ( e.getButton() == MouseEvent.BUTTON1 && !finishedDrawing) {
                        
            if( nextPointIndex < MAX_POINTS ) {     //if the nextPointIndex is in bounds
                nextPoint = e.getPoint();
                nextPointsX[nextPointIndex] = nextPoint.x;
                nextPointsY[nextPointIndex] = nextPoint.y;
            
                nextPointIndex++;
                repaint();
            }            
        }
        //Creates the Polygon and disables creating new points
        if ( e.getButton() == MouseEvent.BUTTON3 ) {
            
            drawnShape = new Polygon(nextPointsX, nextPointsY, nextPointIndex);            
            
            finishedDrawing = true;            
            repaint();
        }
    }
    
    //Not used functions of MouseListener
    public void mouseClicked(MouseEvent e) {    }

    public void mouseReleased(MouseEvent e) {    }

    public void mouseEntered(MouseEvent e) {    }

    public void mouseExited(MouseEvent e) {    }  
}

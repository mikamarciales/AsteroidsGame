SpaceShip katie = new SpaceShip();
Star[] nightSky = new Star[500];
//Asteroid[] aField = new Asteroid[45];
ArrayList <Asteroid> theList;
ArrayList <Bullet> bList;
//Bullet boi = new Bullet(katie);

public void setup() 
{
  size(1200, 800);
  for (int i = 0; i < nightSky.length; i++)
  {
    nightSky[i] = new Star();
  }
  /*for (int i = 0; i < aField.length; i++)
  {
    aField[i] = new Asteroid();
  }*/
  theList = new ArrayList <Asteroid>();
  for(int i=0; i<45; i++)
  {
    theList.add(i,new Asteroid());
  }
  bList = new ArrayList <Bullet>();
}

public void draw() 
{
  noStroke();
  background(0);
  //fill(0, 0, 0, 25);
  //rect(-5, -5, 1005, 805);
  for (int i = 0; i < nightSky.length; i++)
  {
    nightSky[i].show();
  }
  katie.move();
  katie.show();
  for (int nI = 0; nI < theList.size(); nI++)
  {
    //Asteroid betty = theList.get(nI);
    //betty.move();
    //betty.show();
    theList.get(nI).move();
    theList.get(nI).show();
  }

  for (int nI = theList.size()-1; nI >= 0; nI--)
  {
    if (dist(katie.getX(), katie.getY(), theList.get(nI).getX(), theList.get(nI).getY()) < 20)
    {
      theList.remove(nI);
    }
  }
   for (int bI = 0; bI < bList.size(); bI++)
  {
    bList.get(bI).move();
    bList.get(bI).show();
  }
  for (int bI = bList.size()-1; bI >= 0; bI--)
  {
    if (dist(bList.get(bI).getX(), bList.get(bI).getY(), theList.get(bI).getX(), theList.get(bI).getY()) < 20)
    {
      theList.remove(bI);
      bList.remove(bI);
    }
  }

}

class Star
{
  private int starX, starY, starColor; 
  private double starSize;
  public Star()
  {
    starX = (int)(Math.random()*1200);
    starY = (int)(Math.random()*800);
    //starColor = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
    starSize = (Math.random()+1);
  }
  public void show()
  {
    noStroke();
    //fill(starColor);
    fill(255);
    ellipse((float)starX, (float)starY, (float)starSize, (float)starSize);
  }
}

class Asteroid extends Floater
{
  private int aSpeed, myColor2;
  private int pSize = (int)(Math.random()*3);
  public Asteroid()
  {
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -10*pSize;
    yCorners[0] = -7*pSize;
    xCorners[1] = 6*pSize;
    yCorners[1] = -7*pSize;
    xCorners[2] = 12*pSize;
    yCorners[2] = -1*pSize;
    xCorners[3] = 5*pSize;
    yCorners[3] = 9*pSize;
    xCorners[4] = -10*pSize;
    yCorners[4] = 7*pSize;
    xCorners[5] = -14*pSize;
    yCorners[5] = -1*pSize;
    //myColor = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
    myColor = color(0);
    myColor2 = color(255);
    myCenterX = (int)(Math.random()*1200);
    myCenterY = (int)(Math.random()*800);
    myDirectionX = ((Math.random()*.6)-0.3);
    myDirectionY = ((Math.random()*.6)-0.3);
    myPointDirection = 0;
    aSpeed = (int)((Math.random()*5)-2);
  }
  public void setX(int x)  {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y)  {myCenterY = y;}
  public int getY()  {return (int)myCenterY;}
  public void setDirectionX(double x)  {myDirectionX = x;} 
  public double getDirectionX()  {return myDirectionX;}
  public void setDirectionY(double y)  {myDirectionY = y;}
  public double getDirectionY()  {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public void move()
  {
    rotate(aSpeed);
    super.move();
  }
  public void show()
  {
    fill(myColor);   
    stroke(myColor2);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE); 
  }
}

class Bullet extends Floater
{
  public Bullet(SpaceShip theShip)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5*Math.cos(dRadians) + theShip.myDirectionX;
    myDirectionY = 5*Math.sin(dRadians) + theShip.myDirectionY;
    myColor = color(255);
  }
  public void setX(int x)  {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y)  {myCenterY = y;}
  public int getY()  {return (int)myCenterY;}
  public void setDirectionX(double x)  {myDirectionX = x;} 
  public double getDirectionX()  {return myDirectionX;}
  public void setDirectionY(double y)  {myDirectionY = y;}
  public double getDirectionY()  {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public void show()
  {
    fill(myColor);   
    stroke(myColor);             
    ellipse((float)myCenterX, (float)myCenterY, 2, 2);
  }
}

class SpaceShip extends Floater  
{   
  public SpaceShip()
  {
    corners = 7;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -8;
    yCorners[0] = -14;
    xCorners[1] = -2;
    yCorners[1] = -6;
    xCorners[2] = -12;
    yCorners[2] = -2;
    xCorners[3] = -12;
    yCorners[3] = 2;
    xCorners[4] = -2;
    yCorners[4] = 6;
    xCorners[5] = -8;
    yCorners[5] = 14;
    xCorners[6] = 18;
    yCorners[6] = 0;
    myColor = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
    myCenterX = 600;
    myCenterY = 400;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x)  {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y)  {myCenterY = y;}
  public int getY()  {return (int)myCenterY;}
  public void setDirectionX(double x)  {myDirectionX = x;} 
  public double getDirectionX()  {return myDirectionX;}
  public void setDirectionY(double y)  {myDirectionY = y;}
  public double getDirectionY()  {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

public void keyPressed()
{
  //System.out.println(key);
  if (keyCode == LEFT)
  {
    katie.rotate(-17);
  }
  if (keyCode == RIGHT)
  {
    katie.rotate(17);
  }
  if (keyCode == UP)
  {
    katie.accelerate(0.5);
  }
  if (keyCode == DOWN)
  {
    katie.accelerate(-0.5);
  }
  if (key == 'h')
  {
    katie.setDirectionX(0);
    katie.setDirectionY(0);
    katie.setX((int)(Math.random()*1200));
    katie.setY((int)(Math.random()*800));
    katie.setPointDirection((int)(Math.random()*360));
    fill(255);
    rect(-5, -5, 1205, 805);
  }
  if (key == ' ')
  {
    for(int i = 0; i < 10; i++)
    {
      bList.add(i, new Bullet(katie));
    }
  }
  /*if (key == 's')
  {
    //katie.accelerate(-2);
    katie.setDirectionX(0);
    katie.setDirectionY(0);
  }*/
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);
  abstract public int getX();
  abstract public void setY(int y);
  abstract public int getY();
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);
  abstract public double getDirectionY();
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection();

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians = myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {           
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
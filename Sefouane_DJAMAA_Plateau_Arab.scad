// ceci est un modele de de plateau arabe 
// DJAMAA Sefouane


//partie du plateau la plus grande

bdh = 6;
bsh = 4;
rh = 3;

/* corps en mm */

// nombres de coté du polygone
figures = 16;
epaisseur = 2.1;
bt = 42;
bf = 1.9;


// base
linear_extrude( height = bsh )
    polygone( solid="yes" );

// corps
translate([0,1,bsh])
linear_extrude( height = bdh, twist = bt,
                scale = bf, slices = 2*bdh )
    polygone( solid="no" ); 
    
// bordure en haut dans le edge
translate([0,0,bdh+bsh])
rotate(-bt)
scale(bf)
linear_extrude( height = rh )
    polygone( solid="no" );


module polygone(solid){
    difference(){

        offset( r=5, $fn=48 )
            circle( r=radius, $fn=figures );


        if (solid=="no"){
        offset( r=5-epaisseur, $fn=47 )
            circle( r=radius, $fn=figures );
        }
    }
}

///////////////////////////////////////////

//bordure plateau


r=48;
for (theta=[0:10:360])
{
    x=r*cos(theta);
    y=r*sin(theta);
    translate ([x,y,0]) cylinder (h=12,r1=6, r2=1);
}
difference ()
{
    cylinder (h=3, r=50);
    translate ([0,0,-1])cylinder (h=5,r=45);
}




/////////////////////////////////
//Plateau

height = 10;
radius = 50;
paroie = 5;



module plateau(){
	difference(){
		cylinder(height,radius,radius);
			cylinder(height,radius-plt,radius-lt);	}
}
 
difference(){
cylinder(height, radius, radius, $fn=7*radius);
translate([0,0,3])
	cylinder(height, radius-paroie, radius-paroie, $fn=4*radius);
}

 
///////////////////////////////////
//boule en bas //fait 

$fn =60;


for ( boule = [ 0:40:360]){
    
    rotate([0,0,ballon])
    sphere( r= 2.9);
}



//////////////////////////////////////
  ///l'etoile en base // fait pas d'erreurs


t = 22.6;
c = 29;
rotations = 15;

step = 0.05;
for(q = [0:step:1]){
hull(){
rotate([0,0,360*q])
translate([t,0,0])
rotate([0,-rotations*360*q,0])
translate([c,0,0])
rotate([90,0,0])
cylinder(r = 2.9, center =  true, $fn = 90, h = 0.001);
	
q2 = q+step;

rotate([0,0,360*q2])
translate([t,0,0])
rotate([0,-rotations*360*q2,0])
translate([c,0,0])
rotate([90,0,0])
cylinder(r = 2.5, center =  true, $fn = 25, h = 0.001);
}
}


/////////////////////////////////////////////////////////

/////VASE

step = 0.1;
fo = 10;
 //la hauteur
function f(p,q) =(p*p + q*q)/3;

for(a= [-1:step:1], b = [-1:step:1]){
    
    x=a*fo;
    y=b*fo;
    //x plus step
    xps = (a+step)*fo;
    //x plus step
    yps = (b+step)*fo;
    s = 0.90;
    
    //le corps du vase 
    hull(){
    //(x,y)
    translate([x,y,f(x,y) + 0.05 + 0.2])
    cube(size = s, center = true);
    
    //(x,y + step)
    translate([x,yps,f(x,yps)+ 0.05 +0.2])
    cube(size = s, center = true);
    
    //(x+step , y)
    translate([xps,y,f(xps,y)+ 0.05 +0.2])
    cube(size = s, center = true);
    
    }     
}
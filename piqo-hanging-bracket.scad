
$fn=60;

module rounded_cube(main_dimension, corner_diam, wall_thickness, extra_z=0) {

  hull() {
    translate([corner_diam/2,corner_diam/2,0]) cylinder(d=corner_diam,h=main_dimension+wall_thickness+extra_z);
    translate([corner_diam/2,main_dimension-corner_diam/2+wall_thickness*2,0]) cylinder(d=corner_diam,h=main_dimension+wall_thickness+extra_z);
    translate([main_dimension-corner_diam/2+wall_thickness*2,main_dimension-corner_diam/2+wall_thickness*2,0]) cylinder(d=corner_diam,h=main_dimension+wall_thickness+extra_z);
    translate([main_dimension-corner_diam/2+wall_thickness*2,corner_diam/2,0]) cylinder(d=corner_diam,h=main_dimension+wall_thickness+extra_z);

  }  
}

main_dimension = 57;
corner_diam = 2;
wall_thickness = 1;

difference() {
  union() {
    rounded_cube(main_dimension, 4, wall_thickness);
    
    // front to back holes
    translate([wall_thickness+main_dimension/2-10/2,0,main_dimension]) hull() {
      translate([-5,0,-10]) cube([20, main_dimension+wall_thickness*2, 10]);
      translate([5,-wall_thickness,5]) rotate([-90,0,0]) cylinder(d=12,h=main_dimension+wall_thickness*4); // cube([10, main_dimension+wall_thickness*4, 10]);
    }
    
    // side to side holes
    translate([0,wall_thickness+main_dimension/2-10/2,main_dimension]) hull() {
      translate([0,-5,-10]) cube([main_dimension+wall_thickness*2,20, 10]);
      translate([-wall_thickness,5,5]) rotate([0,90,0]) cylinder(d=12,h=main_dimension+wall_thickness*4); // cube([10, main_dimension+wall_thickness*4, 10]);
    }
  }
  
  // front-back holes
  translate([wall_thickness+main_dimension/2-10/2+5,-wall_thickness-0.1,main_dimension+5]) rotate([-90,0,0]) cylinder(d=6,h=main_dimension+wall_thickness*4+0.2); //
  // side-to-side holes
  translate([-wall_thickness-0.1,wall_thickness+main_dimension/2-10/2+5,main_dimension+5]) rotate([0,90,0]) cylinder(d=6,h=main_dimension+wall_thickness*4+0.2); // cube([10, main_dimension+wall_thickness*4, 10]);

  
  translate([wall_thickness, wall_thickness, wall_thickness+0.01]) rounded_cube(main_dimension, corner_diam, 0, extra_z=10);
  
  
  // pull material out of base
  translate([wall_thickness+main_dimension/2,wall_thickness+main_dimension/2,-0.01]) cylinder(d=main_dimension-4,h=5);
  
  // front
  translate([5+11,-3,main_dimension-27+11]) rotate([-90,0,0]) cylinder(d=27,h=5); // cube([22,5,30]);
  
  // heat vents
  translate([-1,10+wall_thickness,27]) cube([80,main_dimension-20,20]);
  
  // left with focus knob
  translate([-1,wall_thickness+main_dimension/2,2]) intersection() {
    rotate([0,90,0]) cylinder(d=40,h=5);
    translate([0,-20,0]) cube([5,40,40]);
  }
  
  // right with buttons
  translate([main_dimension,20,2]) cube([5,35,20]);
  
  // back
  translate([wall_thickness+5,main_dimension,2]) cube([main_dimension-10,5,15]);
}
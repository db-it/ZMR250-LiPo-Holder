basePlateLength = 63;
basePlateDepth = 37.2 + 5;
basePlateHeight = 2;

screwHeadHeight = 3.15;
screwHeadDiameter = 6;
screwHeadRadius = screwHeadDiameter / 2;
screwHoleHeight = basePlateHeight;
screwHoleDiameter = 3.5;
screwHoleRadius = screwHoleDiameter / 2;

screwHoleOffsetX = 1.5;
screwHoleOffsetY = screwHoleRadius + 2.5;
holeDistanceMidToMidY = 33.7;
holeDistanceMidToMidX = 60;

main();


module basePlate() {
    difference() {
        cube([basePlateLength, basePlateDepth, basePlateHeight + screwHeadHeight]);
        
        // cable spaces
        translate([0,10,0]) bottomSpace();
        translate([63-10.4,10,0]) bottomSpace();
        
        // screw holes
        translate([screwHoleOffsetX, screwHoleOffsetY, 0]) #screwHole(screwHoleDiameter, screwHoleHeight);
        translate([screwHoleOffsetX, screwHoleOffsetY, basePlateHeight]) #screwHole(screwHeadDiameter, screwHeadHeight);

        translate([screwHoleOffsetX, screwHoleOffsetY  + holeDistanceMidToMidY, 0]) #screwHole(screwHoleDiameter, screwHoleHeight);
        translate([screwHoleOffsetX, screwHoleOffsetY + holeDistanceMidToMidY, basePlateHeight]) #screwHole(screwHeadDiameter, screwHeadHeight);
        
        translate([screwHoleOffsetX + holeDistanceMidToMidX, screwHoleOffsetY, 0]) rotate(180) #screwHole(screwHoleDiameter, screwHoleHeight);
        translate([screwHoleOffsetX + holeDistanceMidToMidX, screwHoleOffsetY, basePlateHeight]) rotate(180) #screwHole(screwHeadDiameter, screwHeadHeight);
        
        translate([screwHoleOffsetX + holeDistanceMidToMidX, screwHoleOffsetY  + holeDistanceMidToMidY, 0]) rotate(180) #screwHole(screwHoleDiameter, screwHoleHeight);
        translate([screwHoleOffsetX + holeDistanceMidToMidX, screwHoleOffsetY + holeDistanceMidToMidY, basePlateHeight]) rotate(180) #screwHole(screwHeadDiameter, screwHeadHeight);
    }
}

module screwHole(diameter, height) {
    radius = diameter / 2;
    hull() {
        cylinder(d = diameter, h = height);
        translate([-radius, -radius, 0]) cube([0.1, diameter, height]);
    }
}

module sideHolder() {
    rotate(90, [1,0,0]) translate([0,0,-1.3]) linear_extrude(height=1.3) {
        polygon(points=[[0, 0], [5, 10], [15, 10], [20, 0]]);
    }
}

module strapHole() {
    cube([22, basePlateDepth, 2.5]);
}

module bottomSpace() {
    cube([10.4,22,5.2]);
}

module main() {
    difference() {
        basePlate();
        translate([20.5, 0, 0]) strapHole();
    }

    sideHolderOffsetZ = 2.5;

    translate([1, 0, sideHolderOffsetZ]) sideHolder();    
    translate([42, 0, sideHolderOffsetZ]) sideHolder();
    
    translate([1, basePlateDepth - 1.3, sideHolderOffsetZ]) sideHolder();
    translate([42, basePlateDepth - 1.3, sideHolderOffsetZ]) sideHolder();
}

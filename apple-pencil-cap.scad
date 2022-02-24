// Parameters
$fn = 256;
cap_diameter = 8.8;
cap_height = 16.5;
mating_ring_diameter = 8;
mating_ring_height = 1;
mating_ring_thickness = 0.4;
// magnet_diameter = 8;
// magnet_height = 4;

lightning_slot_dimensions = [2.5, 7, 9]; // x, y, z

// Computed parameters

cap_radius = cap_diameter / 2;
outer_shell_height = cap_height - mating_ring_height;
curvature_start_height = outer_shell_height - cap_radius;
lightning_slot_centering_offset = -1 * [lightning_slot_dimensions[0] / 2, lightning_slot_dimensions[1] / 2, mating_ring_height];
//magnet_cap_offset = [0, 0, cap_height - delta_betweeen_cap_top_and_magnet_slot];
//magnet_cutout_offset = [0, 0, lightning_slot_dimensions[2] + lightning_slot_centering_offset[2]];
//delta_betweeen_cap_top_and_magnet_slot = cap_height - (magnet_cutout_offset[2] + (magnet_height));

// Model

difference() {
    outer_shell();
    internal_negative_space();
};

// Components

module outer_shell() {
    union() {
        // Round top
        translate([0, 0, curvature_start_height]) {
            sphere(d = cap_diameter);
        };
        
        // Main cylinder
        cylinder(curvature_start_height, d = cap_diameter);

        // Mating Ring
        translate([0, 0, -mating_ring_height]) {
            cylinder(mating_ring_height, d = mating_ring_diameter);
        };
    };
};

module internal_negative_space() {
    union() {
        // Lightning Slot
        translate(lightning_slot_centering_offset) {
            cube(lightning_slot_dimensions);
        };
        
        // Magnet Slot
        //translate(magnet_cutout_offset) {
        //    cylinder(magnet_height, d = magnet_diameter);
        //};
        
        // Empty Space on bottom
        //translate([0, 0, -1.5]) {
        //    cylinder(h = 3.7 + mating_ring_height, d = mating_ring_diameter - mating_ring_thickness); // TODO: Magic number
        //};
        
        // Magnet Cap holes
        //translate(magnet_cap_offset) {
        //    difference() {
        //        cylinder(h = delta_betweeen_cap_top_and_magnet_slot, d = magnet_diameter);
        //        cylinder(h = delta_betweeen_cap_top_and_magnet_slot / 2 * 0.9, d = magnet_diameter * 0.9);
        //    };
        //};
        
        // Hole to pop out magnet/top cap
        //cylinder(cap_height - magnet_height, d = 1.5); 
    };
    
};

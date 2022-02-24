// Parameters
$fn = 256;
cap_diameter = 8.8;
cap_height = 16.5;
mating_ring_diameter = 8;
mating_ring_height = 1;
mating_ring_thickness = 0.4;
lightning_slot_dimensions = [2.5, 7, 9.7]; // x, y, z

// Computed parameters
cap_radius = cap_diameter / 2;
outer_shell_height = cap_height - mating_ring_height;
curvature_start_height = outer_shell_height - cap_radius;
lightning_slot_centering_offset = -1 * [lightning_slot_dimensions[0] / 2, lightning_slot_dimensions[1] / 2, mating_ring_height];

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
    };
};

module internal_negative_space() {
    // Lightning Slot
    translate(lightning_slot_centering_offset) {
        cube(lightning_slot_dimensions);
    };
};

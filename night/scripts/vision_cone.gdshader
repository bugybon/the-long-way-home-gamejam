shader_type canvas_item;
render_mode unshaded;

uniform float cone_angle: hint_range(0.1, 360.0) = 90; // Angle in degrees
uniform float start_angle: hint_range(0.0, 360.0) = 270.0; // Start angle in degrees
uniform float fade_intensity: hint_range(0.0, 10.0) = 3.0; // Controls fade strength
uniform float circle_radius: hint_range(0.0, 1.0) = 0.5; // Radius of the circular mask
uniform float little_circle_radius: hint_range(0.0, 1.0) = 0.1; // Radius of the circular mask
uniform float inner_circle_alpha: hint_range(0.0, 1.0) = 0.1; // Alpha of the circular mask
uniform float outline_thickness: hint_range(0.0, 0.1) = 0.015; // Thickness of the outline
uniform vec4 custom_color: source_color = vec4(1.0, 1.0, 1.0, 1.0); // Customizable color
uniform vec4 custom_background_color: source_color = vec4(0.0, 0.0, 0.0, 0.0); // Customizable color
uniform float background_alpha: hint_range(0.0, 1.0) = 0.1; // Alpha of the circular mask
uniform float cone_scale = 1.0; // Scaling factor, I don't recommed setting a value lower than 0.1

void fragment() {
    //UV scaling and centring
    vec2 uv = (UV - vec2(0.5)) * cone_scale + vec2(0.5); // Adjust UV for scaling
    vec2 centered_uv = uv - vec2(0.5); // Center UV (shifts UV to range -0.5 to 0.5)
    float angle = atan(centered_uv.y, centered_uv.x); // Get angle from center
    float radius = length(centered_uv); // Get distance from center

    // Convert cone angle and start angle to radians
    float cone_radians = radians(cone_angle / 2.0);
    float start_radians = radians(start_angle);

    // Shift the angle by the start angle and wrap it within the range of -π to π
    angle -= start_radians;
    angle = mod(angle + PI, 2.0 * PI) - PI;

    // Determine if the pixel is inside the cone shape
    float within_cone = step(abs(angle), cone_radians);

    // Adjust circle radius based on scale
    float scaled_circle_radius = circle_radius * cone_scale;
	float scaled_little_circle_radius = little_circle_radius * cone_scale;
    // Circular mask
    float within_circle = step(radius, scaled_circle_radius);
	float within_little_circle = step(radius, scaled_little_circle_radius);
	
    // Inverted fade effect (center is fully visible, edges are transparent)
    float fade = smoothstep(0.0, 1.0, (radius / cone_scale) * fade_intensity); // Adjust fade based on scale

    // Sharp outline effect within the cone
    float outline = step(scaled_circle_radius - outline_thickness, radius) - step(scaled_circle_radius, radius);

    // Outline effect on the sides of the cone angle
    float angle_outline = 0.0;
    const float epsilon = 0.0001;

    if (abs(cone_angle) > epsilon && abs(cone_angle - 360.0) > epsilon) {
        angle_outline = step(cone_radians - radians(outline_thickness * 180.0 / 3.14159), abs(angle)) - step(cone_radians, abs(angle));
    }

    // Mix the outlines
    float combined_outline = max(outline, angle_outline);

    // Apply fade, cone mask, circular mask, and combined outline to final output
    vec4 color = vec4(custom_color.rgb, inner_circle_alpha * fade * within_cone * within_circle); // Custom color
    vec4 outline_color = vec4(custom_color.rgb, combined_outline * fade * within_cone * within_circle); // Custom color outline

    // Combine color and outline
	
	vec4 bg_color = vec4(custom_background_color.rgb, background_alpha * (1.0 - within_cone) * within_circle + background_alpha * (1.0-within_circle) - background_alpha * within_little_circle); // Custom color
    //vec4 outline_color = vec4(custom_color.rgb, combined_outline * fade * within_cone * within_circle); // Custom color outline

    vec4 fg_color = mix(color, outline_color, outline_color.a);
    
	// Premultiply both by their own alpha before adding
	vec3 combined_rgb = bg_color.rgb * bg_color.a + fg_color.rgb * fg_color.a;
	float combined_a = bg_color.a + fg_color.a;

	// Un-premultiply for final output (avoid divide-by-zero where nothing is present)
	COLOR = vec4(combined_rgb / max(combined_a, 0.0001), clamp(combined_a, 0.0, 1.0));
	
}

shader_type canvas_item;

uniform sampler2D back_texture;
uniform float flip_progress : hint_range(0.0, 1.0) = 0.0;
uniform float perspective = 0.6;

void fragment() {
    float angle = flip_progress * PI;

    float cosine = cos(angle);
    float sine = sin(angle);

    vec2 uv = UV;
    uv.x -= 0.5;

    // Fake 3D perspective distortion
    float depth = sine * perspective;
    uv.x = uv.x / abs(cosine + depth);

    uv.x += 0.5;

    // If outside bounds, discard pixel
    if (uv.x < 0.0 || uv.x > 1.0) {
        discard;
    }

    // Choose front or back texture
    if (cosine > 0.0) {
        COLOR = texture(TEXTURE, uv);
    } else {
        vec2 flipped_uv = vec2(1.0 - uv.x, uv.y);
        COLOR = texture(back_texture, flipped_uv);
    }
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

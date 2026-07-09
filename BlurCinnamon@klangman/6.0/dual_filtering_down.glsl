uniform sampler2D tex;
uniform float offset;
uniform float width;
uniform float height;

vec4 sampleBoundary(vec2 uv, vec2 uv_offset, vec2 halfpixel) {
    vec2 pos = clamp(uv + uv_offset * halfpixel, vec2(3.0 / width, 3.0 / height), vec2(1.0 - 3.0 / width, 1.0 - 3.0 / height));
    return texture2D(tex, pos);
}

void main() {
    vec2 uv = cogl_tex_coord_in[0].xy;
    vec2 halfpixel = vec2(0.5 / width, 0.5 / height);

    vec4 sum = texture2D(tex, uv) * 4.0;
    sum += sampleBoundary(uv, vec2(-offset * 0.5, -offset * 0.5), halfpixel);
    sum += sampleBoundary(uv, vec2( offset * 0.5, -offset * 0.5), halfpixel);
    sum += sampleBoundary(uv, vec2(-offset * 0.5,  offset * 0.5), halfpixel);
    sum += sampleBoundary(uv, vec2( offset * 0.5,  offset * 0.5), halfpixel);

    cogl_color_out = sum / 8.0;
}
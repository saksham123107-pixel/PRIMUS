struct Params { thermal_mix: f32, contrast: f32 }

// Maps luminance to thermal infrared spectrum: Dark Navy -> Purple -> Red -> Yellow -> White
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let intensity = params.thermal_mix / 100.0;
    let cont = params.contrast / 100.0;

    var lum = luma(c.rgb);
    lum = clamp((lum - 0.5) * cont + 0.5, 0.0, 1.0);

    var thermal = vec3<f32>(0.0);
    if (lum < 0.25) {
        let t = lum / 0.25;
        thermal = mix(vec3<f32>(0.05, 0.05, 0.35), vec3<f32>(0.45, 0.0, 0.65), t);
    } else if (lum < 0.5) {
        let t = (lum - 0.25) / 0.25;
        thermal = mix(vec3<f32>(0.45, 0.0, 0.65), vec3<f32>(0.95, 0.2, 0.05), t);
    } else if (lum < 0.75) {
        let t = (lum - 0.5) / 0.25;
        thermal = mix(vec3<f32>(0.95, 0.2, 0.05), vec3<f32>(1.0, 0.9, 0.1), t);
    } else {
        let t = (lum - 0.75) / 0.25;
        thermal = mix(vec3<f32>(1.0, 0.9, 0.1), vec3<f32>(1.0, 1.0, 1.0), t);
    }

    let out = mix(c.rgb, thermal, intensity);
    return vec4<f32>(out, c.a);
}

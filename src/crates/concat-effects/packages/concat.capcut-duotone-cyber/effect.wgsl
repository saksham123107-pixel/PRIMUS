struct Params { mix_val: f32, contrast: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let m = params.mix_val / 100.0;
    let cont = params.contrast / 100.0;

    var lum = luma(c.rgb);
    lum = clamp((lum - 0.5) * cont + 0.5, 0.0, 1.0);

    let shadow_color = vec3<f32>(0.35, 0.0, 0.55); // Deep magenta purple
    let highlight_color = vec3<f32>(0.05, 0.95, 0.95); // Cyan neon

    let duotone = mix(shadow_color, highlight_color, lum);
    let out = mix(c.rgb, duotone, m);
    return vec4<f32>(out, c.a);
}

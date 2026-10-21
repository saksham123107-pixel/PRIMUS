struct Params { contrast_val: f32, fade_val: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let cont = params.contrast_val / 100.0;
    let f = params.fade_val / 100.0 * 0.15;

    let grey = vec3<f32>(luma(c.rgb));
    let contrasted = (grey - vec3<f32>(0.5)) * cont + vec3<f32>(0.5);
    let out = clamp(contrasted + vec3<f32>(f), vec3<f32>(0.0), vec3<f32>(1.0));
    return vec4<f32>(out, c.a);
}

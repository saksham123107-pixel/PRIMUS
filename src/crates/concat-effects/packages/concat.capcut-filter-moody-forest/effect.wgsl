struct Params { forest: f32, contrast: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let f = params.forest / 100.0;
    let cont = params.contrast / 100.0;

    let deep_green = vec3<f32>(0.05, 0.35, 0.22);
    let warm_amber = vec3<f32>(0.95, 0.82, 0.55);

    let graded = split_tone(c.rgb, deep_green, warm_amber, f * 0.45);
    let contrasted = (graded - vec3<f32>(0.5)) * cont + vec3<f32>(0.5);
    return vec4<f32>(contrasted, c.a);
}

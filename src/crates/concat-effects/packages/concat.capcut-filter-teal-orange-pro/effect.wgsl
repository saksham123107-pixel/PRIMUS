struct Params { grade_amt: f32, contrast: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let g = params.grade_amt / 100.0;
    let cont = params.contrast / 100.0;

    let teal = vec3<f32>(0.05, 0.45, 0.55);
    let orange = vec3<f32>(1.0, 0.65, 0.25);

    let graded = split_tone(c.rgb, teal, orange, g * 0.5);
    let contrasted = (graded - vec3<f32>(0.5)) * cont + vec3<f32>(0.5);
    return vec4<f32>(contrasted, c.a);
}

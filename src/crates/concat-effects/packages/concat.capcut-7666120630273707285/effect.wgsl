struct Params { amount: f32 }

fn effect(uv: vec2<f32>) -> vec4<f32> {
let c = sample(uv);
    let n = sin((uv.x * 60.0) + frame.time) * cos((uv.y * 55.0) - frame.time * 1.3);
    let spark = smoothstep(0.985, 1.0, n) * params.amount;
    return vec4<f32>(c.rgb + vec3<f32>(spark), c.a);
}

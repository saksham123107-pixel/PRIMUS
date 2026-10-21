struct Params { amount: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
let p = smoothstep(0.0,1.0,clamp(progress,0.0,1.0));
    let cross = mix(from_at(uv), to_at(uv), p);
    let f = sin(p * 3.14159265) * params.amount;
    return vec4<f32>(mix(cross.rgb, vec3<f32>(1.0), f), cross.a);
}

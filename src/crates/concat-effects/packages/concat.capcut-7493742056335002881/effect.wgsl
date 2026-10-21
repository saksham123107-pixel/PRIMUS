struct Params { amount: f32 }

fn transition(uv: vec2<f32>, progress: f32) -> vec4<f32> {
let p = clamp(progress,0.0,1.0);
    let amp = params.amount * 0.05 * (4.0*p*(1.0-p));
    let j = vec2<f32>(sin(p*61.0), cos(p*53.0)) * amp;
    return mix(from_at(uv+j), to_at(uv-j), smoothstep(0.0,1.0,p));
}

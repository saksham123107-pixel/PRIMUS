struct Params { glow: f32, warmth: f32, radius: f32 }

// Soft focus glamour bloom with golden skin tone tint
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let glow = params.glow / 100.0;
    let warmth = params.warmth / 100.0;
    let t = texel() * max(params.radius, 1.0);

    // Multi-tap soft halo sampling
    var blurred = vec3<f32>(0.0);
    blurred += sample(uv + vec2<f32>(-t.x, -t.y)).rgb * 0.125;
    blurred += sample(uv + vec2<f32>( 0.0, -t.y)).rgb * 0.25;
    blurred += sample(uv + vec2<f32>( t.x, -t.y)).rgb * 0.125;
    blurred += sample(uv + vec2<f32>(-t.x,  0.0)).rgb * 0.25;
    blurred += sample(uv + vec2<f32>( t.x,  0.0)).rgb * 0.25;
    blurred += sample(uv + vec2<f32>(-t.x,  t.y)).rgb * 0.125;
    blurred += sample(uv + vec2<f32>( 0.0,  t.y)).rgb * 0.25;
    blurred += sample(uv + vec2<f32>( t.x,  t.y)).rgb * 0.125;
    blurred = blurred / 1.5;

    // Warm tint on soft bloom
    let warm_bloom = blurred * mix(vec3<f32>(1.0), vec3<f32>(1.08, 1.02, 0.92), warmth);

    // Screen blend over base
    let out = screen(c.rgb, warm_bloom * glow);
    return vec4<f32>(out, c.a);
}

struct Params { amount: f32, dispersion: f32 }

// Diamond rhombus radial zoom with chromatic offset
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let amt = params.amount / 100.0 * 0.08;
    let disp = params.dispersion / 100.0 * 0.02;
    let centre = vec2<f32>(0.5);
    let dir = uv - centre;

    // Diamond weight shape: |x| + |y|
    let diamond_dist = abs(dir.x) + abs(dir.y);
    let scale = diamond_dist * amt;

    var acc = vec3<f32>(0.0);
    let steps = 6;
    for (var i = 0; i < steps; i++) {
        let f = f32(i) / f32(steps - 1);
        let sample_uv = centre + dir * (1.0 - f * scale);

        let r = sample(sample_uv + dir * disp * f).r;
        let g = sample(sample_uv).g;
        let b = sample(sample_uv - dir * disp * f).b;

        acc += vec3<f32>(r, g, b);
    }

    return vec4<f32>(acc / f32(steps), sample(uv).a);
}

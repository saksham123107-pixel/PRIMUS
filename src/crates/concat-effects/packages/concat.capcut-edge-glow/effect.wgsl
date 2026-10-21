struct Params { glow: f32, threshold: f32, hue: f32 }

// Sobel edge detection + electric neon color mapping + additive bloom
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    let t = texel();
    let glow = params.glow / 100.0;
    let thresh = params.threshold / 100.0 * 0.5;

    // Sobel 3x3 kernel on luminance
    let tl = luma(sample(uv + vec2<f32>(-t.x, -t.y)).rgb);
    let tc = luma(sample(uv + vec2<f32>( 0.0, -t.y)).rgb);
    let tr = luma(sample(uv + vec2<f32>( t.x, -t.y)).rgb);
    let ml = luma(sample(uv + vec2<f32>(-t.x,  0.0)).rgb);
    let mr = luma(sample(uv + vec2<f32>( t.x,  0.0)).rgb);
    let bl = luma(sample(uv + vec2<f32>(-t.x,  t.y)).rgb);
    let bc = luma(sample(uv + vec2<f32>( 0.0,  t.y)).rgb);
    let br = luma(sample(uv + vec2<f32>( t.x,  t.y)).rgb);

    let gx = -tl - 2.0 * ml - bl + tr + 2.0 * mr + br;
    let gy = -tl - 2.0 * tc - tr + bl + 2.0 * bc + br;
    let edge_raw = length(vec2<f32>(gx, gy));
    let edge = smoothstep(thresh, thresh + 0.25, edge_raw) * glow;

    // Neon tint from hue angle
    let h = fract(params.hue / 360.0);
    let neon = clamp(abs(fract(vec3<f32>(h) + vec3<f32>(0.0, 2.0 / 3.0, 1.0 / 3.0)) * 6.0 - vec3<f32>(3.0)) - vec3<f32>(1.0), vec3<f32>(0.0), vec3<f32>(1.0));

    // Add neon edges over the base image
    let out = c.rgb + neon * edge * 1.5;
    return vec4<f32>(out, c.a);
}

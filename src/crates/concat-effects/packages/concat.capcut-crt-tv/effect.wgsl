struct Params { scanlines: f32, curve: f32, jitter: f32 }

// CRT tube distortion, scanline grating, phosphor mask and roll jitter
fn effect(uv: vec2<f32>) -> vec4<f32> {
    let curve_k = params.curve / 100.0 * 0.15;
    let scan_amt = params.scanlines / 100.0;
    let jitter_amt = params.jitter / 100.0;

    // Curved tube barrel distortion
    let d = uv - vec2<f32>(0.5);
    let r2 = dot(d, d);
    var p = (uv - vec2<f32>(0.5)) * (1.0 + curve_k * r2) + vec2<f32>(0.5);

    // Vertical roll line jitter
    p.y += sin(frame.time * 4.0) * 0.005 * jitter_amt;

    // Vignette falloff at glass boundary
    if (p.x < 0.0 || p.x > 1.0 || p.y < 0.0 || p.y > 1.0) {
        return vec4<f32>(0.02, 0.02, 0.02, 1.0);
    }

    var c = sample(p);

    // Horizontal scanlines
    let scan = 0.5 + 0.5 * sin(p.y * frame.size.y * 3.14159265);
    c = vec4<f32>(c.rgb * (1.0 - (1.0 - scan) * scan_amt * 0.5), c.a);

    // RGB phosphor triad pattern
    let triad = fract(p.x * frame.size.x / 3.0);
    var mask = vec3<f32>(1.0);
    if (triad < 0.333) {
        mask = vec3<f32>(1.2, 0.9, 0.9);
    } else if (triad < 0.666) {
        mask = vec3<f32>(0.9, 1.2, 0.9);
    } else {
        mask = vec3<f32>(0.9, 0.9, 1.2);
    }
    c = vec4<f32>(c.rgb * mix(vec3<f32>(1.0), mask, scan_amt * 0.4), c.a);

    return c;
}

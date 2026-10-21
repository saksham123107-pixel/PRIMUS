struct Params {
    brightness: f32,
    contrast: f32,
    saturation: f32,
    highlights: f32,
    shadows: f32,
    temperature: f32,
    tint: f32,
}

const Eps: f32 = 1e-5;
// CapCut's SaturationLuminanceFactor, verbatim.
const SatLuma: vec3<f32> = vec3<f32>(0.208540, 0.702086, 0.089374);

fn adjust_shadow(color: vec3<f32>, p: f32) -> vec3<f32> {
    if (p <= 0.0) {
        return pow(color, vec3<f32>(p + 1.0)) - (0.1 * p) * pow(vec3<f32>(1.0) - color, vec3<f32>(5.0));
    }
    return pow(color, vec3<f32>(1.0 / max(1.0 - p, Eps)));
}

fn adjust_highlight(color: vec3<f32>, p: f32) -> vec3<f32> {
    if (p < 0.0) {
        return vec3<f32>(1.0) - pow(vec3<f32>(1.0) - color - (0.1 * p) * color, vec3<f32>(p + 1.0));
    }
    return vec3<f32>(1.0) - pow(vec3<f32>(1.0) - color, vec3<f32>(1.0 / max(1.0 - p, Eps)));
}

fn enhance_contrast(x: f32, pivot: f32, p: f32) -> f32 {
    if (x <= pivot) {
        return pivot * pow(x / max(pivot, Eps), p);
    }
    let pivot_inv = 1.0 - pivot;
    return 1.0 - pivot_inv * pow((1.0 - x) / max(pivot_inv, Eps), p);
}

fn clamp01(c: vec3<f32>) -> vec3<f32> {
    return clamp(c, vec3<f32>(0.0), vec3<f32>(1.0));
}

fn effect(uv: vec2<f32>) -> vec4<f32> {
    let c = sample(uv);
    var col = c.rgb;

    // highlights, then shadows (CapCut order)
    col = clamp01(adjust_highlight(col, params.highlights));
    col = clamp01(adjust_shadow(col, params.shadows));

    // linear ops: exposure about the brightness slider
    col = clamp01(col * (1.0 + params.brightness));

    // contrast about a 0.5 pivot
    if (params.contrast <= 0.0) {
        let cp = params.contrast + 1.0;
        col = cp * (col - vec3<f32>(0.5)) + vec3<f32>(0.5);
    } else {
        let cp = 1.0 / max(1.0 - params.contrast, Eps);
        col = vec3<f32>(
            enhance_contrast(col.r, 0.5, cp),
            enhance_contrast(col.g, 0.5, cp),
            enhance_contrast(col.b, 0.5, cp),
        );
    }
    col = clamp01(col);

    // saturation: CapCut's dot-matrix, exact
    let rgb = col;
    let base = SatLuma * (1.0 - params.saturation);
    col = clamp01(vec3<f32>(
        dot(rgb, base + vec3<f32>(params.saturation, 0.0, 0.0)),
        dot(rgb, base + vec3<f32>(0.0, params.saturation, 0.0)),
        dot(rgb, base + vec3<f32>(0.0, 0.0, params.saturation)),
    ));

    // temperature / tint: warm-cool and green-magenta (approximated)
    col.r += params.temperature * 0.15;
    col.b -= params.temperature * 0.15;
    col.g += params.tint * 0.12;
    col = clamp01(col);

    return vec4<f32>(col, c.a);
}

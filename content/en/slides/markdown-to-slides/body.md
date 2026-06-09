<div class="vq-deck">

<section class="vq-slide vq-slide--title" id="slide-1">
<div class="vq-slide__content">

# Writing Slides In virtqio

Use a normal directory-backed page with `template: "slides.html"`.

</div>
</section>

<section class="vq-slide" id="slide-2">
<div class="vq-slide__content">

## File Layout

Create one directory per deck:

```text
content/en/slides/my-deck/
  metadata.yaml
  body.md
```

`metadata.yaml` selects the slide template:

```yaml
type: "page"
template: "slides.html"
title: "My Deck"
```

</div>
</section>

<section class="vq-slide" id="slide-3">
<div class="vq-slide__content">

## Slide Markup

Each slide is a section:

```html
<section class="vq-slide">
<div class="vq-slide__content">

## Slide Title

Markdown content goes here.

</div>
</section>
```

The blank lines after the HTML tags are important because they let Markdown
inside the slide render normally.

</div>
</section>

<section class="vq-slide" id="slide-4">
<div class="vq-slide__content">

## Math Works

Use the same math shorthand and block syntax as any virtqio page:

:::math
sum[k=1..n] k = \frac{n(n+1)}{2}
:::

Inline math works too: $a_n -> L$ means `a_n` converges to `L`.

</div>
</section>

<section class="vq-slide" id="slide-5">
<div class="vq-slide__content">

## Proof Blocks Work

:::proof[Sketch]

Pair the terms in the sum from the outside inward. Each pair contributes
$n+1$, and there are $n/2$ pairs when $n$ is even. The odd case has the same
formula after the middle term is included.

:::

</div>
</section>

<section class="vq-slide" id="slide-6">
<div class="vq-slide__content">

## Navigation

- Use arrow keys, Page Up/Page Down, Home, and End.
- The URL hash tracks the current slide.
- Printing creates one page per slide.

</div>
</section>

</div>

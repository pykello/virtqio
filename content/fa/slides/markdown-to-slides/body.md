<div class="vq-deck">

<section class="vq-slide vq-slide--title" id="slide-1">
<div class="vq-slide__content">

# نوشتن اسلاید در virtqio

همان محتوای Markdown، ریاضی، و برهان‌ها را می‌شود به شکل یک ارائهٔ تمام‌صفحه نوشت.

</div>
</section>

<section class="vq-slide" id="slide-2">
<div class="vq-slide__content">

## ساختار فایل‌ها

برای هر ارائه یک پوشه بسازید:

```text
content/fa/slides/my-deck/
  metadata.yaml
  body.md
```

در `metadata.yaml` قالب اسلاید را انتخاب کنید:

```yaml
type: "page"
template: "slides.html"
title: "عنوان ارائه"
```

</div>
</section>

<section class="vq-slide" id="slide-3">
<div class="vq-slide__content">

## هر اسلاید یک بخش است

داخل `body.md` هر اسلاید را با `section` مشخص کنید:

```html
<section class="vq-slide">
<div class="vq-slide__content">

## عنوان اسلاید

متن Markdown اینجا قرار می‌گیرد.

</div>
</section>
```

خط‌های خالی بعد از تگ‌های HTML مهم‌اند؛ با آنها Markdown داخل اسلاید درست پردازش می‌شود.

</div>
</section>

<section class="vq-slide" id="slide-4">
<div class="vq-slide__content">

## ریاضی هم همان است

هم می‌شود از shorthand استفاده کرد، هم از LaTeX معمولی:

:::math
sum[k=1..n] k = \frac{n(n+1)}{2}
:::

ریاضی درون‌خطی هم کار می‌کند: $a_n -> L$ یعنی دنبالهٔ $a_n$ به $L$ همگراست.

</div>
</section>

<section class="vq-slide" id="slide-5">
<div class="vq-slide__content">

## برهان و بخش بازشونده

:::proof[ایده]

جمع را از دو طرف جفت کنید. هر جفت مقدار $n+1$ دارد. در حالت زوج تعداد جفت‌ها
$n/2$ است، و در حالت فرد جملهٔ وسط همان فرمول نهایی را کامل می‌کند.

:::

</div>
</section>

<section class="vq-slide" id="slide-6">
<div class="vq-slide__content">

## حرکت بین اسلایدها

- کلیدهای جهت، Page Up و Page Down کار می‌کنند.
- نشانی صفحه با اسلاید فعلی هماهنگ می‌شود.
- هنگام چاپ، هر اسلاید روی یک صفحه می‌آید.

</div>
</section>

</div>

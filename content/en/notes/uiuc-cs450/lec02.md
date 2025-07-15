# CS 450 - Lecture 2

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_v5mj7noh/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/01-lecture.pdf)

Some notes and examples are from:

* Heath, M. T. (2018). Scientific computing: An introductory survey (Revised Second Edition). SIAM. https://doi.org/10.1137/1.9781611975581

#### Review: Condition Number

Conditioning is a property of the problem, not the algorithm. An inaccurate solution is not necessarily due to an inaccurate algorithm, but may be inherent to the problem itself.

**Well-conditioned** or **insensitive** problems are those for which small relative changes in the input produce small relative changes in the output.
In **ill-conditioned** or **sensitive** problems, small relative changes in the input produce large relative changes in the output.

**(Relative) Condition Number** is the relative change in the output divided by the relative change in the input. 

**Absolute Condition Number**

$$
\kappa_{abs}(f, x) = \lvert f'(x) \rvert
$$

**Relative Condition Number**

$$
\kappa_{rel}(f, x) = \left\lvert \frac{x f'(x)}{f(x)} \right\rvert
$$

Condition number of an ill-posed problem is infinite. That is, $f$ is not
differentiable for some input.

:::card[example]
**Example (Condition Number).** Let $f(x) = \sqrt{x}$. Since $f'(x) = \dfrac{1}{2\sqrt{x}}$, we have:

$$
\kappa_{rel}(f, x) = \left\lvert \frac{x f'(x)}{f(x)} \right\rvert = \left\lvert \frac{x/(2\sqrt{x})}{\sqrt{x}} \right\rvert = \frac{1}{2}
$$

This means that a given relative change in the input causes a relative change in the output of about half as much.
::::

#### Stability and Accuracy

An algorithm is **stable** if errors in the input do not grow significantly during the computation. **Stability** measures the sensitivity of an algorithm to round-off and truncation errors.

Stability (of an algorithm) is analogous to conditioning (of a problem):
- Similarity: both relate to effects of perturbations.
- Distinction:
    - Stability refers to effects of _computational errors_ on the result computed by an algorithm.
    - Conditioning refers to effects of _data errors_ on the solution to the problem.

From the viewpoint of _backward error analysis_, an algorithm is stable if it produces a result that is close to the exact solution of a nearby problem.

An algorithm is **accurate** if $\hat{f}(x) = f(x)$ for all $x$ when computing with infinite precision. In other words, truncation error is zero.

#### Truncation Error

**Truncation error** concerns errors due to approximations in the algorithm. For example, when using Taylor series to approximate a function, truncation error is the difference between the exact function and the approximation.

$$
f(x + h) \approx g(h) = \sum\_{i=0}^{k} \frac{f^{(i)}(x)}{i!} h^i
$$

Then the absolute truncation error of the approximation is given by

$$
f(x + h) - g(h) = \sum\_{i=k+1}^{\infty} \frac{f^{(i)}(x)}{i!} h^i = \mathcal{O}(h^{k+1}) \text{ as } h \to 0
$$

#### Round-off Error

**Round-off error** concerns errors due to inexact representations of numbers. 

To study the propagation of round-off errors, we can use the notion of conditioning. The
condition number tells us the worst-case amplification of the error in the input to the error in the output. We usually want to consider the point of maximum amplification: $\kappa(f) = \max_{x \in \mathcal{X}} \kappa_{rel}(f, x)$.


#### 64-bit Floating Point Numbers

Bit Index (MSB → LSB):

  <table style="text-align: center;" >
    <tr class="bit-header">
      <td>63</td>
      <td colspan="11">62 - 52</td>
      <td colspan="52">51 - 0</td>
    </tr>
    <tr class="field-name">
      <td>S</td>
      <td colspan="11">Exponent (11 bits)</td>
      <td colspan="52">Fraction (52 bits)</td>
    </tr>
  </table>

Field Breakdown:
- S: Sign bit (0 = positive, 1 = negative)
- Exponent: Biased exponent (offset 1023)
- Fraction (Mantissa): Normalized significand (implicit leading 1)

Formula: $(-1)^S × 1.F × 2^{E - 1023}$

Special cases:
- All exponent bits 0 + fraction 0 → ±0
- All exponent bits 0 + nonzero fraction → subnormal
- All exponent bits 1 + fraction 0 → ±∞
- All exponent bits 1 + nonzero fraction → NaN

**Normal vs. Subnormal Numbers**

- **Normal numbers** have an **implicit leading 1** in the significand and a **non-zero exponent field** (1–2046). They follow the standard form:

  $$
  (\pm)\\,1.\text{fraction} \times 2^{e - 1023}
  $$

- **Subnormal (denormal) numbers** fill the gap near zero when the exponent field is **all zeros (0)**. They have no implicit leading 1:

  $$
  (\pm)\\,0.\text{fraction} \times 2^{-1022}
  $$

This allows gradual underflow toward zero, preserving precision for very small numbers.

:::card[example]

Some examples from [Wikipedia](https://en.wikipedia.org/wiki/Double-precision_floating-point_format):

| Hexadecimal Value        |                                   | Decimal Value / Note                                            |
|--------------------------|-----------------------------------|-----------------------------------------------------------------|
| 3FF0 0000 0000 0000    | $+2^{0}\times 1$                  | 1.0                                                             |
| 3FF0 0000 0000 0001    | $+2^{0}\times\bigl(1+2^{-52}\bigr)$ | 1.000 000 000 000 000 2220  <br/>(smallest number > 1)           |
| 3FF0 0000 0000 0002    | $+2^{0}\times\bigl(1+2^{-51}\bigr)$ | 1.000 000 000 000 000 4441                                       |
| 4000 0000 0000 0000    | $+2^{1}\times 1$                  | 2.0                                                             |
| C000 0000 0000 0000    | $-2^{1}\times 1$                  | −2.0                                                            |
| 4008 0000 0000 0000    | $+2^{1}\times 1.5\\;(1.1_{2})$     | 3.0                                                             |
| 3F88 0000 0000 0000    | $+2^{-7}\times 1.5\\;(1.1_{2})$    | 3 / 256                                         |
| 0000 0000 0000 0001    | $+2^{-1022}\times 2^{-52}=2^{-1074}$ | $4.940\cdots × 10^{-324}$ <br/>(smallest positive sub-normal) |
| 000F FFFF FFFF FFFF      | $+2^{-1022}\\!\times\\!\bigl(1-2^{-52}\bigr)$ | $2.225\cdots × 10^{-308}$  <br/>(largest sub-normal)     |
| 0010 0000 0000 0000      | $+2^{-1022}\times 1$              | $2.225\cdots × 10^{-308}$ <br/>(smallest positive normal) |
| 7FEF FFFF FFFF FFFF      | $+2^{1023}\\!\times\\!\bigl(2-2^{-52}\bigr)$ | $1.797\cdots × 10^{308}$ <br/>(largest normal)        |
| 0000 0000 0000 0000      |                                   |  +0                                                       |
| 8000 0000 0000 0000      |                                   | −0                                                              |
| 7FF0 0000 0000 0000      |                                   | +∞                                                              |
| FFF0 0000 0000 0000      |                                   | −∞                                                              |
| 7FF8 0000 0000 0001      |                                   | NaN                                                             |
::::

#### Preserving Relative Error

This is best characterized by **machine epsilon** ($\varepsilon_{\text{mach}}$), which is the best
quantification of the precision of the floating-point representation.

It is defined as the smallest positive number which, when added to 1.0, gives a result larger than 1.0 in the floating-point representation.

The relative error in floating-point arithmetic is at most $\varepsilon_{\text{mach}}$:

$$
\left\lvert \frac{\text{fl}(x) - x}{x} \right\rvert \leq \varepsilon\_{\text{mach}}
$$

:::card[example]
**Example.** In IEEE 754 double precision, machine epsilon is $\varepsilon = 2^{-52} \approx 2.22 \times 10^{-16}$.
::::

#### Rounding Error in Operations

For example, consider a scientfic notation system with 4 digits of precision. We want to add $2.103 \times 10^2$ and $7.620 \times 10^0$:

* First, we align the decimal points: 
  $2.103 \times 10^2$ and $0.07620 \times 10^2$.
* Then we add: $2.103 + 0.07620 = 2.17920 \times 10^2$.
* Finally, we round to 4 digits: $2.179 \times 10^2$.

In this method, adding $2.103 \times 10^2$ and $1 \times 10^{-6}$ would
effectively do nothing. Which is okay if we do it once. But assume we do it
$10^9$ times. Then we ignore all of these small changes, which add up to a large change.

:::card[example]
**Example.** We know that the harmonic series diverges:

$$
\sum_{i=1}^{n} \frac{1}{i} \to \infty
$$

But if we compute it using 32-bit floating point numbers, it converges to approximately $15.4037$.

::::

**Catastrophic cancellation** occurs when subtracting two nearly equal numbers, causing significant digits to cancel out. As a result, the result has analytically less precision.

:::card[example]
**Example.** When adding $2.103 \times 10^2$ and $-2.102 \times 10^2$, we get $
1.000 \times 10^{-1}$. But the 0s in the result are not reliable, as the significant digits in the inputs cancelled out.
::::

In general if $x + y$ is near 0, then addition is ill-conditioned.

#### Multiplication and Division

$$
\begin{align*}
\text{fl}(\text{fl}(x) \cdot \text{fl}(y)) - x y &\le (1 + \varepsilon)(x(1 + \varepsilon)) \cdot y(1 + \varepsilon) - x  y \\\\
&= x  y (1 + \varepsilon)^3 - x y \\\\
&\approx x y (1 + 3 \varepsilon) - x  y
\end{align*}
$$

So the relative error is at most $3 \varepsilon$. That is, $\kappa(x \cdot y) \leq 3$.


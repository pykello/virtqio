# CS 450 - Lecture 3

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_rdz5rdf3/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/02-lecture.pdf)

Some notes and examples are from:

* Heath, M. T. (2018). Scientific computing: An introductory survey (Revised Second Edition). SIAM. https://doi.org/10.1137/1.9781611975581

#### Vector Norms

A **vector norm** should satisfy:

- $norm(x) >= 0$
- $norm(x) = 0$ if and only if $x = 0$
- $norm(alpha x) = |alpha| norm(x)$ for all $alpha \in bb{R}$
- $norm(x + y) <= norm(x) + norm(y)$ (triangle inequality)

A norm is uniquely determined by its unit ball, which is the set of all vectors $x$ such that $norm(x) = 1$.

$p$-norms are defined as:

:::math
norm(x)_p = ( sum[i=1..n] |x_i|^p )^{1/p}
:::

- 1-norm: $norm(x)_1 = sum[i=1..n] |x_i|$. In 2D, the unit ball is a diamond.
- 2-norm: $norm(x)_2 = \sqrt{sum[i=1..n] |x_i|^2}$. In 2D, the unit ball is a circle.
- $inf$-norm: $norm(x)_inf = max[i=1..n] |x_i|$. In 2D, the unit ball is a square.

<div id="fig1" style="width:90%; max-width: 360px; aspect-ratio: 1 / 1; margin: 20px auto;"></div>

<script>
const board = JXG.JSXGraph.initBoard('fig1', {
    boundingbox: [-1.5, 1.5, 1.5, -1.5],
    axis: true,
    showNavigation: false,
    showCopyright: false,
    pan: {enabled: false},
    zoom: {enabled: false}
});

// Helper to create fixed, non-interactive points
function fixedPoint(coords) {
    return board.create('point', coords, {
        visible: false,
        fixed: true,
        frozen: true,
        highlight: false
    });
}

// L2 (Euclidean unit circle)
board.create('circle', [[0, 0], 1], {
    strokeColor: 'blue',
    dash: 0,
    strokeWidth: 2,
    fillColor: 'none',
    highlightFillColor: 'none',
    fixed: true,
    frozen: true,
    highlight: false
});

// L1 unit ball (diamond)
const l1Points = [
    [1, 0], [0, 1], [-1, 0], [0, -1], [1, 0]
].map(fixedPoint);

board.create('polygon', l1Points, {
    borders: {strokeColor: 'red', dash: 0, strokeWidth: 2},
    fillColor: 'none',
    highlightFillColor: 'none',
    fixed: true,
    frozen: true,
    highlight: false
});

// Linf unit ball (square)
const linfPoints = [
    [1, 1], [-1, 1], [-1, -1], [1, -1], [1, 1]
].map(fixedPoint);

board.create('polygon', linfPoints, {
    borders: {strokeColor: 'green', dash: 0, strokeWidth: 2},
    fillColor: 'none',
    highlightFillColor: 'none',
    fixed: true,
    frozen: true,
    highlight: false
});
</script>

<div style="text-align: center; margin-top: 10px; margin-bottom: 30px;">
    Unit balls:
    <span style="color: red;">1-norm (diamond)</span> |
    <span style="color: blue;">2-norm (circle)</span> |
    <span style="color: green;">∞-norm (square)</span>
</div>

In general, for any vector $v \in bb{R}^n$, we have:

:::math
norm(v)_1 >= norm(v)_2 >= norm(v)_inf
:::

We also have the following inequalities:
- $norm(v)_1 <= \sqrt{n} norm(v)_2$
- $norm(v)_2 <= \sqrt{n} norm(v)_inf$

So, any of these norms differ by at most a factor of a constant.

#### Inner-Product Spaces

**Inner-product** $\langle x, y \rangle$ should satisfy:

- $\langle x, x \rangle >= 0$
- $\langle x, x \rangle = 0$ if and only if $x = 0$
- $\langle x, y \rangle = \langle y, x \rangle$
- $\langle x, y + z \rangle = \langle x, y \rangle + \langle x, z \rangle$
- $\langle alpha x, y \rangle = alpha \langle x, y \rangle$ for all $alpha \in bb{R}$

**Cauchy-Schwarz Inequality**: $abs(\langle x, y \rangle) <= \sqrt{\langle x, x \rangle \langle y, y \rangle}$

For 2-norms, $abs(x^T y) <= norm(x)_2 norm(y)_2$.

#### Matrix Norms

A **matrix norm** should satisfy:

- $norm(A) >= 0$
- $norm(A) = 0$ if and only if $A = 0$
- $norm(alpha A) = |alpha| dot norm(A)$ for all $alpha \in bb{R}$
- $norm(A + B) <= norm(A) + norm(B)$ (triangle inequality)

**Frobenius norm**: $norm(A)_F = \sqrt{sum[i, j] a_{ij}^2}$

**Operator norm**: Maximum amplification of any input vector $x$ to $Ax$:

:::math
norm(A)_p = max[x != 0] \frac{norm(Ax)_p}{norm(x)_p} = max[x, norm(x)_p = 1] norm(Ax)_p
:::


:::card[example]

**Theorem** (from quiz 3): $norm(A)_inf$ is the maximum 1-norm of the rows of $A$.

**Proof**.

Assume $A$ is $n cross m$. Let $1 <= i <= n$ and $v \in bb{R}^m$ s.t. $norm(v)_inf = 1$.
Since $\max \\{|v_1|, ..., |v_m|\\} = 1$, we have

:::math
|(A dot v)_i| <= sum[j=1..m] |A_{i,j}| = norm(A_i)_1 \tag{1}
:::

Therefore,

:::math
norm(A)_inf <= \max\{norm(A_1)_1, ..., norm(A_n)_1\} \tag{2}
:::

Now, we show that a vector $v$ exists to make the equality happen.

Define vectors $v^1, ..., v^n$ such that $v^i_j = \text{sgn}(A_{i,j})$, where

:::math
\text{sgn}(x) = cases:
+1 \quad | x >= 0
-1 \quad | x < 0
:::

Then for all $1 <= i <= n$, $norm(v^i)_inf = 1$ and

:::math
(A dot v^i)_i = sum[j=1..m] |A_{i,j}| = norm(A_i)_1 \tag{3}
:::

Choose $k = \text{argmax}_{i=1}^n norm(A_i)_1$. In case there are multiple such $k$, choose any.

Then using (1) and (3),

:::math
norm(A dot v^k)_inf = norm(A_k)_1 = \max\{norm(A_1)_1, ..., norm(A_n)_1\} \tag{4}
:::

Using 2 and 4, we conclude that $norm(A)_inf$ is the maximum 1-norm of the rows of $A$.

::::

:::card[example]

**Theorem** (from quiz 3):

* $norm(A)_1$ is the maximum 1-norm of the columns of $A$.
* $norm(A^T)_1 = norm(A)_inf$.

::::


:::card[note]

**Note.** The following properties hold for norms induced by p-norms, but
may or may not hold for more general matrix norms:

- $norm(AB)_p <= norm(A)_p dot norm(B)_p$
- $norm(Ax)_p <= norm(A)_p dot norm(x)_p$

::::

**Example.** For the matrix

:::math
A = mat(1, 0, 3; -1, 2, 0; 4, 0, 1)
:::

we have:
:::math align
norm(A)_1 &= \max\{6, 2, 4\} = 6
norm(A)_inf &= \max\{4, 3, 5\} = 5
:::

2-norm is the largest singular value of $A$. We have:

:::math
A^T A = mat(18, -2, 7; -2, 4, 0; 7, 0, 10)
:::

Its eigenvalues are $lambda_1 \approx 22.22698, lambda_2 \approx 6.33655, lambda_3 \approx 3.43646$. So, $norm(A)_2 = \sqrt{lambda_1} \approx 4.71$.

#### Induced Matrix Norms

We defined $norm(A)_2 = max[norm(x)_2 = 1] norm(Ax)_2$.

Now, the question is what is $min[norm(x)_2 = 1] norm(Ax)_2$? If $A$ grows this direction the least, then $A^{-1}$ grows it the most.

So,

:::math
min[norm(x)_2 = 1] norm(Ax)_2 = \frac{1}{norm(A^{-1})_2}
:::

#### Matrix Condition Number

The **matrix condition number** bounds the worst-case amplification of the error in a matrix-vector product.

Let $x$ be a unit vector, and add some error $del x$ to it. In the worst
case, $x$ is in the direction of the minimum amplification of $A$, and $del x$ is in the direction of the maximum amplification of $A$. That is, the solution shrinks and the error grows.

We want the condition number to capture this worst-case amplification of the error. So, we define it as: $kappa(A) = norm(A)\ dot norm(A^{-1})$. That is, the ratio of the maximum amplification to the minimum amplification.


By definition, $kappa(A) >= 1$.

If $Q$ is square and $kappa(Q) = 1$ and $norm(Q) = 1$, then $Q$ is orthogonal. That is, $Q^TQ = I$. If $Q$ is orthogonal, then for all $v$, $norm(Qv)_2 = norm(v)_2$.


:::card[example]
**Example** (from quiz 3):

:::math align
kappa(2A) &= norm(2A) dot norm((2A)^{-1})
&= 2 norm(A) dot \frac{1}{2} norm(A^{-1})
&= kappa(A)
:::

::::

The condition number is a measure of how close a matrix is to being singular. If $kappa(A)$ is large, then $A$ is close to being singular. Whereas if $kappa(A)$ is close to 1, then $A$ is far from being singular.

From the definition, $kappa(A) = kappa(A^{-1})$. This means that if $A$ is
close to being singular, then $A^{-1}$ is equally close to being singular.

#### Condition Number Estimation

The matrix norm $norm(A)$ is easily calculated as the maximum absolute
column sum or row sum, depending on the norm used. However, calculating $norm(A^{-1})$ is more difficult.

If $z$ is a solution to $Az = y$, then

:::math
norm(z) = norm(A^{-1} y) <= norm(A^{-1}) norm(y)
:::

Therefore,

:::math
\frac{norm(z)}{norm(y)} <= norm(A^{-1})
:::

Thus maximizing $\dfrac{norm(z)}{norm(y)}$ gives a reasonable estimate of $norm(A^{-1})$.

Finding such a maximum can be expensive. One strategy is to try few random
vectors and take the maximum $\dfrac{norm(z)}{norm(y)}$.

#### Singular Value Decomposition (SVD)

Any matrix $A$ can be decomposed as $A = U Sigma V^T$, where $U$ and $V$ are orthogonal matrices and $Sigma$ is a diagonal matrix with non-negative entries.

If $A$ is invertible, then $A^{-1} = V Sigma^{-1} U^T$.

Let $sigma_{max}=sigma_1, sigma_2, ..., sigma_n=sigma_{min}$ be diagonal entries of $Sigma$ sorted in descending order. Then $norm(A)_2 = sigma_{max}$ and $norm(A^{-1})_2 = \dfrac{1}{sigma_{min}}$.

Therefore, $kappa(A) = \dfrac{sigma_{max}}{sigma_{min}}$.

:::card[example]
**Example.** Prove that if $kappa_2(A) = 1$ where $A$ is $n cross n$, then $A=alpha Q$ for some orthogonal $Q$ and scalar $alpha$.

**Proof.**

Since $kappa_2(A) = 1$, then

:::math
norm(A)_2 = \dfrac{1}{norm(A^{-1})}_2 \tag{5}
:::

Consider the SVD of $A$: $A = U Sigma V^T$, where $Sigma = \text{diag}(sigma_{max}, ..., sigma_{min})$.
Then $norm(A)_2 = sigma_{max}$ and $norm(A^{-1})_2 = \dfrac{1}{sigma_{min}}$.
Putting this together with (5), we have $sigma_{max} = sigma_{min}$.
Therefore, all singular values are equal. Let $alpha$ be the value of singular values. Then, $Sigma = alpha I$.

Then:

:::math align
A &= U Sigma V^T
&= U dot (alpha I) dot V^T
&= alpha U V^T
:::

Since $U$ and $V^T$ are orthogonal, then $U V^T$ is also orthogonal. So, $A=alpha Q$ for some scalar $alpha$ and orthogonal $Q$.

::::


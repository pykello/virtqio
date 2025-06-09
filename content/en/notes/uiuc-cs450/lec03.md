# CS 450 - Lecture 3

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_rdz5rdf3/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/02-lecture.pdf)

#### Vector Norms

A **vector norm** should satisfy:

- $\lVert x \rVert \ge 0$
- $\lVert x \rVert = 0$ if and only if $x = 0$
- $\lVert \alpha x \rVert = |\alpha| \lVert x \rVert$ for all $\alpha \in \mathbb{R}$
- $\lVert x + y \rVert \le \lVert x \rVert + \lVert y \rVert$ (triangle inequality)

A norm is uniquely determined by its unit ball, which is the set of all vectors $x$ such that $\lVert x \rVert = 1$.

$p$-norms are defined as:

$$
\lVert x \rVert\_p = \left( \sum\_{i=1}^n |x_i|^p \right)^{1/p}
$$

- 1-norm: $\lVert x \rVert\_1 = \sum\_{i=1}^n |x_i|$. In 2D, the unit ball is a diamond.
- 2-norm: $\lVert x \rVert\_2 = \sqrt{\sum\_{i=1}^n |x_i|^2}$. In 2D, the unit ball is a circle.
- $\infty$-norm: $\lVert x \rVert\_\infty = \max\_{i=1}^n |x_i|$. In 2D, the unit ball is a square.

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

In general, for any vector $v \in \mathbb{R}^n$, we have:

$$
\lVert v \rVert\_1 \ge \lVert v \rVert\_2 \ge \lVert v \rVert\_\infty
$$

We also have the following inequalities:
- $\lVert v \rVert\_1 \le \sqrt{n} \lVert v \rVert\_2$
- $\lVert v \rVert\_2 \le \sqrt{n} \lVert v \rVert\_\infty$

So, any of these norms differ by at most a factor of a constant.

#### Inner-Product Spaces

**Inner-product** $\langle x, y \rangle$ should satisfy:

- $\langle x, x \rangle \ge 0$
- $\langle x, x \rangle = 0$ if and only if $x = 0$
- $\langle x, y \rangle = \langle y, x \rangle$
- $\langle x, y + z \rangle = \langle x, y \rangle + \langle x, z \rangle$
- $\langle \alpha x, y \rangle = \alpha \langle x, y \rangle$ for all $\alpha \in \mathbb{R}$

**Cauchy-Schwarz Inequality**: $\lvert \langle x, y \rangle \rvert \le \sqrt{\langle x, x \rangle \langle y, y \rangle}$

For 2-norms, $\lvert x^T y \rvert \le \lVert x \rVert\_2 \lVert y \rVert\_2$.

#### Matrix Norms

A **matrix norm** should satisfy:

- $\lVert A \rVert \ge 0$
- $\lVert A \rVert = 0$ if and only if $A = 0$
- $\lVert \alpha A \rVert = |\alpha| \cdot \lVert A \rVert$ for all $\alpha \in \mathbb{R}$
- $\lVert A + B \rVert \le \lVert A \rVert + \lVert B \rVert$ (triangle inequality)

**Frobenius norm**: $\lVert A \rVert\_F = \sqrt{\sum_{i, j} a_{ij}^2}$

**Operator norm**: Maximum amplification of any input vector $x$ to $Ax$:

$$
\lVert A \rVert\_p = \max_{x \neq 0} \frac{\lVert Ax \rVert\_p}{\lVert x \rVert\_p} = \max_{x, \lVert x \rVert\_p = 1} \lVert Ax \rVert\_p
$$


:::card[example]

**Theorem** (from quiz 3): $\lVert A \rVert\_\infty$ is the maximum 1-norm of the rows of $A$.

**Proof**.

Assume $A$ is $n \times m$. Let $1 \le i \le n$ and $v \in \mathbb{R}^m$ s.t. $\lVert v \rVert\_\infty = 1$.
Since $\max \\{|v_1|, \ldots, |v_m|\\} = 1$, we have

$$
|(A \cdot v)\_i| \le \sum_{j=1}^m |A_{i,j}| = \lVert A_i \rVert\_1 \tag{1}
$$

Therefore,

$$
\lVert A \rVert\_\infty \le \max\\{\lVert A_1 \rVert\_1, \ldots, \lVert A_n \rVert\_1\\} \tag{2}
$$

Now, we show that a vector $v$ exists to make the equality happen.

Define vectors $v^1, \ldots, v^n$ such that $v^i\_j = \text{sgn}(A_{i,j})$, where

$$
\text{sgn}(x) = \begin{cases}
+1 \quad &x \ge 0 \\\\
-1 \quad &x < 0
\end{cases}
$$

Then for all $1 \le i \le n$, $\lVert v^i \rVert\_\infty = 1$ and

$$
(A \cdot v^i)_i = \sum\_{j=1}^m |A\_{i,j}| = \lVert A_i \rVert\_1 \tag{3}
$$

Choose $k = \text{argmax}_{i=1}^n \lVert A_i \rVert\_1$. In case there are multiple such $k$, choose any.

Then using (1) and (3),

$$
\lVert A \cdot v^k \rVert\_\infty = \lVert A_k \rVert\_1 = \max\\{\lVert A_1 \rVert\_1, \ldots, \lVert A_n \rVert\_1\\} \tag{4}
$$

Using 2 and 4, we conclude that $\lVert A \rVert\_\infty$ is the maximum 1-norm of the rows of $A$.

::::

:::card[example]

**Theorem** (from quiz 3):

* $\lVert A \rVert\_1$ is the maximum 1-norm of the columns of $A$.
* $\lVert A^T \rVert\_1 = \lVert A \rVert\_\infty$.

::::


:::card[note]

**Note.** The following properties hold for norms induced by p-norms, but 
may or may not hold for more general matrix norms:

- $\lVert AB \rVert\_p \le \lVert A \rVert\_p \cdot \lVert B \rVert\_p$
- $\lVert Ax \rVert\_p \le \lVert A \rVert\_p \cdot \lVert x \rVert\_p$

::::

**Example.** For the matrix

$$
A = \begin{bmatrix}
1 & 0 & 3 \\\\
-1 & 2 & 0 \\\\
4 & 0 & 1
\end{bmatrix}
$$

we have:
$$
\begin{align*}
\lVert A \rVert\_1 &= \max\\{6, 2, 4\\} = 6 \\\\
\lVert A \rVert\_\infty &= \max\\{4, 3, 5\\} = 5
\end{align*}
$$

2-norm is the largest singular value of $A$. We have:

$$
A^T A = \begin{bmatrix}
18 & -2 & 7 \\\\
-2 & 4 & 0 \\\\
7 & 0 & 10
\end{bmatrix}
$$

Its eigenvalues are $\lambda_1 \approx 22.22698, \lambda_2 \approx 6.33655, \lambda_3 \approx 3.43646$. So, $\lVert A \rVert\_2 = \sqrt{\lambda_1} \approx 4.71$.

#### Induced Matrix Norms

We defined $\lVert A \rVert\_2 = \max_{\lVert x \rVert\_2 = 1} \lVert Ax \rVert\_2$.

Now, the question is what is $\min_{\lVert x \rVert\_2 = 1} \lVert Ax \rVert\_2$? If $A$ grows this direction the least, then $A^{-1}$ grows it the most.

So,

$$
\min_{\lVert x \rVert\_2 = 1} \lVert Ax \rVert\_2 = \frac{1}{\lVert A^{-1} \rVert\_2}
$$

#### Matrix Condition Number

The **matrix condition number** bounds the worst-case amplification of the error in a matrix-vector product.

Let $x$ be a unit vector, and add some error $\delta x$ to it. In the worst
case, $x$ is in the direction of the minimum amplification of $A$, and $\delta x$ is in the direction of the maximum amplification of $A$. That is, the solution shrinks and the error grows.

We want the condition number to capture this worst-case amplification of the error. So, we define it as: $\kappa(A) = \lVert A \rVert\ \cdot \lVert A^{-1} \rVert$. That is, the ratio of the maximum amplification to the minimum amplification.


By definition, $\kappa(A) \ge 1$.

If $Q$ is square and $\kappa(Q) = 1$ and $\lVert Q \rVert = 1$, then $Q$ is orthogonal. That is, $Q^TQ = I$. If $Q$ is orthogonal, then for all $v$, $\lVert Qv \rVert\_2 = \lVert v \rVert\_2$.


:::card[example]
**Example** (from quiz 3):

$$
\begin{align*}
\kappa(2A) &= \lVert 2A \rVert \cdot \lVert (2A)^{-1} \rVert \\\\
&= 2 \lVert A \rVert \cdot \frac{1}{2} \lVert A^{-1} \rVert \\\\
&= \kappa(A)
\end{align*}
$$

::::

#### Singular Value Decomposition (SVD)

Any matrix $A$ can be decomposed as $A = U \Sigma V^T$, where $U$ and $V$ are orthogonal matrices and $\Sigma$ is a diagonal matrix with non-negative entries.

If $A$ is invertible, then $A^{-1} = V \Sigma^{-1} U^T$.

Let $\sigma\_{max}=\sigma_1, \sigma_2, \ldots, \sigma\_n=\sigma_{min}$ be diagonal entries of $\Sigma$ sorted in descending order. Then $\lVert A \rVert\_2 = \sigma\_{max}$ and $\lVert A^{-1} \rVert\_2 = \dfrac{1}{\sigma\_{min}}$.

Therefore, $\kappa(A) = \dfrac{\sigma\_{max}}{\sigma\_{min}}$.

:::card[example]
**Example.** Prove that if $\kappa\_2(A) = 1$ where $A$ is $n \times n$, then $A=\alpha Q$ for some orthogonal $Q$ and scalar $\alpha$.

**Proof.**

Since $\kappa\_2(A) = 1$, then

$$
\lVert A \rVert\_2 = \dfrac{1}{\lVert A^{-1} \rVert}\_2 \tag{5}
$$

Consider the SVD of $A$: $A = U \Sigma V^T$, where $\Sigma = \text{diag}(\sigma_{max}, \ldots, \sigma_{min})$.
Then $\lVert A \rVert\_2 = \sigma\_{max}$ and $\lVert A^{-1} \rVert\_2 = \dfrac{1}{\sigma\_{min}}$.
Putting this together with (5), we have $\sigma\_{max} = \sigma\_{min}$.
Therefore, all singular values are equal. Let $\alpha$ be the value of singular values. Then, $\Sigma = \alpha I$.

Then:

$$
\begin{align*}
A &= U \Sigma V^T \\\\
&= U \cdot (\alpha I) \cdot V^T \\\\
&= \alpha U V^T
\end{align*}
$$

Since $U$ and $V^T$ are orthogonal, then $U V^T$ is also orthogonal. So, $A=\alpha Q$ for some scalar $\alpha$ and orthogonal $Q$.

::::


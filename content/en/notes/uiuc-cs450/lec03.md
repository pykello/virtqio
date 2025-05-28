# CS 450 - Lecture 3

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_rdz5rdf3/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/heath/chap02.pdf)

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

(stopped at 27:48. to be continued ...)

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

(stopped at 32:26. to be continued ...)

<script>
const offset = -50;

function iso(x, y, z) {
    return [
        x - y / Math.SQRT2 + offset,
        -y / Math.SQRT2 + z
    ];
}

function initBoard(divId) {
  const brd = JXG.JSXGraph.initBoard(divId, {
      boundingbox: [-160, 160, 160 + offset, -160 - offset],
      axis:false, showcopyright:false, shownavigation:false
  });

  const O = brd.create('point', [offset, 0], {visible:false});

  function axisArrow(vec, label, offset) {
     const end = brd.create('point', iso(...vec), {visible:false});
     const len = Math.sqrt(vec[0]**2 + vec[1]**2 + vec[2]**2);
     const unit = vec.map(v => v / len);
     const labelVec = unit.map(v => v * (len + offset));
     const labelPos = iso(...labelVec);
     brd.create('arrow', [O, end], {strokeWidth:2});
     brd.create('text', [...labelPos, label], {fontSize:14});
  }

  axisArrow([140,   0,   0], 'x', 10);
  axisArrow([  0, 100,   0], 'y', 5);
  axisArrow([  0,   0, 140], 'z', 10);

  return brd;
}
</script>
# Surface Integrals and Divergence

### Gauss's Law
Goal: A convenient way to find the **electorstatic field**.

Doesn't equations in last section already solve this? Generally, no. Unless
we have very few charges and/or they are arrange simply or symmetrically.
So, they're not very useful in practice.

Which brings us to **Gauss's Law**:

$$
\int\int_S \mathbf{E} \cdot \hat{\mathbf{n}} \\, dS = \frac{q}{\epsilon_0}
\tag{II-1}
$$

Here we are doing a **surface integral**, where integrand is the dot product
of the electric field $\mathbf{E}$ and the unit normal vector $\hat{\mathbf{n}}$.

We'll discuss these in the following sections.

### The Unit Normal Vector
Let $\mathbf{u}$ and $\mathbf{v}$ be two non-collinear tangent vectors to a surface $S$ at a point $P$. A vector $\mathbf{N}$ perpendicular to both $\mathbf{u}$ and $\mathbf{v}$ is called a **normal vector** to $S$ at $P$.

Cross product of $\mathbf{u}$ and $\mathbf{v}$ has this property. Thus:

$$
\mathbf{\hat{n}} = \frac{\mathbf{N}}{|\mathbf{N}|} 
= \frac{\mathbf{u} \times \mathbf{v}}{|\mathbf{u} \times \mathbf{v}|}
$$

Assume $S$ is given by the equation $z = f(x, y)$. Then parametric equation
of $S$ is $\mathbf{s}(x, y) = (x, y, f(x, y))$.

Let $x$-curve be given when we hold $y$ constant and vary $x$:
$\mathbf{s}(x, y_0) = (x, y_0, f(x, y_0))$.
Let $y$-curve be given when we hold $x$ constant and vary $y$:
$\mathbf{s}(x_0, y) = (x_0, y, f(x_0, y))$.

Then the tangent at point $P$ to the $x$-curve is $\mathbf{s}_x = \dfrac{\partial \mathbf{s}}{\partial x} = (1, 0, \dfrac{\partial f}{\partial x})$, and the tangent at point $P$ to the $y$-curve is $\mathbf{s}_y = \dfrac{\partial \mathbf{s}}{\partial y} = (0, 1, \dfrac{\partial f}{\partial y})$.

The normal vector is given by $\mathbf{N} = \mathbf{s}_x \times \mathbf{s}_y$.

Thus, the unit normal vector is given by:

$$
\begin{align*}
\mathbf{\hat{n}} = \frac{\mathbf{s}_x \times \mathbf{s}_y}{|\mathbf{s}_x \times \mathbf{s}_y|}
&= \frac{\left(1, 0, \dfrac{\partial f}{\partial x}\right) \times \left(0, 1, \dfrac{\partial f}{\partial y}\right)}{|\mathbf{s}_x \times \mathbf{s}_y|}
\\\\[1em]
&= \frac{-\mathbf{i}\dfrac{\partial f}{\partial x} + -\mathbf{j}\dfrac{\partial f}{\partial y} + \mathbf{k}}{\sqrt{1 + \left(\dfrac{\partial f}{\partial x}\right)^2 + \left(\dfrac{\partial f}{\partial y}\right)^2}}
\tag{II-4}
\end{align*}
$$

> [!WARNING]
> My derivation is a bit different from the book, but the steps are 
> equivalent and the final result is the same.

### Definition of Surface Integrals
The **surface integral of the normal component** of a vector function $\mathbf{F}(x, y, z)$, denoted by

$$
\int\int_S \mathbf{F} \cdot \hat{\mathbf{n}} \\, dS
\tag{II-5}
$$

Let's approaximate $S$ by a collection of small flat pieces, each of which is
tangent to $S$ at some point.

Let's focus on the $i$-th piece. Let $\Delta S_i$ be the area, and $(x_i, y_i, z_i)$ be the coordinate of the tangent point, and $\hat{\mathbf{n}}_i$ be the unit normal vector at that point.

Then summing over all pieces, we have:

$$
\sum_{i=1}^N \mathbf{F}(x_i, y_i, z_i) \cdot \hat{\mathbf{n}}_i \Delta S_i
$$

The surface integral (II-5) is the limit of this sum as the number of pieces
approaches infinity and the area of each piece approaches zero:

$$
\int\int_S \mathbf{F} \cdot \hat{\mathbf{n}} \\, dS = \lim_{\substack{N \to \infty\\\\[0.3em] \text{each } \Delta S_i \to 0}} \sum_{i=1}^N \mathbf{F}(x_i, y_i, z_i) \cdot \hat{\mathbf{n}}_i \Delta S_i
\tag{II-6}
$$

The surface over which we integrate can be:
* **closed**, which divides the space into two regions, inside and outside. For
  example, the surface of a sphere.
* **open**, a surface which is not closed. For example, a flat piece of paper.

In the case of an open surface, the unit normal vector can point in either direction, and it should be specified. In the case of a closed surface, the agreement is that the unit normal vector points outward from the surface.

The integral in **Gauss's Law** is taken over a closed surface. In fact, it says that the surface integral of the electric field over a closed surface is equal to the total charge inside the surface divided by $\epsilon_0$.

Sometimes, we are interested in simpler integrals of the form:

$$
\int\int_S G(x, y, z) \\, dS
\tag{II-7}
$$

This can be solved similarly:

$$
\int\int_S G(x, y, z) \\, dS = \lim_{\substack{N \to \infty\\\\[0.3em] \text{each } \Delta S_i \to 0}} \sum_{i=1}^N G(x_i, y_i, z_i) \Delta S_i
\tag{II-8}
$$

### Evaluating Surface Integrals

We want to evaluate:

$$
\int\int_S G(x, y, z) \\, dS
$$

Our strategy is to relate $\Delta S_i$ to the area of its projection on the $xy$-plane, as shown in the figure below.

<div id="fig12" style="width:90%; max-width: 360px; aspect-ratio: 1 / 1; margin: 20px auto;"></div>

<script>
  const brd = initBoard('fig12');    

  const va = [0, 90];
  const v1 = [12, 90];
  const v2 = [62, 90];
  const v3 = [74, 90];
  const ellipse = brd.create('ellipse', [v1, v2, v3], {strokeWidth:2});

  const vb = [0, -30];
  const v4 = [6, -30];
  const v5 = [68, -30];
  const v6 = [74, -30];
  const ellipse2 = brd.create('ellipse', [v4, v5, v6], {strokeWidth:2});

  brd.create('segment', [v3, v6], {strokeWidth:2, dash:2});
  brd.create('segment', [va, vb], {strokeWidth:2, dash:2});
  brd.create('text', [30, 90, 'ΔS_i'], {fontSize:16});
  brd.create('text', [30, -30, 'ΔR_i'], {fontSize:16});
</script>

This will also us to use ordinary double integrals over $R$, the projection of $S$ on the $xy$-plane.
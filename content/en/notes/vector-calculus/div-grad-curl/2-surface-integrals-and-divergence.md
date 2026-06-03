# Surface Integrals and the Divergence
<script>
const offset = -50;

function iso(x, y, z) {
    return [
        y - x / Math.SQRT2 + offset,
        -x / Math.SQRT2 + z
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
     brd.create('arrow', [O, end], {
        strokeWidth:2,
        strokeColor:'gray',
        opacity:0.8
    });
     brd.create('text', [...labelPos, label], {fontSize:14});
  }

  axisArrow([140,   0,   0], 'x', 10);
  axisArrow([  0, 140,   0], 'y', 5);
  axisArrow([  0,   0, 140], 'z', 10);

  return brd;
}
</script>

### Gauss's Law
Goal: A convenient way to find the **electrostatic field**.

Doesn't equations in last section already solve this? Generally, no. Unless
we have very few charges and/or they are arrange simply or symmetrically.
So, they're not very useful in practice.

Which brings us to **Gauss's Law**:

:::math
iint[S] v{E} dot unit{n} \, dS = \frac{q}{eps_0}
\qquad\text{(II-1)}
:::

Here we are doing a **surface integral**, where integrand is the dot product
of the electric field $v{E}$ and the unit normal vector $unit{n}$.

We'll discuss these in the following sections.

### The Unit Normal Vector
Let $v{u}$ and $v{v}$ be two non-collinear tangent vectors to a surface $S$ at a point $P$. A vector $v{N}$ perpendicular to both $v{u}$ and $v{v}$ is called a **normal vector** to $S$ at $P$.

Cross product of $v{u}$ and $v{v}$ has this property. Thus:

:::math
unit{n} = \frac{v{N}}{|v{N}|}
= \frac{v{u} cross v{v}}{|v{u} cross v{v}|}
:::

Assume $S$ is given by the equation $z = f(x, y)$. Then parametric equation
of $S$ is $v{s}(x, y) = (x, y, f(x, y))$.

Let $x$-curve be given when we hold $y$ constant and vary $x$:
$v{s}(x, y_0) = (x, y_0, f(x, y_0))$.
Let $y$-curve be given when we hold $x$ constant and vary $y$:
$v{s}(x_0, y) = (x_0, y, f(x_0, y))$.

Then the tangent at point $P$ to the $x$-curve is $v{s}_x = pd(v{s}, x) = (1, 0, pd(f, x))$, and the tangent at point $P$ to the $y$-curve is $v{s}_y = pd(v{s}, y) = (0, 1, pd(f, y))$.

The normal vector is given by $v{N} = v{s}_x cross v{s}_y$.

Thus, the unit normal vector is given by:

:::math align
unit{n} = \frac{v{s}_x cross v{s}_y}{|v{s}_x cross v{s}_y|} &= \frac{(1, 0, pd(f, x)) cross (0, 1, pd(f, y))}{|v{s}_x cross v{s}_y|}
&= \frac{-v{i}pd(f, x) + -v{j}pd(f, y) + v{k}}{\sqrt{1 + (pd(f, x))^2 + (pd(f, y))^2}} \qquad\text{(II-4)}
:::

> [!WARNING]
> My derivation is a bit different from the book, but the steps are
> equivalent and the final result is the same.

### Definition of Surface Integrals
The **surface integral of the normal component** of a vector function $v{F}(x, y, z)$, denoted by

:::math
iint[S] v{F} dot unit{n} \, dS
\qquad\text{(II-5)}
:::

Let's approximate $S$ by a collection of small flat pieces, each of which is
tangent to $S$ at some point.

Let's focus on the $i$-th piece. Let $Delta S_i$ be the area, and $(x_i, y_i, z_i)$ be the coordinate of the tangent point, and $unit{n}_i$ be the unit normal vector at that point.

Then summing over all pieces, we have:

:::math
sum[i=1..N] v{F}(x_i, y_i, z_i) dot unit{n}_i Delta S_i
:::

The surface integral (II-5) is the limit of this sum as the number of pieces
approaches infinity and the area of each piece approaches zero:

:::math plain
iint[S] v{F} dot unit{n} \, dS = \lim_{\substack{N -> inf\\[0.3em] \text{each } Delta S_i -> 0}} sum[i=1..N] v{F}(x_i, y_i, z_i) dot unit{n}_i Delta S_i
\qquad\text{(II-6)}
:::

The surface over which we integrate can be:
* **closed**, which divides the space into two regions, inside and outside. For
  example, the surface of a sphere.
* **open**, a surface which is not closed. For example, a flat piece of paper.

In the case of an open surface, the unit normal vector can point in either direction, and it should be specified. In the case of a closed surface, the agreement is that the unit normal vector points outward from the surface.

The integral in **Gauss's Law** is taken over a closed surface. In fact, it says that the surface integral of the electric field over a closed surface is equal to the total charge inside the surface divided by $eps_0$.

Sometimes, we are interested in simpler integrals of the form:

:::math
iint[S] G(x, y, z) \, dS
\qquad\text{(II-7)}
:::

This can be solved similarly:

:::math plain
iint[S] G(x, y, z) \, dS = \lim_{\substack{N -> inf\\[0.3em] \text{each } Delta S_i -> 0}} sum[i=1..N] G(x_i, y_i, z_i) Delta S_i
\qquad\text{(II-8)}
:::

### Evaluating Surface Integrals

We want to evaluate:

:::math
iint[S] G(x, y, z) \, dS
:::

Our strategy is to relate $Delta S_i$ to the area of its projection on the $xy$-plane, as shown in the figure below.

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
  brd.create('text', [30, 90, '$\Delta S_i$'], {fontSize:16});
  brd.create('text', [30, -30, '$\Delta R_i$'], {fontSize:16});
</script>

This will allow us to use ordinary double integrals over $R$, the projection of $S$ on the $xy$-plane.

We want to find the relation between the area of rectangle
and area of its projection in the $xy$-plane.

Assume one pair of sides are parallel to the $xy$-plane, and the other pair makes angle $theta$ with the $xy$-plane.

<div id="fig14" style="width:90%; max-width: 360px; aspect-ratio: 1 / 1; margin: 20px auto;"></div>

<script>
{
    const brd2 = initBoard('fig14');

    const boarderColor = '#0077b6';
    function edge(p1, p2, width= 2, dash=0) {
        return brd2.create('segment',
            [p1, p2],
            {strokeWidth: width, strokeColor: boarderColor, layer: 20, dash: dash}
        );
    }

    const fillColor = '#fff3b0';
    function face(p1, p2, p3, p4) {
        brd2.create('polygon',
            [p1, p2, p3, p4],
            {
                vertices: {visible: false},
                borders: {strokeWidth: 2},
                fillOpacity: 0.8,
                fillColor: fillColor,
                layer: 10
            }
        );
    }

    function arc(p1, p2, p3) {
        brd2.create('arc', [
            brd2.create('point', p1, {visible: false}),
            brd2.create('point', p2, {visible: false}),
            brd2.create('point', p3, {visible: false}),
        ], {
            strokeWidth: 2,
            strokeColor: boarderColor,
            fillOpacity: 0.8,
            fillColor: fillColor,
            layer: 20
        });
    }

    function midpoint(p1, p2, r) {
        return [
            p2[0] * r + p1[0] * (1 - r),
            p2[1] * r + p1[1] * (1 - r)
        ];
    }

    function add(p1, delta) {
        return [
            p1[0] + delta[0],
            p1[1] + delta[1],
        ];
    }

    const x1 = 40;
    const y1 = 80;
    const x2 = 130;
    const y2 = 140;
    const z1 = 130;
    const z2 = 80;

    const p1 = iso(x1, y1, z1);
    const p2 = iso(x1, y2, z1);
    const p3 = iso(x2, y2, z2);
    const p4 = iso(x2, y1, z2);
    const p5 = iso(x1, y1, 0);
    const p6 = iso(x1, y2, 0);
    const p7 = iso(x2, y2, 0);
    const p8 = iso(x2, y1, 0);

    const c1 = iso((x1 + x2) * 0.55, (y1 + y2) / 2, (z1 + z2) / 2);
    const c2 = iso((x1 + x2) * 0.55, (y1 + y2) / 2, 200);
    const c3 = iso((x1 + x2) * 0.55 + 30, (y1 + y2) / 2, 200);

    face(p1, p2, p3, p4);
    face(p2, p6, p7, p3);
    face(p3, p7, p8, p4);

    edge(p1, p2);
    edge(p2, p3);
    edge(p3, p4);
    edge(p4, p1);
    edge(p2, p6);
    edge(p3, p7);
    edge(p4, p8);
    edge(p6, p7);
    edge(p7, p8);

    edge(p1, p5, 1, 2);
    edge(p5, p6, 1, 2);
    edge(p5, p8, 1, 2);

    edge(p3, iso(x2 - 60, y2, z2));

    arc(p3, iso(x2 - 40, y2, z2), midpoint(p3, p2, 0.25));

    brd2.create('arrow', [c1, c2], {
        strokeWidth: 2,
        strokeColor: boarderColor,
        fillOpacity: 0.8,
        fillColor: fillColor,
        layer: 20
    });
    brd2.create('arrow', [c1, c3], {
        strokeWidth: 2,
        strokeColor: boarderColor,
        fillOpacity: 0.8,
        fillColor: fillColor,
        layer: 20
    });

    arc(c1, midpoint(c1, c2, 0.5), midpoint(c1, c3, 0.5));

    brd2.create('text', [26, 30, 'θ'], {fontSize: 16});
    brd2.create('text', [-17, 100, 'θ'], {fontSize: 16});
    brd2.create('text', [c2[0] - 2, c2[1] + 8, '$\\hat{\\mathbf{k}}$'], {fontSize: 16});
    brd2.create('text', [c3[0] - 5, c3[1] + 8, '$\\hat{\\mathbf{n}}$'], {fontSize: 16});

    brd2.create('text', [
        ...add(midpoint(p4, p1, 0.3), [0, 30])
        , 'b'], {fontSize: 16});

    brd2.create('text', [
        ...add(midpoint(p4, p3, 0.5), [0, 10])
        , 'a'], {fontSize: 16});

    brd2.create('text', [
        ...add(midpoint(p8, p5, 0.3), [0, 20])
        , "b'"], {fontSize: 16});

    brd2.create('text', [
        ...add(midpoint(p8, p7, 0.5), [0, 10])
        , "a"], {fontSize: 16});
}
</script>

We can convince ourselves that $\cos theta = unit{k} dot unit{n}$, where $unit{k}$ is the unit normal vector to the $xy$-plane.

Thus, the area of the rectangle is:

:::math
ab = \frac{ab'}{\cos theta} = \frac{ab'}{unit{k} dot unit{n}}
:::

Each $Delta S_i$ can be approximated by such rectangles. Thus, we have:

:::math
Delta S_i = \frac{Delta R_i}{unit{k} dot unit{n}}
:::

So, the surface integral can be written as:

:::math plain
iint[S] G(x, y, z) \, dS = \lim_{\substack{N -> inf\\[0.3em] \text{each } Delta R_i -> 0}} sum[i=1..N] G(x_i, y_i, z_i) \frac{Delta R_i}{unit{k} dot unit{n}}
\qquad\text{(II-9)}
:::

Where we have replaced each $Delta S_i -> 0$ with $Delta R_i -> 0$.

Then, this can be written as a double integral over $R$:

:::math
iint[S] G(x, y, z) \, dS =
iint[R] \frac{G(x, y, f(x, y))}{unit{k} dot unit{n}(x, y, f(x, y))} \, dx \, dy
\qquad\text{(II-11)}
:::

Using equation (II-4), we can write:

:::math
unit{k} dot unit{n}(x, y, f(x, y)) = \frac{1}{\sqrt{1 + (pd(f, x))^2 + (pd(f, y))^2}}
:::

Thus, we have:

:::math align
iint[S] G(x, y, z) \, dS = &iint[R] G(x, y, f(x, y)) dot
&\sqrt{1 + (pd(f, x))^2 + (pd(f, y))^2} \, dx \, dy \qquad\text{(II-12)}
:::

:::card[example]
**Example.** Find $iint[S] z \, dS$, where $S$ is the portion of the plane $x + y + z = 1$ in the first octant.

Here $f(x, y) = 1 - x - y$, so we have:

:::math
iint[S] z \, dS = int[0..1] int[0..1 - x] z (\sqrt{1 + (-1)^2 + (-1)^2}
) \, dy \, dx = \dfrac{\sqrt{3}}{6}
:::
::::

### Flux
The **flux** of $v{F}$ through the surface $S$:

:::math
iint[S] v{F}(x, y, z) dot unit{n} \, dS
\qquad\text{(II-14)}
:::

So, Gauss's Law says that the flux of the electrostatic field over a closed surface
is equal to the total charge inside the surface divided by $eps_0$.

### Using Gauss's Law to Find the Field

Consider a point charge $q$ at the origin. Symmetry suggests
the following about the electric field:

- It must be in the radial direction,
- It must have the same magnitude at all points on a sphere of radius $r$ centered at the origin.

Thus, Gauss's Law becomes:

:::math
iint[S] E(r) unit{e}_r dot unit{n} \, dS = \frac{q}{eps_0}
:::

On a spherical surface of radius $r$, $unit{n} = unit{e}_r$. So, $unit{e}_r dot unit{n} = 1$.
Thus, we have:

:::math
iint[S] E(r) \, dS = \frac{q}{eps_0}
:::

$E(r)$ is constant over the spherical surface, so we get:

:::math
iint[S] E(r) \, dS = E(r) iint[S] dS
= 4 pi r^2 E(r) = \frac{q}{eps_0}
:::

and

:::math
v{E}(r) = unit{e}_r E(r) = \frac{unit{e}_r q}{4 pi eps_0 r^2}
:::

We can use symmetry and Gauss's Law to find the electric field in the following cases:

- A spherically symmetric charge distribution,
- An infinitely long cylindrically symmetric charge distribution, and
- An infinite slab of charge.

### From Gauss's Law to Divergence

Consider the surface integral of the electric field over closed surfaces centered at $P$:

 ![](fig-II-21.png)

Assuming volume $Delta V$ and average charge density $\overline{rho}_{Delta V}$, we have:

:::math
iint[S] v{E} dot unit{n} \, dS = \frac{\overline{rho}_{Delta V} Delta V}{eps_0}
\qquad\text{(II-15)}
:::

As expected, both sides go to zero as $Delta V -> 0$. To isolate the quantity that does not go to zero, we divide both sides by $Delta V$:

:::math
\frac{1}{Delta V} iint[S] v{E} dot unit{n} \, dS = \frac{\overline{rho}_{Delta V}}{eps_0}
:::

Taking the limit as $Delta V -> 0$, we get:

:::math plain
\lim_{\substack{Delta V -> 0 \\[0.3em] \text{about}\; (x,y,z)}} \frac{1}{Delta V} iint[S] v{E} dot unit{n} \, dS = \frac{rho(x, y, z)}{eps_0}
\qquad\text{(II-16)}
:::

### The Divergence

We define the **divergence** of a vector field $v{F}$ as:

:::math plain
\text{div} \, v{F} \equiv \lim_{\substack{Delta V -> 0 \\[0.3em] \text{about}\; (x,y,z)}} \frac{1}{Delta V} iint[S] v{F} dot unit{n} \, dS
\qquad\text{(II-17)}
:::

Then equation (II-16) can be written as:

:::math
\text{div} \, v{E} = \frac{rho}{eps_0}
\qquad\text{(II-18)}
:::

To calculate this, consider a small cube centered at $(x, y, z)$ with side length $Delta x$, $Delta y$, and $Delta z$:

 ![](fig-II-23.png)

$S_1$ is the front face, $S_2$ is the back face. Let $v{F} dot v{i} = F_x$.

Then the surface integral over $S_1$ is:

:::math
iint[S_1] F_x(x, y, z) \, dS \approx F_x(x + \frac{Delta x}{2}, y, z) Delta y Delta z
\qquad\text{(II-19)}
:::

Similarly, the surface integral over $S_2$ is:

:::math
iint[S_2] F_x(x, y, z) \, dS \approx -F_x(x - \frac{Delta x}{2}, y, z) Delta y Delta z
\qquad\text{(II-20)}
:::

Then, adding these two and dividing by $Delta V$ gives:

:::math
\frac{1}{Delta V} iint[S_1 + S_2] v{F} dot unit{n} \, dS \approx
\frac{F_x(x + \frac{Delta x}{2}, y, z) - F_x(x - \frac{Delta x}{2}, y, z)}{Delta x}
\qquad\text{(II-21)}
:::

Taking the limit as $Delta V -> 0$, we get:

:::math
lim[Delta V -> 0] \frac{1}{Delta V} iint[S_1 + S_2] v{F} dot unit{n} \, dS = pd(F_x, x)
:::

Similarly, we can calculate the contributions from the other two pairs of faces. Then adding
all together, we have:

:::math
\text{div} \, v{F} = pd(F_x, x) + pd(F_y, y) + pd(F_z, z)
\qquad\text{(II-22)}
:::

It can be shown that the result is independent of the shape of the volume we used.

### Differential Form of Gauss's Law
Combining equations (II-18) and (II-22), we get the **differential form of Gauss's Law**:

:::math
pd(E_x, x) + pd(E_y, y) + pd(E_z, z) = \frac{rho}{eps_0}
\qquad\text{(II-23)}
:::

### The Divergence in Cylindrical Coordinates

Equation (II-22) is merely the divergence in Cartesian coordinates. We prefer
to define the divergence as the limit of flux to volume as stated in equation (II-16).

To calculate the divergence in cylindrical coordinates, consider the "cylindrical cuboid" shown below:

 ![](fig-II-24.png)

Center is $(r, theta, z)$, and volume is $Delta V = r Delta r Delta theta Delta z$.

The flux of $v{F}$ through face 1 is:

:::math
iint[S_1] v{F} dot unit{n} \, dS \approx
F_r(r + \frac{Delta r}{2}, theta, z) (r + \frac{Delta r}{2}) Delta theta Delta z
:::

While the flux through face 2 is:

:::math
iint[S_2] v{F} dot unit{n} \, dS \approx
-F_r(r - \frac{Delta r}{2}, theta, z) (r - \frac{Delta r}{2}) Delta theta Delta z
:::

Adding these two and dividing by $Delta V$ gives, and taking the limit as $Delta V -> 0$ we get:

:::math
\frac{1}{r} pd(\partial, r) (r F_r)
:::

Arguing similarly for the other two pairs of faces, we get:

:::math
\text{div} \, v{F} = \frac{1}{r} pd(\partial, r) (r F_r) + \frac{1}{r} pd(F_theta, theta) + pd(F_z, z)
\qquad\text{(II-24)}
:::

### The Del Notation

We define the **del operator** as:

:::math
\nabla = v{i} pd(\partial, x) + v{j} pd(\partial, y) + v{k} pd(\partial, z)
:::

Then, the divergence can be written as:

:::math
\text{div} \, v{F} = \nabla dot v{F} = \frac{rho}{eps_0}
:::

### The Divergence Theorem

The **divergence theorem** states that the flux of a vector field $v{F}$ through a closed surface $S$ is equal to the integral of the divergence of $v{F}$ over the volume $V$ enclosed by $S$:

:::math
iint[S] v{F} dot unit{n} \, dS = iiint[V] \nabla dot v{F} \, dV
\qquad\text{(II-30)}
:::

### An Example

Divergence theorem on the **upper unit hemisphere**. Let

:::math
\mathbf F(x,y,z)=v{i}x+v{j}y+v{k}z ,
\quad
V=set((x,y,z) | x^{2}+y^{2}+z^{2} <= 1, z >= 0).
:::

The boundary $S$ has two pieces

* **$S_1$** – the curved spherical cap ($x^{2}+y^{2}+z^{2}=1,\;z>= 0$),
* **$S_2$** – the flat unit disk ($z=0,\;x^{2}+y^{2}<= 1$).

##### 1 . Volume integral of the divergence

:::math
\nabla\!dot\!\mathbf F = pd(x, x) + pd(y, y) +
pd(z, z) = 1+1+1 = 3.
:::

Volume of the hemisphere: $\displaystyle \dfrac12\!(\dfrac{4pi}{3})=\dfrac{2pi}{3}$.

:::math
iiint[V] (\nabla\!dot\!\mathbf F)\,dV
=3(\dfrac{2pi}{3})
=2pi
:::

##### 2 . Flux through the boundary

**Curved cap $S_1$**

On the unit sphere the outward unit normal is $unit{n}=v{i}x + v{j}y + v{k}z$.
So, $\mathbf F\!dot\!unit{n} = x^{2}+y^{2}+z^{2}=1.$

:::math
iint[S_1]\mathbf F\!dot\!unit{n}\,dS = 1dot 2pi = 2pi
:::

**Flat disk $S_2$**

Outward normal is $unit{n}=-\mathbf k$.
On $S_2$, $z=0$. So, $\mathbf F\!dot\!unit{n} = 0$.

:::math
iint[S_2]\mathbf F\!dot\!unit{n}\,dS = 0
:::

**Total outward flux**

:::math
iint[S]\mathbf F\!dot\!unit{n}\,dS
=2pi + 0 = 2 pi
:::


Therefore, we have:

:::math
iiint[V] (\nabla\!dot\!\mathbf F)\,dV
\;=\;
iint[S]\mathbf F\!dot\!unit{n}\,dS
\;=\;2pi
:::

### Applications

We want to derive equation (II-18):

:::math
\text{div} \, v{E} = \frac{rho}{eps_0}
:::

We start with Gauss's Law:

:::math
iint[S] v{E} dot unit{n} \, dS = \frac{1}{eps_0} iiint[V] rho \, dV
\qquad\text{(II-31)}
:::

We can use the divergence theorem to rewrite the left-hand side:

:::math
iint[S] v{E} dot unit{n} \, dS = iiint[V] \nabla dot v{E} \, dV
\qquad\text{(II-32)}
:::

Combining equations (II-31) and (II-32), we get:

:::math
iiint[V] \nabla dot v{E} \, dV = \frac{1}{eps_0} iiint[V] rho \, dV
:::

Since this is true for _any_ volume $V$, we can conclude that:

:::math
\nabla dot v{E} = \frac{rho}{eps_0}
:::

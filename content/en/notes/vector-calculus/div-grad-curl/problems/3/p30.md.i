**Problem III-30.**

The result

$$
(\nabla \times \mathbf{F})_z = \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y}
$$

has been established by calculating the circulation of $\mathbf{F}$ around
a rectangle and around a right triangle. In this problem we will show that
the result holds when the circulation is calculated around any closed curve
lying in the $xy$-plane.

**(a)** Approximate an arbitrary closed curve $C$ lying in the $xy$-plane by 
a polygonal $P$ as shown in the figure. Subdivide the area enclosed by $P$
into $N$ patches of which the $l$-th has area $\Delta S_l$.
Convince yourself by means of a sketch that this subdivision can be made
with only two kinds of patches: rectangles and right triangles.

 ![](III-30a.jpg)

:::expandable
**Solution.** [Click to Expand]

**Step 1.** Form right triangles taking each oblique segment of $P$ as the hypotenuse.

 ![](III-30b.jpg)

If right triangles overlap each other or the sides of $P$, then subdivide them into
smaller right triangles:

 ![](III-30d.png)

**Step 2.** Now, we have only right triangles and polygons with sides parallel
to the axes. Add vertical segments at concave 270° corners of the polygon to
form rectangles:

 ![](III-30c.jpg)

::::

**(b)** Letting $C(x, y) = \dfrac{\partial F_y}{\partial x} - \dfrac{\partial F_x}{\partial y}$,
use Taylor series to show that for $N$ large and each $\Delta S_l$ small,

$$
\begin{align*}
\oint_P \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &= \sum_{l=1}^N \oint_{C_l} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds \\[1em]
&\approx C(x_0, y_0) \Delta A + \left( \frac{\partial C}{\partial x} \right)\_{x_0, y_0} 
\sum_{l=1}^N (x_l - x_0) \Delta S_l \\[1em]
&\quad + \left( \frac{\partial C}{\partial y} \right)\_{x_0, y_0} 
\sum_{l=1}^N (y_l - y_0) \Delta S_l + \cdots
\end{align*}
$$

where $C_l$ is the perimeter of the $l$-th patch, $(x_0, y_0)$ is some point
in the region enclosed by $P$, and $\Delta A$ is the area enclosed by $P$.

:::expandable
**Solution.** [Click to Expand]

Segments in patches that are not in the perimeter of $P$ are traced twice, and
in opposite directions, so they cancel out. Thus, we can write:

$$
\oint_P \mathbf{F} \cdot \hat{\mathbf{t}} \, ds = \sum_{l=1}^N \oint_{C_l} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds \tag{1}
$$

We can approximate the circulation around $C_l$ by:

$$
\oint_{C_l} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds \approx
C(x_l, y_l) \, \Delta S_l \tag{2}
$$

where $(x_l, y_l)$ is the center of the $l$-th patch.

To approximate $C(x_l, y_l)$, we can use the two dimensional Taylor series.

Taylor expansion of $C(x_l, y_l)$ gives:

$$
C(x_l, y_l) \approx C(x_0, y_0) + \left( \frac{\partial C}{\partial x} \right)\_{x_0, y_0} (x_l - x_0) + \left( \frac{\partial C}{\partial y} \right)\_{x_0, y_0} (y_l - y_0) + \cdots
\tag{3}
$$

Putting (1), (2), and (3) together, we have:

$$
\begin{align*}
\oint_P \mathbf{F} &\cdot \hat{\mathbf{t}} \, ds \approx 
\\[1em]
&C(x_0, y_0) \Delta A + \left( \frac{\partial C}{\partial x} \right)\_{x_0, y_0} 
\sum_{l=1}^N (x_l - x_0) \Delta S_l \\[1em]
&\quad + \left( \frac{\partial C}{\partial y} \right)\_{x_0, y_0} 
\sum_{l=1}^N (y_l - y_0) \Delta S_l + \cdots
\end{align*}
$$

::::

**(c)** Show that

$$
\begin{align*}
\lim_{N \to \infty} \oint_P \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &=
\oint_C \mathbf{F} \cdot \hat{\mathbf{t}} \, ds \\[1em]
&\= \Bigl( C(x_0, y_0) + (\overline{x} - x_0) \left( \frac{\partial C}{\partial x} \right)\_{x_0, y_0} \\[1em]
&\+ (\overline{y} - y_0) \left( \frac{\partial C}{\partial y} \right)\_{x_0, y_0} +
\cdots \Bigr) \Delta S
\end{align*}
$$

where $\Delta S$ is the area of the region $R$ enclosed by $C$ and $(\overline{x}, \overline{y})$ is the centroid of $R$. That is:

$$
\overline{x} = \frac{1}{\Delta S} \iint_R x \, dx \, dy, \quad
\overline{y} = \frac{1}{\Delta S} \iint_R y \, dx \, dy
$$

:::expandable
**Solution.** [Click to Expand]

We have:

$$
\begin{align*}
\lim_{N \to \infty} \sum_{l=1}^N (x_l - x_0) \Delta S_l &=
\lim_{N \to \infty} \sum_{l=1}^N (x_l \Delta S_l) - x_0 \left(
  \lim_{N \to \infty} \sum_{l=1}^N \Delta S_l \right) \\[1em]
&= \iint_R x \, dx \, dy - x_0 \Delta S \\[1em]
&= \Delta S (\overline{x} - x_0)
\end{align*}
$$

Similarly, we can get:

$$
\lim_{N \to \infty} \sum_{l=1}^N (y_l - y_0) \Delta S_l = \Delta S (\overline{y} - y_0)
$$

Putting this together, we have:

$$
\begin{align*}
\oint_C \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &=
\lim_{N \to \infty} \sum_{l=1}^N \oint_{C_l} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds
\\[1em]
&= \Bigl( C(x_0, y_0) + (\overline{x} - x_0) \left( \frac{\partial C}{\partial x} \right)\_{x_0, y_0} \\[1em]
&\+ (\overline{y} - y_0) \left( \frac{\partial C}{\partial y} \right)\_{x_0, y_0} +
\cdots \Bigr) \Delta S
\end{align*}
$$

::::

**(d)** Finally, calculate

$$
(\nabla \times \mathbf{F})_z = \lim\_{\Delta S \to 0} \frac{1}{\Delta S} \oint_P \mathbf{F} \cdot \hat{\mathbf{t}} \, ds
$$

:::expandable
**Solution.** [Click to Expand]

As $\Delta S \to 0$, then $(\overline{x}, \overline{y}) \to (x, y)$, and we have:

$$
\begin{align*}
\lim\_{\Delta S \to 0} \frac{1}{\Delta S} \oint_P \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &=
\lim\_{\Delta S \to 0} \Bigl( C(x_0, y_0) + (\overline{x} - x_0) \left( \frac{\partial C}{\partial x} \right)\_{x_0, y_0} \\[1em]
&\+ (\overline{y} - y_0) \left( \frac{\partial C}{\partial y} \right)\_{x_0, y_0} +
\cdots \Bigr) \\[1em]
&= \lim\_{\Delta S \to 0} C(x_l, y_l) \\[1em]
&= \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y}
\end{align*}
$$

::::

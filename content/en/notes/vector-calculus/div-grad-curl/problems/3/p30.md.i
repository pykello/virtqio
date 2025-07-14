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

:::expandable
**Solution.** [Click to Expand]

::::

**(b)** Letting $C(x, y) = \dfrac{\partial F_y}{\partial x} - \dfrac{\partial F_x}{\partial y}$,
use Taylor series to show that for $N$ large and each $\Delta S_l$ small,

$$
\begin{align*}
\oint_P \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \sum_{l=1}^N \oint_{C_l} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds \\\\[1em]
&\approx C(x_0, y_0) \Delta A + \left( \frac{\partial C}{\partial x} \right)\_{x_0, y_0} 
\sum_{l=1}^N (x_l - x_0) \Delta S_l \\\\[1em]
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
\oint_P \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds = \sum_{l=1}^N \oint_{C_l} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds \tag{1}
$$

We can approximate the circulation around $C_l$ by:

$$
\oint_{C_l} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds \approx
C(x_l, y_l) \\, \Delta S_l \tag{2}
$$

where $(x_l, y_l)$ is the center of the $l$-th patch.

To approximate $C(x_l, y_l)$, we can use the two dimensional Taylor series:

$$
F(x_0 + \Delta x, y_0 + \Delta y) = F(x_0, y_0) + \left( \frac{\partial F}{\partial x} \right)\_{x_0, y_0} \Delta x + \left( \frac{\partial F}{\partial y} \right)\_{x_0, y_0} \Delta y + \cdots
$$

which gives:

$$
C(x_l, y_l) \approx C(x_0, y_0) + \left( \frac{\partial C}{\partial x} \right)\_{x_0, y_0} (x_l - x_0) + \left( \frac{\partial C}{\partial y} \right)\_{x_0, y_0} (y_l - y_0) + \cdots
\tag{3}
$$

Putting (1), (2), and (3) together, we have:

$$
\begin{align*}
\oint_P \mathbf{F} &\cdot \hat{\mathbf{t}} \\, ds \approx 
\\\\[1em]
&C(x_0, y_0) \Delta A + \left( \frac{\partial C}{\partial x} \right)\_{x_0, y_0} 
\sum_{l=1}^N (x_l - x_0) \Delta S_l \\\\[1em]
&\quad + \left( \frac{\partial C}{\partial y} \right)\_{x_0, y_0} 
\sum_{l=1}^N (y_l - y_0) \Delta S_l + \cdots
\end{align*}
$$

::::

**(c)** Show that
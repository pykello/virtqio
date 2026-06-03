**Problem III-30.**

The result

:::math
(\nabla cross v{F})_z = pd(F_y, x) - pd(F_x, y)
:::

has been established by calculating the circulation of $v{F}$ around
a rectangle and around a right triangle. In this problem we will show that
the result holds when the circulation is calculated around any closed curve
lying in the $xy$-plane.

**(a)** Approximate an arbitrary closed curve $C$ lying in the $xy$-plane by
a polygonal $P$ as shown in the figure. Subdivide the area enclosed by $P$
into $N$ patches of which the $l$-th has area $Delta S_l$.
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

**(b)** Letting $C(x, y) = pd(F_y, x) - pd(F_x, y)$,
use Taylor series to show that for $N$ large and each $Delta S_l$ small,

:::math align
oint[P] v{F} dot unit{t} \, ds &= sum[l=1..N] oint[C_l] v{F} dot unit{t} \, ds
&\approx C(x_0, y_0) Delta A + ( pd(C, x) )_{x_0, y_0} sum[l=1..N] (x_l - x_0) Delta S_l
&\quad + ( pd(C, y) )_{x_0, y_0} sum[l=1..N] (y_l - y_0) Delta S_l + ...
:::

where $C_l$ is the perimeter of the $l$-th patch, $(x_0, y_0)$ is some point
in the region enclosed by $P$, and $Delta A$ is the area enclosed by $P$.

:::expandable
**Solution.** [Click to Expand]

Segments in patches that are not in the perimeter of $P$ are traced twice, and
in opposite directions, so they cancel out. Thus, we can write:

:::math
oint[P] v{F} dot unit{t} \, ds = sum[l=1..N] oint[C_l] v{F} dot unit{t} \, ds \qquad\text{(1)}
:::

We can approximate the circulation around $C_l$ by:

:::math
oint[C_l] v{F} dot unit{t} \, ds \approx
C(x_l, y_l) \, Delta S_l \qquad\text{(2)}
:::

where $(x_l, y_l)$ is the center of the $l$-th patch.

To approximate $C(x_l, y_l)$, we can use the two dimensional Taylor series.

Taylor expansion of $C(x_l, y_l)$ gives:

:::math
C(x_l, y_l) \approx C(x_0, y_0) + ( pd(C, x) )_{x_0, y_0} (x_l - x_0) + ( pd(C, y) )_{x_0, y_0} (y_l - y_0) + ...
\qquad\text{(3)}
:::

Putting (1), (2), and (3) together, we have:

:::math align
oint[P] v{F} dot unit{t} \, ds &\approx C(x_0, y_0) Delta A + ( pd(C, x) )_{x_0, y_0} sum[l=1..N] (x_l - x_0) Delta S_l
&\quad + ( pd(C, y) )_{x_0, y_0} sum[l=1..N] (y_l - y_0) Delta S_l + ...
:::

::::

**(c)** Show that

:::math align
lim[N -> inf] oint[P] v{F} dot unit{t} \, ds &= oint[C] v{F} dot unit{t} \, ds
&= ( C(x_0, y_0) + (\overline{x} - x_0) ( pd(C, x) )_{x_0, y_0} + (\overline{y} - y_0) ( pd(C, y) )_{x_0, y_0} + ... ) Delta S
:::

where $Delta S$ is the area of the region $R$ enclosed by $C$ and $(\overline{x}, \overline{y})$ is the centroid of $R$. That is:

:::math
\overline{x} = \frac{1}{Delta S} iint[R] x \, dx \, dy, \quad
\overline{y} = \frac{1}{Delta S} iint[R] y \, dx \, dy
:::

:::expandable
**Solution.** [Click to Expand]

We have:

:::math align
lim[N -> inf] sum[l=1..N] (x_l - x_0) Delta S_l &= lim[N -> inf] sum[l=1..N] (x_l Delta S_l) - x_0 ( lim[N -> inf] sum[l=1..N] Delta S_l )
&= iint[R] x \, dx \, dy - x_0 Delta S
&= Delta S (\overline{x} - x_0)
:::

Similarly, we can get:

:::math
lim[N -> inf] sum[l=1..N] (y_l - y_0) Delta S_l = Delta S (\overline{y} - y_0)
:::

Putting this together, we have:

:::math align
oint[C] v{F} dot unit{t} \, ds &= lim[N -> inf] sum[l=1..N] oint[C_l] v{F} dot unit{t} \, ds
&= ( C(x_0, y_0) + (\overline{x} - x_0) ( pd(C, x) )_{x_0, y_0} + (\overline{y} - y_0) ( pd(C, y) )_{x_0, y_0} + ... ) Delta S
:::

::::

**(d)** Finally, calculate

:::math
(\nabla cross v{F})_z = lim[Delta S -> 0] \frac{1}{Delta S} oint[P] v{F} dot unit{t} \, ds
:::

:::expandable
**Solution.** [Click to Expand]

As $Delta S -> 0$, then $(\overline{x}, \overline{y}) -> (x, y)$, and we have:

:::math align
lim[Delta S -> 0] \frac{1}{Delta S} oint[P] v{F} dot unit{t} \, ds &= lim[Delta S -> 0] ( C(x_0, y_0) + (\overline{x} - x_0) ( pd(C, x) )_{x_0, y_0} + (\overline{y} - y_0) ( pd(C, y) )_{x_0, y_0} + ... )
&= lim[Delta S -> 0] C(x_l, y_l)
&= pd(F_y, x) - pd(F_x, y)
:::

::::

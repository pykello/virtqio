**Problem III-22.**
**(a)** Apply the divergence theorem to the function

:::math
v{G}(x, y) = v{i} G_x(x, y) + v{j} G_y(x, y)
:::

using for $V$ and $S$ the volume and surface shown in the diagram.

  ![](III-22.png)

In this way obtain the relation

:::math
oint[C] G_x \, dy - G_y \, dx = iint[R] ( pd(G_x, x) + pd(G_y, y) ) \, dx dy
:::

which is the divergence theorem in two dimensions.

:::expandable
**Solution.** [Click to Expand]

We'll use the divergence theorem:

:::math
iint[S] v{G} dot unit{n} \, dS = iiint[V] \nabla dot v{G} \, dV
\qquad\text{(1)}
:::

**Calculating the surface integral.**

First we calculate the surface integral $iint[S] v{G} dot unit{n} \, dS$.

In upper and lower parts of the surface, the normal vector is $\pm v{k}$,
and since $v{G}$ has $0$ as the $v{k}$ component, then the surface integral is zero.

To calculate the surface integral of the shaded part in the figure, since
the value of $v{G}$ and the normal vector $unit{n}$ do not depend on the $z$-coordinate, we choose $dS$ as below. Then, $dS = h \, ds$, where $h$ is the height of the surface.

 ![](III-22a.png)

Then surface integral of the shaded part in the figure will be equal to:

:::math
h \, oint[C] v{G} dot unit{n} \, ds
:::

Since $C$ is on the $xy$-plane, then its tangent vector is:

:::math
unit{t} = v{i} dd(x, s) + v{j} dd(y, s)
:::

Given that $C$ is oriented counterclockwise, then the normal vector is the tangent vector rotated by $90^\circ$ clockwise:

:::math
unit{n} = v{i} dd(y, s) - v{j} dd(x, s)
:::

Then, we have:

:::math align
oint[C] v{G} dot unit{n} \, ds &= oint[C] ( G_x dd(y, s) - G_y dd(x, s) ) \, ds
&= oint[C] G_x \, dy - G_y \, dx
:::

and then the total surface integral is:

:::math
iint[S] v{G} dot unit{n} \, dS = h oint[C] G_x \, dy - G_y \, dx
\qquad\text{(2)}
:::

**Calculating the volume integral.**

Since value of $v{G}$ doesn't depend on $z$, we can choose $dV$ as below. Then, $dV = h \, dS$.

 ![](III-22b.png)

Then, we have:

:::math align
iiint[V] \nabla dot v{G} \, dV &= h iint[R] \nabla dot v{G} \, dS
&= h iint[R] ( pd(G_x, x) + pd(G_y, y) ) \, dx dy \qquad\text{(3)}
:::

------------------

Finally, putting (1), (2), and (3) together, we have:

:::math
oint[C] G_x \, dy - G_y \, dx = iint[R] ( pd(G_x, x) + pd(G_y, y) ) \, dx dy
:::

::::

**(b)** Apply Stokes' theorem to the function

:::math
v{F}(x, y) = v{i} F_x(x, y) + v{j} F_y(x, y)
:::

using for $C$ a closed curve lying entirely in the $xy$-plane and for $S$ the
region $R$ of the $xy$-plane enclosed by $C$. In this way obtain the relation

:::math
oint[C] F_x \, dx + F_y \, dy = iint[R] ( pd(F_y, x) - pd(F_x, y) ) \, dx dy
:::

which is Stokes' theorem in two dimensions.

:::expandable
**Solution.** [Click to Expand]

Since $S$ lies entirely in the $xy$-plane, then
- Assuming counterclockwise orientation, $unit{n} = unit{k}$,
- $dS = dx \, dy$.

Since $\nabla cross v{F} = v{k} ( pd(F_y, x) - pd(F_x, y) )$, we have:

:::math
\nabla cross v{F} dot unit{n} = pd(F_y, x) - pd(F_x, y)
:::

and then:

:::math
iint[S] \nabla cross v{F} dot unit{n} \, dS = iint[R] ( pd(F_y, x) - pd(F_x, y) ) \, dx dy \qquad\text{(1)}
:::

------------

Since $C$ is a closed curve lying entirely in the $xy$-plane, then:

:::math
oint[C] v{F} dot unit{t} \, ds = oint[C] F_x \, dx + F_y \, dy \qquad\text{(2)}
:::

---------------

Then, by Stokes' theorem we have:

:::math
oint[C] v{F} dot unit{t} \, ds = iint[S] \nabla cross v{F} dot unit{n} \, dS \qquad\text{(3)}
:::


Putting (1), (2), and (3) together, we have:

:::math
oint[C] F_x \, dx + F_y \, dy = iint[R] ( pd(F_y, x) - pd(F_x, y) ) \, dx dy
:::

::::

**(c)** Show that in two dimensions the divergence theorem and Stokes' theorem are identical.

:::expandable
**Solution.** [Click to Expand]

The divergence theorem for $v{i} F_x + v{j} F_y$ is the same as Stokes' theorem for $-v{i} F_y + v{j} F_x$.

So they are identical in two dimensions.
::::

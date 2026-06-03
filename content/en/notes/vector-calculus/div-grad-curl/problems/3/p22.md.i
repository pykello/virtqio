**Problem III-22.**
**(a)** Apply the divergence theorem to the function

$$
v{G}(x, y) = v{i} G_x(x, y) + v{j} G_y(x, y)
$$

using for $V$ and $S$ the volume and surface shown in the diagram.

  ![](III-22.png)

In this way obtain the relation

$$
\oint_C G_x \, dy - G_y \, dx = \iint_R ( \frac{\partial G_x}{\partial x} + \frac{\partial G_y}{\partial y} ) \, dx dy
$$

which is the divergence theorem in two dimensions.

:::expandable
**Solution.** [Click to Expand]

We'll use the divergence theorem:

$$
\iint_S v{G} \cdot unit{n} \, dS = \iiint_V \nabla \cdot v{G} \, dV
\tag{1}
$$

**Calculating the surface integral.**

First we calculate the surface integral $\iint_S v{G} \cdot unit{n} \\, dS$.

In upper and lower parts of the surface, the normal vector is $\pm v{k}$,
and since $v{G}$ has $0$ as the $v{k}$ component, then the surface integral is zero.

To calculate the surface integral of the shaded part in the figure, since
the value of $v{G}$ and the normal vector $unit{n}$ do not depend on the $z$-coordinate, we choose $dS$ as below. Then, $dS = h \\, ds$, where $h$ is the height of the surface.

 ![](III-22a.png)

Then surface integral of the shaded part in the figure will be equal to:

$$
h \, \oint_C v{G} \cdot unit{n} \, ds
$$

Since $C$ is on the $xy$-plane, then its tangent vector is:

$$
unit{t} = v{i} \frac{dx}{ds} + v{j} \frac{dy}{ds}
$$

Given that $C$ is oriented counterclockwise, then the normal vector is the tangent vector rotated by $90^\circ$ clockwise:

$$
unit{n} = v{i} \frac{dy}{ds} - v{j} \frac{dx}{ds}
$$

Then, we have:

$$
\begin{align*}
\oint_C v{G} \cdot unit{n} \, ds &= \oint_C ( G_x \frac{dy}{ds} - G_y \frac{dx}{ds} ) \, ds \\[0.8em]
&= \oint_C G_x \, dy - G_y \, dx
\end{align*}
$$

and then the total surface integral is:

$$
\iint_S v{G} \cdot unit{n} \, dS = h \oint_C G_x \, dy - G_y \, dx
\tag{2}
$$

**Calculating the volume integral.**

Since value of $v{G}$ doesn't depend on $z$, we can choose $dV$ as below. Then, $dV = h \\, dS$.

 ![](III-22b.png)

Then, we have:

$$
\begin{align*}
\iiint_V \nabla \cdot v{G} \, dV &=
h \iint_R \nabla \cdot v{G} \, dS \\[0.8em]
&= h \iint_R ( \frac{\partial G_x}{\partial x} + \frac{\partial G_y}{\partial y} ) \, dx dy
\tag{3}
\end{align*}
$$

------------------

Finally, putting (1), (2), and (3) together, we have:

$$
\oint_C G_x \, dy - G_y \, dx = \iint_R ( \frac{\partial G_x}{\partial x} + \frac{\partial G_y}{\partial y} ) \, dx dy
$$

::::

**(b)** Apply Stokes' theorem to the function

$$
v{F}(x, y) = v{i} F_x(x, y) + v{j} F_y(x, y)
$$

using for $C$ a closed curve lying entirely in the $xy$-plane and for $S$ the
region $R$ of the $xy$-plane enclosed by $C$. In this way obtain the relation

$$
\oint_C F_x \, dx + F_y \, dy = \iint_R ( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} ) \, dx dy
$$

which is Stokes' theorem in two dimensions.

:::expandable
**Solution.** [Click to Expand]

Since $S$ lies entirely in the $xy$-plane, then
- Assuming counterclockwise orientation, $unit{n} = unit{k}$,
- $dS = dx \\, dy$.

Since $\nabla \times v{F} = v{k} ( \dfrac{\partial F_y}{\partial x} - \dfrac{\partial F_x}{\partial y} )$, we have:

$$
\nabla \times v{F} \cdot unit{n} = \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y}
$$

and then:

$$
\iint_S \nabla \times v{F} \cdot unit{n} \, dS = \iint_R ( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} ) \, dx dy \tag{1}
$$

------------

Since $C$ is a closed curve lying entirely in the $xy$-plane, then:

$$
\oint_C v{F} \cdot unit{t} \, ds = \oint_C F_x \, dx + F_y \, dy \tag{2}
$$

---------------

Then, by Stokes' theorem we have:

$$
\oint_C v{F} \cdot unit{t} \, ds = \iint_S \nabla \times v{F} \cdot unit{n} \, dS \tag{3}
$$


Putting (1), (2), and (3) together, we have:

$$
\oint_C F_x \, dx + F_y \, dy = \iint_R ( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} ) \, dx dy
$$

::::

**(c)** Show that in two dimensions the divergence theorem and Stokes' theorem are identical.

:::expandable
**Solution.** [Click to Expand]

The divergence theorem for $v{i} F_x + v{j} F_y$ is the same as Stokes' theorem for $-v{i} F_y + v{j} F_x$.

So they are identical in two dimensions.
::::

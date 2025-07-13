**Problem III-22.** 
**(a)** Apply the divergence theorem to the function

$$
\mathbf{G}(x, y) = \mathbf{i} G_x(x, y) + \mathbf{j} G_y(x, y)
$$

using for $V$ and $S$ the volume and surface shown in the diagram.

  ![](III-22.png)

In this way obtain the relation

$$
\oint_C G_x \\, dy - G_y \\, dx = \iint_R \left( \frac{\partial G_x}{\partial x} + \frac{\partial G_y}{\partial y} \right) \\, dx dy
$$

which is the divergence theorem in two dimensions.

:::expandable
**Solution.** [Click to Expand]

We'll use the divergence theorem:

$$
\iint_S \mathbf{G} \cdot \hat{\mathbf{n}} \\, dS = \iiint_V \nabla \cdot \mathbf{G} \\, dV
\tag{1}
$$

**Calculating the surface integral.**

First we calculate the surface integral $\iint_S \mathbf{G} \cdot \hat{\mathbf{n}} \\, dS$.

In upper and lower parts of the surface, the normal vector is $\pm \mathbf{k}$,
and since $\mathbf{G}$ has $0$ as the $\mathbf{k}$ component, then the surface integral is zero.

To calculate the surface integral of the shaded part in the figure, since
the value of $\mathbf{G}$ and the normal vector $\hat{\mathbf{n}}$ do not depend on the $z$-coordinate, we choose $dS$ as below. Then, $dS = h \\, ds$, where $h$ is the height of the surface.

 ![](III-22a.png)

Then surface integral of the shaded part in the figure will be equal to:

$$
h \\, \oint_C \mathbf{G} \cdot \hat{\mathbf{n}} \\, ds
$$

Since $C$ is on the $xy$-plane, then its tangent vector is:

$$
\hat{\mathbf{t}} = \mathbf{i} \frac{dx}{ds} + \mathbf{j} \frac{dy}{ds}
$$

Given that $C$ is oriented counterclockwise, then the normal vector is the tangent vector rotated by $90^\circ$ clockwise:

$$
\hat{\mathbf{n}} = \mathbf{i} \frac{dy}{ds} - \mathbf{j} \frac{dx}{ds}
$$

Then, we have:

$$
\begin{align*}
\oint_C \mathbf{G} \cdot \hat{\mathbf{n}} \\, ds &= \oint_C \left( G_x \frac{dy}{ds} - G_y \frac{dx}{ds} \right) \\, ds \\\\[0.8em]
&= \oint_C G_x \\, dy - G_y \\, dx
\end{align*}
$$

and then the total surface integral is:

$$
\iint_S \mathbf{G} \cdot \hat{\mathbf{n}} \\, dS = h \oint_C G_x \\, dy - G_y \\, dx
\tag{2}
$$

**Calculating the volume integral.**

Since value of $\mathbf{G}$ doesn't depend on $z$, we can choose $dV$ as below. Then, $dV = h \\, dS$.

 ![](III-22b.png)

Then, we have:

$$
\begin{align*}
\iiint_V \nabla \cdot \mathbf{G} \\, dV &=
h \iint_R \nabla \cdot \mathbf{G} \\, dS \\\\[0.8em]
&= h \iint_R \left( \frac{\partial G_x}{\partial x} + \frac{\partial G_y}{\partial y} \right) \\, dx dy
\tag{3}
\end{align*}
$$

------------------

Finally, putting (1), (2), and (3) together, we have:

$$
\oint_C G_x \\, dy - G_y \\, dx = \iint_R \left( \frac{\partial G_x}{\partial x} + \frac{\partial G_y}{\partial y} \right) \\, dx dy
$$

::::

**(b)** Apply Stokes' theorem to the function

$$
\mathbf{F}(x, y) = \mathbf{i} F_x(x, y) + \mathbf{j} F_y(x, y)
$$

using for $C$ a closed curve lying entirely in the $xy$-plane and for $S$ the
region $R$ of the $xy$-plane enclosed by $C$. In this way obtain the relation

$$
\oint_C F_x \\, dx + F_y \\, dy = \iint_R \left( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} \right) \\, dx dy
$$

which is Stokes' theorem in two dimensions.

:::expandable
**Solution.** [Click to Expand]

Since $S$ lies entirely in the $xy$-plane, then
- Assuming counterclockwise orientation, $\hat{\mathbf{n}} = \hat{\mathbf{k}}$,
- $dS = dx \\, dy$.

Since $\nabla \times \mathbf{F} = \mathbf{k} \left( \dfrac{\partial F_y}{\partial x} - \dfrac{\partial F_x}{\partial y} \right)$, we have:

$$
\nabla \times \mathbf{F} \cdot \hat{\mathbf{n}} = \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y}
$$

and then:

$$
\iint_S \nabla \times \mathbf{F} \cdot \hat{\mathbf{n}} \\, dS = \iint_R \left( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} \right) \\, dx dy \tag{1}
$$

------------

Since $C$ is a closed curve lying entirely in the $xy$-plane, then:

$$
\oint_C \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds = \oint_C F_x \\, dx + F_y \\, dy \tag{2}
$$

---------------

Then, by Stokes' theorem we have:

$$
\oint_C \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds = \iint_S \nabla \times \mathbf{F} \cdot \hat{\mathbf{n}} \\, dS \tag{3}
$$


Putting (1), (2), and (3) together, we have:

$$
\oint_C F_x \\, dx + F_y \\, dy = \iint_R \left( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} \right) \\, dx dy
$$

::::

**(c)** Show that in two dimensions the divergence theorem and Stokes' theorem are identical.

:::expandable
**Solution.** [Click to Expand]

The divergence theorem for $\mathbf{i} F_x + \mathbf{j} F_y$ is the same as Stokes' theorem for $-\mathbf{i} F_y + \mathbf{j} F_x$.

So they are identical in two dimensions.
::::

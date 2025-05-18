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
> My description was a bit different from the book, but the steps are 
> equivalent and the final result is the same.


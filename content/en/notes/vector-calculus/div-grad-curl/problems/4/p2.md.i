**Problem IV-2.**
Verify the following identities.

**(a)** $\nabla(fg) = f \nabla g + g \nabla f$

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
\nabla(fg) &= \frac{\partial(fg)}{\partial x} \mathbf{i} + \frac{\partial(fg)}{\partial y} \mathbf{j} + \frac{\partial(fg)}{\partial z} \mathbf{k} \\\\[1em]
&= g \frac{\partial f}{\partial x} \mathbf{i} + f \frac{\partial g}{\partial x} \mathbf{i} + g \frac{\partial f}{\partial y} \mathbf{j} + f \frac{\partial g}{\partial y} \mathbf{j} + g \frac{\partial f}{\partial z} \mathbf{k} + f \frac{\partial g}{\partial z} \mathbf{k} \\\\[1em]
&= f \left( \frac{\partial g}{\partial x} \mathbf{i} + \frac{\partial g}{\partial y} \mathbf{j} + \frac{\partial g}{\partial z} \mathbf{k} \right) + g \left( \frac{\partial f}{\partial x} \mathbf{i} + \frac{\partial f}{\partial y} \mathbf{j} + \frac{\partial f}{\partial z} \mathbf{k} \right) \\\\[1em]
&= f \nabla g + g \nabla f
\end{align*}
$$
:::

**(b)** $\nabla(\mathbf{F} \cdot \mathbf{G}) = (\mathbf{G} \cdot \nabla) \mathbf{F} + (\mathbf{F} \cdot \nabla) \mathbf{G} + \mathbf{F} \times (\nabla \times \mathbf{G}) + \mathbf{G} \times (\nabla \times \mathbf{F})$

:::expandable
**Solution.** [Click to Expand]

We have:

$$
\begin{align*}
\left( (\mathbf{G} \cdot \nabla) \mathbf{F} \right)_x &= G_x \frac{\partial F_x}{\partial x} + G_y \frac{\partial F_x}{\partial y} + G_z \frac{\partial F_x}{\partial z} \\\\[1em]
\left( (\mathbf{F} \cdot \nabla) \mathbf{G} \right)_x &= F_x \frac{\partial G_x}{\partial x} + F_y \frac{\partial G_x}{\partial y} + F_z \frac{\partial G_x}{\partial z} \\\\[1em]
\left(\mathbf{F} \times (\nabla \times \mathbf{G})\right)_x &= F_y \left( \frac{\partial G_y}{\partial x} - \frac{\partial G_x}{\partial y} \right) - F_z \left( \frac{\partial G_x}{\partial z} - \frac{\partial G_z}{\partial x} \right) \\\\[1em]
\left(\mathbf{G} \times (\nabla \times \mathbf{F})\right)_x &= G_y \left( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} \right) - G_z \left( \frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x} \right)
\end{align*}
$$

Adding these together, we get:

$$
G_x \frac{\partial F_x}{\partial x} + F_x \frac{\partial G_x}{\partial x} +
G_y \frac{\partial F_x}{\partial y} + F_y \frac{\partial G_x}{\partial y} +
G_z \frac{\partial F_x}{\partial z} + F_z \frac{\partial G_x}{\partial z} +
$$

which is equal to:

$$
\frac{\partial}{\partial x} (F_x G_x + F_y G_y + F_z G_z)
$$

which is the $x$-component of $\nabla(\mathbf{F} \cdot \mathbf{G})$.

Similarly, we can prove the equality for the $y$ and $z$ components.

::::

**(c)** $\nabla \cdot (f \mathbf{F}) = f \nabla \cdot \mathbf{F} + \mathbf{F} \cdot \nabla f$

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
\nabla \cdot (f \mathbf{F}) &= \frac{\partial (f F_x)}{\partial x} + \frac{\partial (f F_y)}{\partial y} + \frac{\partial (f F_z)}{\partial z} \\\\[1em]
&= f \frac{\partial F_x}{\partial x} + F_x \frac{\partial f}{\partial x} + f \frac{\partial F_y}{\partial y} + F_y \frac{\partial f}{\partial y} + f \frac{\partial F_z}{\partial z} + F_z \frac{\partial f}{\partial z} \\\\[1em]
&= f \nabla \cdot \mathbf{F} + \mathbf{F} \cdot \nabla f
\end{align*}
$$
::::

**(d)** $\nabla \cdot (\mathbf{F} \times \mathbf{G}) = \mathbf{G} \cdot (\nabla \times \mathbf{F}) - \mathbf{F} \cdot (\nabla \times \mathbf{G})$

:::expandable
**Solution.** [Click to Expand]

We have:

$$
\begin{align*}
\mathbf{G} \cdot (\nabla \times \mathbf{F}) &= G_x \left( \frac{\partial F_z}{\partial y} - \frac{\partial F_y}{\partial z} \right) + G_y \left( \frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x} \right) + G_z \left( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} \right) \\\\[1em]
\mathbf{F} \cdot (\nabla \times \mathbf{G}) &= F_x \left( \frac{\partial G_z}{\partial y} - \frac{\partial G_y}{\partial z} \right) + F_y \left( \frac{\partial G_x}{\partial z} - \frac{\partial G_z}{\partial x} \right) + F_z \left( \frac{\partial G_y}{\partial x} - \frac{\partial G_x}{\partial y} \right)
\end{align*}
$$

Then:

$$
\begin{align*}
\mathbf{G} \cdot (\nabla \times \mathbf{F}) &- \mathbf{F} \cdot (\nabla \times \mathbf{G}) = \\\\[1em]
& \left(G_z \frac{\partial F_y}{\partial x} + F_y \frac{\partial G_z}{\partial x}\right)
\- \left(G_y \frac{\partial F_z}{\partial x} + F_z \frac{\partial G_y}{\partial x}\right) \\\\[1em]
\+ &\left(G_x \frac{\partial F_z}{\partial y} + F_z \frac{\partial G_x}{\partial y}\right)
\- \left(G_z \frac{\partial F_x}{\partial y} + F_x \frac{\partial G_z}{\partial y}\right) \\\\[1em]
\+ &\left(G_y \frac{\partial F_x}{\partial z} + F_x \frac{\partial G_y}{\partial z}\right)
\- \left(G_x \frac{\partial F_y}{\partial z} + F_y \frac{\partial G_x}{\partial z}\right)
\end{align*}
$$

Then:

$$
\begin{align*}
\mathbf{G} \cdot &(\nabla \times \mathbf{F}) - \mathbf{F} \cdot (\nabla \times \mathbf{G}) \\\\[1em]
&=
\frac{\partial}{\partial x} (F_y G_z - F_z G_y) + \frac{\partial}{\partial y} (F_z G_x - F_x G_z) + \frac{\partial}{\partial z} (F_x G_y - F_y G_x) \\\\[1em]
&= \nabla \cdot (\mathbf{F} \times \mathbf{G})
\end{align*}
$$

::::

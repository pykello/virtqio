**Problem IV-2.**
Verify the following identities.

**(a)** $\nabla(fg) = f \nabla g + g \nabla f$

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
\nabla(fg) &= \frac{\partial(fg)}{\partial x} v{i} + \frac{\partial(fg)}{\partial y} v{j} + \frac{\partial(fg)}{\partial z} v{k} \\[1em]
&= g \frac{\partial f}{\partial x} v{i} + f \frac{\partial g}{\partial x} v{i} + g \frac{\partial f}{\partial y} v{j} + f \frac{\partial g}{\partial y} v{j} + g \frac{\partial f}{\partial z} v{k} + f \frac{\partial g}{\partial z} v{k} \\[1em]
&= f ( \frac{\partial g}{\partial x} v{i} + \frac{\partial g}{\partial y} v{j} + \frac{\partial g}{\partial z} v{k} ) + g ( \frac{\partial f}{\partial x} v{i} + \frac{\partial f}{\partial y} v{j} + \frac{\partial f}{\partial z} v{k} ) \\[1em]
&= f \nabla g + g \nabla f
\end{align*}
$$
:::

**(b)** $\nabla(v{F} \cdot v{G}) = (v{G} \cdot \nabla) v{F} + (v{F} \cdot \nabla) v{G} + v{F} \times (\nabla \times v{G}) + v{G} \times (\nabla \times v{F})$

:::expandable
**Solution.** [Click to Expand]

We have:

$$
\begin{align*}
( (v{G} \cdot \nabla) v{F} )_x &= G_x \frac{\partial F_x}{\partial x} + G_y \frac{\partial F_x}{\partial y} + G_z \frac{\partial F_x}{\partial z} \\[1em]
( (v{F} \cdot \nabla) v{G} )_x &= F_x \frac{\partial G_x}{\partial x} + F_y \frac{\partial G_x}{\partial y} + F_z \frac{\partial G_x}{\partial z} \\[1em]
(v{F} \times (\nabla \times v{G}))_x &= F_y ( \frac{\partial G_y}{\partial x} - \frac{\partial G_x}{\partial y} ) - F_z ( \frac{\partial G_x}{\partial z} - \frac{\partial G_z}{\partial x} ) \\[1em]
(v{G} \times (\nabla \times v{F}))_x &= G_y ( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} ) - G_z ( \frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x} )
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

which is the $x$-component of $\nabla(v{F} \cdot v{G})$.

Similarly, we can prove the equality for the $y$ and $z$ components.

::::

**(c)** $\nabla \cdot (f v{F}) = f \nabla \cdot v{F} + v{F} \cdot \nabla f$

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
\nabla \cdot (f v{F}) &= \frac{\partial (f F_x)}{\partial x} + \frac{\partial (f F_y)}{\partial y} + \frac{\partial (f F_z)}{\partial z} \\[1em]
&= f \frac{\partial F_x}{\partial x} + F_x \frac{\partial f}{\partial x} + f \frac{\partial F_y}{\partial y} + F_y \frac{\partial f}{\partial y} + f \frac{\partial F_z}{\partial z} + F_z \frac{\partial f}{\partial z} \\[1em]
&= f \nabla \cdot v{F} + v{F} \cdot \nabla f
\end{align*}
$$
::::

**(d)** $\nabla \cdot (v{F} \times v{G}) = v{G} \cdot (\nabla \times v{F}) - v{F} \cdot (\nabla \times v{G})$

:::expandable
**Solution.** [Click to Expand]

We have:

$$
\begin{align*}
v{G} \cdot (\nabla \times v{F}) &= G_x ( \frac{\partial F_z}{\partial y} - \frac{\partial F_y}{\partial z} ) + G_y ( \frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x} ) + G_z ( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} ) \\[1em]
v{F} \cdot (\nabla \times v{G}) &= F_x ( \frac{\partial G_z}{\partial y} - \frac{\partial G_y}{\partial z} ) + F_y ( \frac{\partial G_x}{\partial z} - \frac{\partial G_z}{\partial x} ) + F_z ( \frac{\partial G_y}{\partial x} - \frac{\partial G_x}{\partial y} )
\end{align*}
$$

Then:

$$
\begin{align*}
v{G} \cdot (\nabla \times v{F}) &- v{F} \cdot (\nabla \times v{G}) = \\[1em]
& (G_z \frac{\partial F_y}{\partial x} + F_y \frac{\partial G_z}{\partial x})
\- (G_y \frac{\partial F_z}{\partial x} + F_z \frac{\partial G_y}{\partial x}) \\[1em]
\+ &(G_x \frac{\partial F_z}{\partial y} + F_z \frac{\partial G_x}{\partial y})
\- (G_z \frac{\partial F_x}{\partial y} + F_x \frac{\partial G_z}{\partial y}) \\[1em]
\+ &(G_y \frac{\partial F_x}{\partial z} + F_x \frac{\partial G_y}{\partial z})
\- (G_x \frac{\partial F_y}{\partial z} + F_y \frac{\partial G_x}{\partial z})
\end{align*}
$$

Then:

$$
\begin{align*}
v{G} \cdot &(\nabla \times v{F}) - v{F} \cdot (\nabla \times v{G}) \\[1em]
&=
\frac{\partial}{\partial x} (F_y G_z - F_z G_y) + \frac{\partial}{\partial y} (F_z G_x - F_x G_z) + \frac{\partial}{\partial z} (F_x G_y - F_y G_x) \\[1em]
&= \nabla \cdot (v{F} \times v{G})
\end{align*}
$$

::::

**(e)** $\nabla \times (f v{F}) = f \nabla \times v{F} + (\nabla f) \times v{F}$

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
\nabla \times (f v{F}) &= v{i} ( \frac{\partial (f F_z)}{\partial y} - \frac{\partial (f F_y)}{\partial z} ) \\[1em]
&\quad + v{j} ( \frac{\partial (f F_x)}{\partial z} - \frac{\partial (f F_z)}{\partial x} )\\[1em]
&\quad + v{k} ( \frac{\partial (f F_y)}{\partial x} - \frac{\partial (f F_x)}{\partial y} ) \\[1em]
&= v{i} ( f \frac{\partial F_z}{\partial y} + F_z \frac{\partial f}{\partial y} - f \frac{\partial F_y}{\partial z} - F_y \frac{\partial f}{\partial z} ) \\[1em]
&\quad + v{j} ( f \frac{\partial F_x}{\partial z} + F_x \frac{\partial f}{\partial z} - f \frac{\partial F_z}{\partial x} - F_z \frac{\partial f}{\partial x} ) \\[1em]
&\quad + v{k} ( f \frac{\partial F_y}{\partial x} + F_y \frac{\partial f}{\partial x} - f \frac{\partial F_x}{\partial y} - F_x \frac{\partial f}{\partial y} ) \\[1em]
&= f ( v{i} ( \frac{\partial F_z}{\partial y} - \frac{\partial F_y}{\partial z} ) + v{j} ( \frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x} ) + v{k} ( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} ) ) \\[1em]
&\quad + ( \frac{\partial f}{\partial y} F_z - \frac{\partial f}{\partial z} F_y ) v{i}
\+ ( \frac{\partial f}{\partial z} F_x - \frac{\partial f}{\partial x} F_z ) v{j} + ( \frac{\partial f}{\partial x} F_y - \frac{\partial f}{\partial y} F_x ) v{k} \\[1em]
&= f \nabla \times v{F} + (\nabla f) \times v{F}
\end{align*}
$$

::::

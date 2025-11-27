**Problem III-7.** Show that $\nabla \cdot (\nabla \times \mathbf{F}) = 0$. (Assume that
mixed second partial derivatives are independent of the order of differentiation.)

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
\nabla \times \mathbf{F} &= \mathbf{i} \left( \frac{\partial F_z}{\partial y} - \frac{\partial F_y}{\partial z} \right) \\
&+ \mathbf{j} \left( \frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x} \right) \\
&+ \mathbf{k} \left( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} \right)
\end{align*}
$$

Then:

$$
\begin{align*}
\nabla \cdot (\nabla \times \mathbf{F}) &= \frac{\partial F_z}{\partial x \partial y} -
\frac{\partial F_y}{\partial x \partial z} \\
&+ \frac{\partial F_x}{\partial y \partial z} - \frac{\partial F_z}{\partial x \partial y} \\
&+ \frac{\partial F_y}{\partial x \partial z} - \frac{\partial F_x}{\partial y \partial z} \\
&= 0
\end{align*}
$$
::::

**Problem III-24.** **(a)** There is an important theorem in vector calculus that says $\nabla \cdot \mathbf{G} = 0$ if and only if $\mathbf{G} = \nabla \times \mathbf{H}$.
To prove this we note first of all that $\mathbf{G} = \nabla \times \mathbf{H}$ implies $\nabla \cdot \mathbf{G} = 0$ (see problem III-7).

To show that $\nabla \cdot \mathbf{G} = 0$ implies $\mathbf{G} = \nabla \times \mathbf{H}$,
the simplest procedure is to give $\mathbf{H}$:

$$
\begin{align*}
H_x &= 0 \\\\[1em]
H_y &= \int_{x_0}^{x} G_z(x', y, z) \\, dx' \\\\[1em]
H_z &= - \int_{x_0}^{x} G_y(x', y, z) \\, dx' + \int_{y_0}^{y} G_x(x_0, y', z) \\, dy'
\end{align*}
$$

where $x_0$ and $y_0$ are arbitrary constants. Show by direct calculation that if $\nabla \cdot \mathbf{G} = 0$, then $\mathbf{G} = \nabla \times \mathbf{H}$.

:::expandable
**Solution.** [Click to Expand]

Since $\nabla \cdot \mathbf{G} = 0$, then:

$$
\frac{\partial G_x}{\partial x} = - \frac{\partial G_y}{\partial y} - \frac{\partial G_z}{\partial z} \tag{1}
$$

We have:

$$
\begin{align*}
\nabla \times \mathbf{H} &= \mathbf{i} \left( \frac{\partial H_z}{\partial y} - \frac{\partial H_y}{\partial z} \right) + \mathbf{j} \left( \frac{\partial H_x}{\partial z} - \frac{\partial H_z}{\partial x} \right) + \mathbf{k} \left( \frac{\partial H_y}{\partial x} - \frac{\partial H_x}{\partial y} \right) \\\\[1em]
&= \mathbf{i} \left( \frac{\partial H_z}{\partial y} - \frac{\partial H_y}{\partial z} \right)
\+ \mathbf{j} \left( 0 - \frac{\partial H_z}{\partial x} \right) + \mathbf{k} \left( \frac{\partial H_y}{\partial x} - 0 \right)
\end{align*}
$$

We have:

$$
\begin{align*}
\frac{\partial H_y}{\partial x} &= G_z(x, y, z) \\\\[1em]
\frac{\partial H_y}{\partial z} &= \int_{x_0}^{x} \frac{\partial G_z(x', y, z)}{\partial z} \\, dx' \\\\[1em]
\frac{\partial H_z}{\partial x} &= - G_y(x, y, z) \\\\[1em]
\frac{\partial H_z}{\partial y} &= - \int_{x_0}^{x} \frac{\partial G_y(x', y, z)}{\partial y} \\, dx' + G_x(x_0, y, z)
\end{align*}
$$

As a direct consequence, we have:

$$
\begin{align*}
(\nabla \times \mathbf{H})\_y &= G_y(x, y, z) \\\\[1em]
(\nabla \times \mathbf{H})\_z &= G_z(x, y, z)
\end{align*}
$$

To calculate $(\nabla \times \mathbf{H})\_x$, we have:

$$
(\nabla \times \mathbf{H})\_x = \int_{x_0}^{x} \left( - \frac{\partial G_y(x', y, z)}{\partial y} - \frac{\partial G_z(x', y, z)}{\partial z} \right) \\, dx' + G_x(x_0, y, z)
$$

Using (1), we have:

$$
(\nabla \times \mathbf{H})\_x = \int_{x_0}^{x} \frac{\partial G_x(x', y, z)}{\partial x} \\, dx' + G_x(x_0, y, z)
$$

Then using the fundamental theorem of calculus, we have:

$$
(\nabla \times \mathbf{H})\_x = G_x(x, y, z) - G_x(x_0, y, z) + G_x(x_0, y, z) = G_x(x, y, z)
$$

::::

**(b)** Is the vector function $\mathbf{H}$ specified in part (a) unique? That is, can we
alter it in any way without invalidating the relation $\mathbf{G} = \nabla \times \mathbf{H}$?

:::expandable
**Solution.** [Click to Expand]

No, the vector function $\mathbf{H}$ is not unique. For example, adding constants to the components of $\mathbf{H}$ does not change the value of $\nabla \times \mathbf{H}$.
::::

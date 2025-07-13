**Problem III-2.**
In the text we obtained the result

$$
(\nabla \times \mathbf{F})_z = \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y}
$$

by integrating over a small rectanglular path. As an example of the fact that this result
is independent of the path, rederive it, using a triangular path.

:::expandable
**Solution.** [Click to Expand]

 ![](III-2.png)

Assume the force $\mathbf{F}$ is given by:

$$
\mathbf{F} = F_x \mathbf{i} + F_y \mathbf{j} + F_z \mathbf{k}
$$

In the text on page 68 we saw that:

$$
\int_C \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds = \int_C (F_x \\, dx + F_y \\, dy + F_z \\, dz)
$$

Then for $C_1$, we have:

$$
\begin{align*}
\int_{C_1} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{y + \Delta y / 2}^{y - \Delta y / 2} F_y\left(x - \frac{\Delta x}{2} , u\right) \\, du
\\\\[1em]
& \approx -F_y\left(x - \frac{\Delta x}{2} , y\right) \Delta y
\end{align*}
$$

and for $C_2$, we have:

$$
\begin{align*}
\int_{C_2} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{x - \Delta x / 2}^{x + \Delta x / 2} F_x\left(u, y - \frac{\Delta y}{2}\right) \\, du
\\\\[1em]
& \approx F_x\left(x, y - \frac{\Delta y}{2}\right) \Delta x
\end{align*}
$$

and for $C_3$, we have:

$$
\begin{align*}
\int_{C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{C_3} \left( F_x \\, dx + F_y \\, dy \right) \\\\[1em]
&= \int_{x + \Delta x / 2}^{x - \Delta x / 2} F_x\left(u, y(u)\right) \\, du +
\int_{y - \Delta y / 2}^{y + \Delta y / 2} F_y\left(x(u), u\right) \\, du
\\\\[1em]
& \approx -F_x\left(x, y\right) \Delta x + F_y\left(x, y\right) \Delta y
\end{align*}
$$

Thus, we have:

$$
\begin{align*}
\int_{C_1+C_2+C_3} \mathbf{F} &\cdot \hat{\mathbf{t}} \\, ds \approx \\\\[0.5em]
&\Delta y \left( F_y(x, y) - F_y\left(x - \frac{\Delta x}{2}, y\right) \right) + \\\\[0.5em]
&\Delta x \left( F_x\left(x, y - \frac{\Delta y}{2}\right) - F_x(x, y) \right)
\end{align*}
$$

Since $\Delta A = \dfrac{\Delta x \Delta y}{2}$, we have:

$$
\begin{align*}
\frac{1}{\Delta A} \int_{C_1+C_2+C_3} \mathbf{F} &\cdot \hat{\mathbf{t}} \\, ds \approx \\\\[0.5em]
& \frac{F_y(x, y) - F_y\left(x - \frac{\Delta x}{2}, y\right)}
{\Delta x / 2} - \\\\[0.5em]
&\frac{F_x(x, y) - F_x\left(x, y - \frac{\Delta y}{2}\right)}{\Delta y / 2}
\end{align*}
$$

So, we have:

$$
\lim_{\Delta A \to 0} \frac{1}{\Delta A} \int_{C_1+C_2+C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds =
\frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y}
$$
::::

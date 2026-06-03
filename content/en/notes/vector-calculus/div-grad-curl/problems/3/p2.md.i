**Problem III-2.**
In the text we obtained the result

$$
(\nabla \times v{F})_z = \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y}
$$

by integrating over a small rectanglular path. As an example of the fact that this result
is independent of the path, rederive it, using a triangular path.

:::expandable
**Solution.** [Click to Expand]

 ![](III-2.png)

Assume the force $v{F}$ is given by:

$$
v{F} = F_x v{i} + F_y v{j} + F_z v{k}
$$

In the text on page 68 we saw that:

$$
\int_C v{F} \cdot unit{t} \, ds = \int_C (F_x \, dx + F_y \, dy + F_z \, dz)
$$

Then for $C_1$, we have:

$$
\begin{align*}
\int_{C_1} v{F} \cdot unit{t} \, ds &= \int_{y + \Delta y / 2}^{y - \Delta y / 2} F_y(x - \frac{\Delta x}{2} , u) \, du
\\[1em]
& \approx -F_y(x - \frac{\Delta x}{2} , y) \Delta y
\end{align*}
$$

and for $C_2$, we have:

$$
\begin{align*}
\int_{C_2} v{F} \cdot unit{t} \, ds &= \int_{x - \Delta x / 2}^{x + \Delta x / 2} F_x(u, y - \frac{\Delta y}{2}) \, du
\\[1em]
& \approx F_x(x, y - \frac{\Delta y}{2}) \Delta x
\end{align*}
$$

and for $C_3$, we have:

$$
\begin{align*}
\int_{C_3} v{F} \cdot unit{t} \, ds &= \int_{C_3} ( F_x \, dx + F_y \, dy ) \\[1em]
&= \int_{x + \Delta x / 2}^{x - \Delta x / 2} F_x(u, y(u)) \, du +
\int_{y - \Delta y / 2}^{y + \Delta y / 2} F_y(x(u), u) \, du
\\[1em]
& \approx -F_x(x, y) \Delta x + F_y(x, y) \Delta y
\end{align*}
$$

Thus, we have:

$$
\begin{align*}
\int_{C_1+C_2+C_3} v{F} &\cdot unit{t} \, ds \approx \\[0.5em]
&\Delta y ( F_y(x, y) - F_y(x - \frac{\Delta x}{2}, y) ) + \\[0.5em]
&\Delta x ( F_x(x, y - \frac{\Delta y}{2}) - F_x(x, y) )
\end{align*}
$$

Since $\Delta A = \dfrac{\Delta x \Delta y}{2}$, we have:

$$
\begin{align*}
\frac{1}{\Delta A} \int_{C_1+C_2+C_3} v{F} &\cdot unit{t} \, ds \approx \\[0.5em]
& \frac{F_y(x, y) - F_y(x - \frac{\Delta x}{2}, y)}
{\Delta x / 2} - \\[0.5em]
&\frac{F_x(x, y) - F_x(x, y - \frac{\Delta y}{2})}{\Delta y / 2}
\end{align*}
$$

So, we have:

$$
\lim_{\Delta A -> 0} \frac{1}{\Delta A} \int_{C_1+C_2+C_3} v{F} \cdot unit{t} \, ds =
\frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y}
$$
::::

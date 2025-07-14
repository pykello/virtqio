**Problem III-29.**

In the text we defined the curl as the limit of a certain ratio. An
alternative definition is provided by the equation

$$
\nabla \times \mathbf{F} = \lim_{\Delta V \to 0} \frac{1}{\Delta V} \iint_S \hat{\mathbf{n}} \times \mathbf{F} \\, dS
$$

where $\mathbf{F}$ is a vector function of position, the integration is carried out
over a closed surface $S$ which encloses the volume $\Delta V$, and $\hat{\mathbf{n}}$
is the unit vector normal to $S$ pointing outward.

**(a)** Integrate over a "cuboid" and show that the definition given above
yields Equation (III-7b).

:::expandable
**Solution.** [Click to Expand]

Consider the cuboid shown in the figure below:

 ![](III-29a.jpg)

**Side S1.**
- Normal: $\hat{\mathbf{j}}$,
- $\hat{\mathbf{n}} \times \mathbf{F} = \hat{\mathbf{i}} F_z - \hat{\mathbf{k}} F_x$,
- Area: $dS = \Delta x \\, \Delta z$.

Then, we have:

$$
\iint_{S_1} \hat{\mathbf{n}} \times \mathbf{F} \\, dS \approx
\Delta x \Delta z \left( \mathbf{i} F_z(x, y + \frac{\Delta y}{2}, z) - \mathbf{k} F_x(x, y + \frac{\Delta y}{2}, z) \right)
$$

Then:

$$
\frac{1}{\Delta V} \iint_{S_1} \hat{\mathbf{n}} \times \mathbf{F} \\, dS \approx
\frac{\mathbf{i} F_z(x, y + \frac{\Delta y}{2}, z) - \mathbf{k} F_x(x, y + \frac{\Delta y}{2}, z)}{\Delta y}
$$

**Side S2.**
- Normal: $-\hat{\mathbf{j}}$,
- $\hat{\mathbf{n}} \times \mathbf{F} = -\hat{\mathbf{i}} F_z + \hat{\mathbf{k}} F_x$,
- Area: $dS = \Delta x \\, \Delta z$.

Then, we have:

$$
\iint_{S_2} \hat{\mathbf{n}} \times \mathbf{F} \\, dS \approx
-\Delta x \Delta z \left( \mathbf{i} F_z(x, y - \frac{\Delta y}{2}, z) - \mathbf{k} F_x(x, y - \frac{\Delta y}{2}, z) \right)
$$

Then:

$$
\frac{1}{\Delta V} \iint_{S_2} \hat{\mathbf{n}} \times \mathbf{F} \\, dS \approx
-\frac{\mathbf{i} F_z(x, y - \frac{\Delta y}{2}, z) - \mathbf{k} F_x(x, y - \frac{\Delta y}{2}, z)}{\Delta y}
$$

**Adding S1 and S2.**

$$
\begin{align*}
\frac{1}{\Delta V} \iint_{S_1+S_2} &\hat{\mathbf{n}} \times \mathbf{F} \\, dS \approx \\\\
& \mathbf{i} \frac{F_z(x, y + \frac{\Delta y}{2}, z) - F_z(x, y - \frac{\Delta y}{2}, z)}{\Delta y} \\\\
\- &\mathbf{k} \frac{F_x(x, y + \frac{\Delta y}{2}, z) - F_x(x, y - \frac{\Delta y}{2}, z)}{\Delta y}
\end{align*}
$$

which means:

$$
\lim_{\Delta V \to 0} \frac{1}{\Delta V} \iint_{S_1+S_2} \hat{\mathbf{n}} \times \mathbf{F} \\, dS =
\mathbf{i} \frac{\partial F_z}{\partial y} - \mathbf{k} \frac{\partial F_x}{\partial y}
$$


**S3 and S4.**
Similarly, we can show that:

$$
\lim_{\Delta V \to 0} \frac{1}{\Delta V} \iint_{S_3+S_4} \hat{\mathbf{n}} \times \mathbf{F} \\, dS =
\mathbf{j} \frac{\partial F_x}{\partial z} - \mathbf{i} \frac{\partial F_y}{\partial z}
$$

**S5 and S6.**
Similarly, we can show that:

$$
\lim_{\Delta V \to 0} \frac{1}{\Delta V} \iint_{S_5+S_6} \hat{\mathbf{n}} \times \mathbf{F} \\, dS =
\mathbf{k} \frac{\partial F_y}{\partial x} - \mathbf{j} \frac{\partial F_z}{\partial x}
$$


Putting these together, we have:

$$
\begin{align*}
\nabla \times \mathbf{F} &= \lim_{\Delta V \to 0} \frac{1}{\Delta V} \iint_S \hat{\mathbf{n}} \times \mathbf{F} \\, dS
\\\\[1em] &=
\mathbf{i} \left(\frac{\partial F_z}{\partial y} - \frac{\partial F_y}{\partial z}\right) +
\mathbf{j} \left(\frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x}\right) +
\mathbf{k} \left(\frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y}\right)
\end{align*}
$$

::::

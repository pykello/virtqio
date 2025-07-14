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

**(b)** Arguing as we did in the text in establishing the divergence theorem,
use the above expression for the curl to derive the equation

$$
\iint_S \hat{\mathbf{n}} \times \mathbf{F} \\, dS =
\iiint_V \nabla \times \mathbf{F} \\, dV
$$

:::expandable
**Solution.** [Click to Expand]

Assume we partition the volume $V$ into $N$ small cubes of volume $\Delta V$.

Since normal vector of overlapping sides of two adjacent
cubes are equal and opposite, then $\hat{\mathbf{n}} \times \mathbf{F}$
of two overlapping sides of two adjacent cubes will cancel out.

Then, we have:

$$
\iint_S \hat{\mathbf{n}} \times \mathbf{F} \\, dS =
\iint_{S_1} \hat{\mathbf{n}} \times \mathbf{F} \\, dS + \ldots +
\iint_{S_N} \hat{\mathbf{n}} \times \mathbf{F} \\, dS
$$

where $S_i$ is the surface of the $i$-th cube.

Also, since we have:

$$
\nabla \times \mathbf{F}(x_i, y_i, z_i) \approx \frac{1}{\Delta V} \iint_{S_i} \hat{\mathbf{n}} \times \mathbf{F} \\, dS
$$

(where $(x_i, y_i, z_i)$ is the center of the $i$-th cube), then we have:

$$
(\nabla \times \mathbf{F}(x_i, y_i, z_i)) \Delta V \approx
\iint_{S_i} \hat{\mathbf{n}} \times \mathbf{F} \\, dS
$$

Summing over all $N$ cubes and taking the limit as $\Delta V \to 0$, we have:

$$
\iiint_V \nabla \times \mathbf{F} \\, dV =
\iint_S \hat{\mathbf{n}} \times \mathbf{F} \\, dS
$$

::::

**(c)** Derive the equation in part (b) directly from the divergence theorem.

:::expandable
**Solution.** [Click to Expand]

Expanding $\nabla \times \mathbf{F}$ gives:

$$
\begin{align*}
\iiint_V \nabla &\times \mathbf{F} \\, dV = \\\\[1em]
&\mathbf{i} \iiint_V \left( \frac{\partial F_z}{\partial y} - \frac{\partial F_y}{\partial z} \right) dV +
\\\\[1em]
&\mathbf{j} \iiint_V \left( \frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x} \right) dV +
\\\\[1em]
&\mathbf{k} \iiint_V \left( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} \right) dV
\end{align*}
$$

Which can be rewritten as:

$$
\begin{align*}
\iiint_V \nabla \times \mathbf{F} \\, dV &= \\\\[1em]
&\mathbf{i} \iiint_V \nabla \cdot \left( 0, F_z, -F_y \right) \\, dV +
\\\\[1em]
&\mathbf{j} \iiint_V \nabla \cdot \left(-F_z, 0, F_x \right) \\, dV +
\\\\[1em]
&\mathbf{k} \iiint_V \nabla \cdot \left( F_y, -F_x, 0 \right) \\, dV
\end{align*}
$$

Using the divergence theorem, we have:

$$
\begin{align*}
\iiint_V \nabla \times \mathbf{F} \\, dV &= \\\\[1em]
&\mathbf{i} \iint_S \left( 0, F_z, -F_y \right) \cdot \hat{\mathbf{n}} \\, dS +
\\\\[1em]
&\mathbf{j} \iint_S \left(-F_z, 0, F_x \right) \cdot \hat{\mathbf{n}} \\, dS +
\\\\[1em]
&\mathbf{k} \iint_S \left( F_y, -F_x, 0 \right) \cdot \hat{\mathbf{n}} \\, dS
\end{align*}
$$

which can be rewritten as:

$$
\begin{align*}
\iiint_V &\nabla \times \mathbf{F} \\, dV = \\\\[1em]
&\iint_S \left( \mathbf{i} (F_z \hat{\mathbf{n}}_y - F_y \hat{\mathbf{n}}_z) +
\\\\[1em]
\mathbf{j} (-F_z \hat{\mathbf{n}}_x + F_x \hat{\mathbf{n}}_z) +
\\\\[1em]
\mathbf{k} (F_y \hat{\mathbf{n}}_x - F_x \hat{\mathbf{n}}_y) \right) \\, dS
\end{align*}
$$

So:

$$
\iiint_V \nabla \times \mathbf{F} \\, dV =
\iint_S \hat{\mathbf{n}} \times \mathbf{F} \\, dS
$$
::::

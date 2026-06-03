**Problem III-29.**

In the text we defined the curl as the limit of a certain ratio. An
alternative definition is provided by the equation

$$
\nabla \times v{F} = \lim_{\Delta V -> 0} \frac{1}{\Delta V} \iint_S unit{n} \times v{F} \, dS
$$

where $v{F}$ is a vector function of position, the integration is carried out
over a closed surface $S$ which encloses the volume $\Delta V$, and $unit{n}$
is the unit vector normal to $S$ pointing outward.

**(a)** Integrate over a "cuboid" and show that the definition given above
yields Equation (III-7b).

:::expandable
**Solution.** [Click to Expand]

Consider the cuboid shown in the figure below:

 ![](III-29a.jpg)

**Side S1.**
- Normal: $unit{j}$,
- $unit{n} \times v{F} = unit{i} F_z - unit{k} F_x$,
- Area: $dS = \Delta x \\, \Delta z$.

Then, we have:

$$
\iint_{S_1} unit{n} \times v{F} \, dS \approx
\Delta x \Delta z ( v{i} F_z(x, y + \frac{\Delta y}{2}, z) - v{k} F_x(x, y + \frac{\Delta y}{2}, z) )
$$

Then:

$$
\frac{1}{\Delta V} \iint_{S_1} unit{n} \times v{F} \, dS \approx
\frac{v{i} F_z(x, y + \frac{\Delta y}{2}, z) - v{k} F_x(x, y + \frac{\Delta y}{2}, z)}{\Delta y}
$$

**Side S2.**
- Normal: $-unit{j}$,
- $unit{n} \times v{F} = -unit{i} F_z + unit{k} F_x$,
- Area: $dS = \Delta x \\, \Delta z$.

Then, we have:

$$
\iint_{S_2} unit{n} \times v{F} \, dS \approx
-\Delta x \Delta z ( v{i} F_z(x, y - \frac{\Delta y}{2}, z) - v{k} F_x(x, y - \frac{\Delta y}{2}, z) )
$$

Then:

$$
\frac{1}{\Delta V} \iint_{S_2} unit{n} \times v{F} \, dS \approx
-\frac{v{i} F_z(x, y - \frac{\Delta y}{2}, z) - v{k} F_x(x, y - \frac{\Delta y}{2}, z)}{\Delta y}
$$

**Adding S1 and S2.**

$$
\begin{align*}
\frac{1}{\Delta V} \iint_{S_1+S_2} &unit{n} \times v{F} \, dS \approx \\
& v{i} \frac{F_z(x, y + \frac{\Delta y}{2}, z) - F_z(x, y - \frac{\Delta y}{2}, z)}{\Delta y} \\
\- &v{k} \frac{F_x(x, y + \frac{\Delta y}{2}, z) - F_x(x, y - \frac{\Delta y}{2}, z)}{\Delta y}
\end{align*}
$$

which means:

$$
\lim_{\Delta V -> 0} \frac{1}{\Delta V} \iint_{S_1+S_2} unit{n} \times v{F} \, dS =
v{i} \frac{\partial F_z}{\partial y} - v{k} \frac{\partial F_x}{\partial y}
$$


**S3 and S4.**
Similarly, we can show that:

$$
\lim_{\Delta V -> 0} \frac{1}{\Delta V} \iint_{S_3+S_4} unit{n} \times v{F} \, dS =
v{j} \frac{\partial F_x}{\partial z} - v{i} \frac{\partial F_y}{\partial z}
$$

**S5 and S6.**
Similarly, we can show that:

$$
\lim_{\Delta V -> 0} \frac{1}{\Delta V} \iint_{S_5+S_6} unit{n} \times v{F} \, dS =
v{k} \frac{\partial F_y}{\partial x} - v{j} \frac{\partial F_z}{\partial x}
$$


Putting these together, we have:

$$
\begin{align*}
\nabla \times v{F} &= \lim_{\Delta V -> 0} \frac{1}{\Delta V} \iint_S unit{n} \times v{F} \, dS
\\[1em] &=
v{i} (\frac{\partial F_z}{\partial y} - \frac{\partial F_y}{\partial z}) +
v{j} (\frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x}) +
v{k} (\frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y})
\end{align*}
$$

::::

**(b)** Arguing as we did in the text in establishing the divergence theorem,
use the above expression for the curl to derive the equation

$$
\iint_S unit{n} \times v{F} \, dS =
\iiint_V \nabla \times v{F} \, dV
$$

:::expandable
**Solution.** [Click to Expand]

Assume we partition the volume $V$ into $N$ small cubes of volume $\Delta V$.

Since normal vector of overlapping sides of two adjacent
cubes are equal and opposite, then $unit{n} \times v{F}$
of two overlapping sides of two adjacent cubes will cancel out.

Then, we have:

$$
\iint_S unit{n} \times v{F} \, dS =
\iint_{S_1} unit{n} \times v{F} \, dS + \ldots +
\iint_{S_N} unit{n} \times v{F} \, dS
$$

where $S_i$ is the surface of the $i$-th cube.

Also, since we have:

$$
\nabla \times v{F}(x_i, y_i, z_i) \approx \frac{1}{\Delta V} \iint_{S_i} unit{n} \times v{F} \, dS
$$

(where $(x_i, y_i, z_i)$ is the center of the $i$-th cube), then we have:

$$
(\nabla \times v{F}(x_i, y_i, z_i)) \Delta V \approx
\iint_{S_i} unit{n} \times v{F} \, dS
$$

Summing over all $N$ cubes and taking the limit as $\Delta V -> 0$, we have:

$$
\iiint_V \nabla \times v{F} \, dV =
\iint_S unit{n} \times v{F} \, dS
$$

::::

**(c)** Derive the equation in part (b) directly from the divergence theorem.

:::expandable
**Solution.** [Click to Expand]

Expanding $\nabla \times v{F}$ gives:

$$
\begin{align*}
\iiint_V \nabla &\times v{F} \, dV = \\[1em]
&v{i} \iiint_V ( \frac{\partial F_z}{\partial y} - \frac{\partial F_y}{\partial z} ) dV +
\\[1em]
&v{j} \iiint_V ( \frac{\partial F_x}{\partial z} - \frac{\partial F_z}{\partial x} ) dV +
\\[1em]
&v{k} \iiint_V ( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} ) dV
\end{align*}
$$

Which can be rewritten as:

$$
\begin{align*}
\iiint_V \nabla \times v{F} \, dV &= \\[1em]
&v{i} \iiint_V \nabla \cdot ( 0, F_z, -F_y ) \, dV +
\\[1em]
&v{j} \iiint_V \nabla \cdot (-F_z, 0, F_x ) \, dV +
\\[1em]
&v{k} \iiint_V \nabla \cdot ( F_y, -F_x, 0 ) \, dV
\end{align*}
$$

Using the divergence theorem, we have:

$$
\begin{align*}
\iiint_V \nabla \times v{F} \, dV &= \\[1em]
&v{i} \iint_S ( 0, F_z, -F_y ) \cdot unit{n} \, dS +
\\[1em]
&v{j} \iint_S (-F_z, 0, F_x ) \cdot unit{n} \, dS +
\\[1em]
&v{k} \iint_S ( F_y, -F_x, 0 ) \cdot unit{n} \, dS
\end{align*}
$$

which can be rewritten as:

$$
\begin{align*}
\iiint_V &\nabla \times v{F} \, dV = \\[1em]
&\iint_S ( v{i} (F_z unit{n}_y - F_y unit{n}_z) +
\\[1em]
v{j} (-F_z unit{n}_x + F_x unit{n}_z) +
\\[1em]
v{k} (F_y unit{n}_x - F_x unit{n}_y) ) \, dS
\end{align*}
$$

So:

$$
\iiint_V \nabla \times v{F} \, dV =
\iint_S unit{n} \times v{F} \, dS
$$
::::

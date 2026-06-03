**Problem III-29.**

In the text we defined the curl as the limit of a certain ratio. An
alternative definition is provided by the equation

:::math
\nabla cross v{F} = lim[Delta V -> 0] \frac{1}{Delta V} iint[S] unit{n} cross v{F} \, dS
:::

where $v{F}$ is a vector function of position, the integration is carried out
over a closed surface $S$ which encloses the volume $Delta V$, and $unit{n}$
is the unit vector normal to $S$ pointing outward.

**(a)** Integrate over a "cuboid" and show that the definition given above
yields Equation (III-7b).

:::expandable
**Solution.** [Click to Expand]

Consider the cuboid shown in the figure below:

 ![](III-29a.jpg)

**Side S1.**
- Normal: $unit{j}$,
- $unit{n} cross v{F} = unit{i} F_z - unit{k} F_x$,
- Area: $dS = Delta x \, Delta z$.

Then, we have:

:::math
iint[S_1] unit{n} cross v{F} \, dS \approx
Delta x Delta z ( v{i} F_z(x, y + \frac{Delta y}{2}, z) - v{k} F_x(x, y + \frac{Delta y}{2}, z) )
:::

Then:

:::math
\frac{1}{Delta V} iint[S_1] unit{n} cross v{F} \, dS \approx
\frac{v{i} F_z(x, y + \frac{Delta y}{2}, z) - v{k} F_x(x, y + \frac{Delta y}{2}, z)}{Delta y}
:::

**Side S2.**
- Normal: $-unit{j}$,
- $unit{n} cross v{F} = -unit{i} F_z + unit{k} F_x$,
- Area: $dS = Delta x \, Delta z$.

Then, we have:

:::math
iint[S_2] unit{n} cross v{F} \, dS \approx
-Delta x Delta z ( v{i} F_z(x, y - \frac{Delta y}{2}, z) - v{k} F_x(x, y - \frac{Delta y}{2}, z) )
:::

Then:

:::math
\frac{1}{Delta V} iint[S_2] unit{n} cross v{F} \, dS \approx
-\frac{v{i} F_z(x, y - \frac{Delta y}{2}, z) - v{k} F_x(x, y - \frac{Delta y}{2}, z)}{Delta y}
:::

**Adding S1 and S2.**

:::math align
\frac{1}{Delta V} iint[S_1+S_2] &unit{n} cross v{F} \, dS \approx
& v{i} \frac{F_z(x, y + \frac{Delta y}{2}, z) - F_z(x, y - \frac{Delta y}{2}, z)}{Delta y}
- &v{k} \frac{F_x(x, y + \frac{Delta y}{2}, z) - F_x(x, y - \frac{Delta y}{2}, z)}{Delta y}
:::

which means:

:::math
lim[Delta V -> 0] \frac{1}{Delta V} iint[S_1+S_2] unit{n} cross v{F} \, dS =
v{i} pd(F_z, y) - v{k} pd(F_x, y)
:::


**S3 and S4.**
Similarly, we can show that:

:::math
lim[Delta V -> 0] \frac{1}{Delta V} iint[S_3+S_4] unit{n} cross v{F} \, dS =
v{j} pd(F_x, z) - v{i} pd(F_y, z)
:::

**S5 and S6.**
Similarly, we can show that:

:::math
lim[Delta V -> 0] \frac{1}{Delta V} iint[S_5+S_6] unit{n} cross v{F} \, dS =
v{k} pd(F_y, x) - v{j} pd(F_z, x)
:::


Putting these together, we have:

:::math align
\nabla cross v{F} &= lim[Delta V -> 0] \frac{1}{Delta V} iint[S] unit{n} cross v{F} \, dS
&= v{i} (pd(F_z, y) - pd(F_y, z)) + v{j} (pd(F_x, z) - pd(F_z, x)) + v{k} (pd(F_y, x) - pd(F_x, y))
:::

::::

**(b)** Arguing as we did in the text in establishing the divergence theorem,
use the above expression for the curl to derive the equation

:::math
iint[S] unit{n} cross v{F} \, dS =
iiint[V] \nabla cross v{F} \, dV
:::

:::expandable
**Solution.** [Click to Expand]

Assume we partition the volume $V$ into $N$ small cubes of volume $Delta V$.

Since normal vector of overlapping sides of two adjacent
cubes are equal and opposite, then $unit{n} cross v{F}$
of two overlapping sides of two adjacent cubes will cancel out.

Then, we have:

:::math
iint[S] unit{n} cross v{F} \, dS =
iint[S_1] unit{n} cross v{F} \, dS + ... +
iint[S_N] unit{n} cross v{F} \, dS
:::

where $S_i$ is the surface of the $i$-th cube.

Also, since we have:

:::math
\nabla cross v{F}(x_i, y_i, z_i) \approx \frac{1}{Delta V} iint[S_i] unit{n} cross v{F} \, dS
:::

(where $(x_i, y_i, z_i)$ is the center of the $i$-th cube), then we have:

:::math
(\nabla cross v{F}(x_i, y_i, z_i)) Delta V \approx
iint[S_i] unit{n} cross v{F} \, dS
:::

Summing over all $N$ cubes and taking the limit as $Delta V -> 0$, we have:

:::math
iiint[V] \nabla cross v{F} \, dV =
iint[S] unit{n} cross v{F} \, dS
:::

::::

**(c)** Derive the equation in part (b) directly from the divergence theorem.

:::expandable
**Solution.** [Click to Expand]

Expanding $\nabla cross v{F}$ gives:

:::math align
iiint[V] \nabla &cross v{F} \, dV =
&v{i} iiint[V] ( pd(F_z, y) - pd(F_y, z) ) dV +
&v{j} iiint[V] ( pd(F_x, z) - pd(F_z, x) ) dV +
&v{k} iiint[V] ( pd(F_y, x) - pd(F_x, y) ) dV
:::

Which can be rewritten as:

:::math align
iiint[V] \nabla cross v{F} \, dV &=
&v{i} iiint[V] \nabla dot ( 0, F_z, -F_y ) \, dV +
&v{j} iiint[V] \nabla dot (-F_z, 0, F_x ) \, dV +
&v{k} iiint[V] \nabla dot ( F_y, -F_x, 0 ) \, dV
:::

Using the divergence theorem, we have:

:::math align
iiint[V] \nabla cross v{F} \, dV &=
&v{i} iint[S] ( 0, F_z, -F_y ) dot unit{n} \, dS +
&v{j} iint[S] (-F_z, 0, F_x ) dot unit{n} \, dS +
&v{k} iint[S] ( F_y, -F_x, 0 ) dot unit{n} \, dS
:::

which can be rewritten as:

:::math align
iiint[V] &\nabla cross v{F} \, dV =
&iint[S] ( v{i} (F_z unit{n}_y - F_y unit{n}_z) +
v{j} (-F_z unit{n}_x + F_x unit{n}_z) +
v{k} (F_y unit{n}_x - F_x unit{n}_y) ) \, dS
:::

So:

:::math
iiint[V] \nabla cross v{F} \, dV =
iint[S] unit{n} cross v{F} \, dS
:::
::::

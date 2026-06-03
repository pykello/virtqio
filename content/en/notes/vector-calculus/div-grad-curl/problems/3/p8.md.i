**Problem III-8.** In the text we obtained the $z$-component of $\nabla cross v{F}$
in cylindrical coordinates. Proceeding the same way, obtain the $theta$- and $r$-components.

:::expandable
**Solution ($theta$-component).** [Click to Expand]

Using the path shown in the figure, we'll yield the $theta$-component of $\nabla cross v{F}$ in cylindrical coordinates.

:::figure III-8a.jpg
:::

Viewed from above:

:::figure III-8b.jpg
:::

For $C_1$, we have $unit{t} = unit{e}_r$ and $ds = dr$. Then:

:::math align
int[C_1] v{F} dot unit{t} \, ds &= int[r - Delta r / 2..r + Delta r / 2] F_r(u, theta, z - \frac{Delta z}{2}) \, du
&\approx F_r(r, theta, z - \frac{Delta z}{2}) Delta r
:::

For $C_2$, we have $unit{t} = v{e}_z$ and $ds = dz$. Then:

:::math align
int[C_2] v{F} dot unit{t} \, ds &= int[z - Delta z / 2..z + Delta z / 2] F_z(r + Delta r / 2, theta, u) \, du
&\approx F_z(r + \frac{Delta r}{2}, theta, z) Delta z
:::

For $C_3$, we have $unit{t} = -unit{e}_r$ and $ds = -dr$. Then:

:::math align
int[C_3] v{F} dot unit{t} \, ds &= int[r + Delta r / 2..r - Delta r / 2] (-F_r(u, theta, z + \frac{Delta z}{2})) \, (-du)
&\approx -F_r(r, theta, z + \frac{Delta z}{2}) Delta r
:::

For $C_4$, we have $unit{t} = -unit{e}_z$ and $ds = -dz$. Then:

:::math align
int[C_4] v{F} dot unit{t} \, ds &= int[z + Delta z / 2..z - Delta z / 2] (-F_z(r - Delta r / 2, theta, u)) \, (-du)
&\approx -F_z(r - \frac{Delta r}{2}, theta, z) Delta z
:::

Then, we have:

:::math align
int[C_1 + C_2 + C_3 + C_4] v{F} &dot unit{t} \, ds \approx
&Delta r ( F_r(r, theta, z - \frac{Delta z}{2}) - F_r(r, theta, z + \frac{Delta z}{2}) ) +
&Delta z ( F_z(r + \frac{Delta r}{2}, theta, z) - F_z(r - \frac{Delta r}{2}, theta, z) )
:::

Since $Delta A = Delta r Delta z$, we have:

:::math align
\frac{1}{Delta A} int[C_1 + C_2 + C_3 + C_4] v{F} &dot unit{t} \, ds \approx
& \frac{F_r(r, theta, z - \dfrac{Delta z}{2}) - F_r(r, theta, z + \dfrac{Delta z}{2})} {Delta z} -
&\frac{F_z(r + \dfrac{Delta r}{2}, theta, z) - F_z(r - \dfrac{Delta r}{2}, theta, z)}{Delta r}
:::

So, $theta$-component of $\nabla cross v{F}$ is:

:::math
lim[Delta A -> 0] \frac{1}{Delta A} int[C_1 + C_2 + C_3 + C_4] v{F} dot unit{t} \, ds =
pd(F_r, z) - pd(F_z, r)
:::

::::

:::expandable
**Solution ($r$-component).** [Click to Expand]

Using the path shown in the figure, we'll yield the $r$-component of $\nabla cross v{F}$ in cylindrical coordinates.

:::figure III-8c.jpg
:::

For $C_1$, we have $unit{t} = unit{e}_theta$ and $ds = r dtheta$. Then:

:::math align
int[C_1] v{F} dot unit{t} \, ds &= int[theta - Delta theta / 2..theta + Delta theta / 2] F_theta(r, u, z - \frac{Delta z}{2}) \, r \, du
&\approx F_theta(r, theta, z - \frac{Delta z}{2}) r Delta theta
:::

For $C_2$, we have $unit{t} = unit{e}_z$ and $ds = dz$. Then:

:::math align
int[C_2] v{F} dot unit{t} \, ds &= int[z - Delta z / 2..z + Delta z / 2] F_z(r, theta + \frac{Delta theta}{2}, u) \, du
&\approx F_z(r, theta + \frac{Delta theta}{2}, z) Delta z
:::

For $C_3$, we have $unit{t} = -unit{e}_theta$ and $ds = -r dtheta$. Then:

:::math align
int[C_3] v{F} dot unit{t} \, ds &= int[theta + Delta theta / 2..theta - Delta theta / 2] (-F_theta(r, u, z + \frac{Delta z}{2})) \, (-r \, du)
&\approx -F_theta(r, theta, z + \frac{Delta z}{2}) r Delta theta
:::

For $C_4$, we have $unit{t} = -unit{e}_z$ and $ds = -dz$. Then:

:::math align
int[C_4] v{F} dot unit{t} \, ds &= int[z + Delta z / 2..z - Delta z / 2] (-F_z(r, theta - \frac{Delta theta}{2}, u)) \, (-du)
&\approx -F_z(r, theta - \frac{Delta theta}{2}, z) Delta z
:::

Then, we have:

:::math align
int[C_1 + C_2 + C_3 + C_4] v{F} &dot unit{t} \, ds \approx
&r \, Delta theta ( F_theta(r, theta, z - \frac{Delta z}{2}) - F_theta(r, theta, z + \frac{Delta z}{2}) ) +
&Delta z ( F_z(r, theta + \frac{Delta theta}{2}, z) - F_z(r, theta - \frac{Delta theta}{2}, z) )
:::

Since $Delta A = r Delta theta Delta z$, we have:

:::math align
\frac{1}{Delta A} int[C_1 + C_2 + C_3 + C_4] v{F} &dot unit{t} \, ds \approx
& \frac{F_z(r, theta + \dfrac{Delta theta}{2}, z) - F_z(r, theta - \dfrac{Delta theta}{2}, z)} {r \, Delta theta} -
&\frac{F_theta(r, theta, z + \dfrac{Delta z}{2}) - F_theta(r, theta, z - \dfrac{Delta z}{2})}{Delta z}
:::

So, $r$-component of $\nabla cross v{F}$ is:

:::math
lim[Delta A -> 0] \frac{1}{Delta A} int[C_1 + C_2 + C_3 + C_4] v{F} dot unit{t} \, ds =
\frac{1}{r} \, pd(F_z, theta) - pd(F_{theta}, z)
:::

::::

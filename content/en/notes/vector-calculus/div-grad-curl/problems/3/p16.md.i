**Problem III-16.**

**(a)** Consider a vector function with the property $\nabla cross v{F} = 0$ everywhere on two closed curves $C_1$ and $C_2$ and on any capping surface $S$ of the
region enclosed by them. Show that the circulation of $v{F}$ around $C_1$ equals
the circulation of $v{F}$ around $C_2$.

:::figure III-16a.jpg
:::

:::expandable
**Solution.** [Click to Expand]

Form $C_3$ by joining $C_1$ and $C_2$ with a segment on $S$ and reversing the direction of $C_1$.

In figure below $a$ and $b$ segments completely overlap but in opposite directions. They connect
inner and outer parts of the curve by moving along $S$.

:::figure III-16b.jpg
:::

Then $S$ is a capping surface for the region enclosed by $C_3$.

Then, we have:

:::math
oint[C_3] v{F} dot unit{t} \, ds = iint[S] \nabla cross v{F} dot unit{n} \, dS
:::

Since $\nabla cross v{F} = 0$, we have:

:::math
oint[C_3] v{F} dot unit{t} \, ds = 0 #tag 1
:::

Since we have reversed the direction of $C_1$ and line integrals along $a$ and $b$ cancel each other, we have:

:::math
oint[C_3] v{F} dot unit{t} \, ds = -oint[C_1] v{F} dot unit{t} \, ds + oint[C_2] v{F} dot unit{t} \, ds #tag 2
:::

Putting (1) and (2) together, we have:

:::math
-oint[C_1] v{F} dot unit{t} \, ds + oint[C_2] v{F} dot unit{t} \, ds = 0
:::

Thus, we have:

:::math
oint[C_1] v{F} dot unit{t} \, ds = oint[C_2] v{F} dot unit{t} \, ds
:::
::::

**(b)** The magentic field due to an infinitely long straight wire carrying a uniform current
$I$ is $v{B} = (mu_0 I / 2 pi r) unit{e}_theta$. Show that $\nabla cross v{B} = 0$ everywhere except at $r = 0$.

:::expandable
**Solution.** [Click to Expand]

:::math align
(\nabla cross v{B})_r &= \frac{1}{r} pd(F_z, theta) - pd(F_theta, z)
&= - pd(\partial, z) ( \frac{mu_0 I}{2 pi r} )
&= 0
(\nabla cross v{B})_theta &= pd(F_r, z) - pd(F_z, r)
&= 0
(\nabla cross v{B})_z &= \frac{1}{r} pd(\partial, r)(r F_theta) - pd(F_r, theta)
&= \frac{1}{r} pd(\partial, r) ( r \frac{mu_0 I}{2 pi r} )
&= \frac{1}{r} pd(\partial, r) ( \frac{mu_0 I}{2 pi} )
&= 0
:::

::::

**(c)** Prove Ampere's circuital law for the field of the wire given in part (b).

:::expandable
**Solution.** [Click to Expand]

For a circle of radius $r$, $ds = r \, dtheta$ and $unit{t} = unit{e}_theta$. Then, we have:

:::math
oint[circle] v{B} dot unit{t} \, ds = int[0..2 pi] \frac{mu_0 I}{2 pi r} r \, dtheta = mu_0 I
:::

For any curve $C$ not passing through the wire, there exists a circle around the wire inside it.
Putting together the results from part (a) and (b), circulation of $v{B}$ around $C$ is equal to the circulation of $v{B}$ around the circle, which is $mu_0 I$.

So, for any curve $C$ not passing through the wire, we have:

:::math
oint[C] v{B} dot unit{t} \, ds = mu_0 I
:::

::::

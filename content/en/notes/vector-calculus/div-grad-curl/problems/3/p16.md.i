**Problem III-16.**

**(a)** Consider a vector function with the property $\nabla \times v{F} = 0$ everywhere on two closed curves $C_1$ and $C_2$ and on any capping surface $S$ of the
region enclosed by them. Show that the circulation of $v{F}$ around $C_1$ equals
the circulation of $v{F}$ around $C_2$.

 ![](III-16a.jpg)

:::expandable
**Solution.** [Click to Expand]

Form $C_3$ by joining $C_1$ and $C_2$ with a segment on $S$ and reversing the direction of $C_1$.

In figure below $a$ and $b$ segments completely overlap but in opposite directions. They connect
inner and outer parts of the curve by moving along $S$.

 ![](III-16b.jpg)

Then $S$ is a capping surface for the region enclosed by $C_3$.

Then, we have:

$$
\oint_{C_3} v{F} \cdot unit{t} \, ds = \iint_S \nabla \times v{F} \cdot unit{n} \, dS
$$

Since $\nabla \times v{F} = 0$, we have:

$$
\oint_{C_3} v{F} \cdot unit{t} \, ds = 0 \tag{1}
$$

Since we have reversed the direction of $C_1$ and line integrals along $a$ and $b$ cancel each other, we have:

$$
\oint_{C_3} v{F} \cdot unit{t} \, ds = -\oint_{C_1} v{F} \cdot unit{t} \, ds + \oint_{C_2} v{F} \cdot unit{t} \, ds \tag{2}
$$

Putting (1) and (2) together, we have:

$$
-\oint_{C_1} v{F} \cdot unit{t} \, ds + \oint_{C_2} v{F} \cdot unit{t} \, ds = 0
$$

Thus, we have:

$$
\oint_{C_1} v{F} \cdot unit{t} \, ds = \oint_{C_2} v{F} \cdot unit{t} \, ds
$$
::::

**(b)** The magentic field due to an infinitely long straight wire carrying a uniform current
$I$ is $v{B} = (\mu_0 I / 2 \pi r) unit{e}_\theta$. Show that $\nabla \times v{B} = 0$ everywhere except at $r = 0$.

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
(\nabla \times v{B})_r &= \frac{1}{r} \frac{\partial F_z}{\partial \theta} - \frac{\partial F_\theta}{\partial z} \\[0.8em]
&= - \frac{\partial}{\partial z} ( \frac{\mu_0 I}{2 \pi r} ) \\[0.5em]
&= 0 \\[1.5em]
(\nabla \times v{B})_\theta &= \frac{\partial F_r}{\partial z} - \frac{\partial F_z}{\partial r} \\[0.5em]
&= 0 \\[1.5em]
(\nabla \times v{B})_z &= \frac{1}{r} \frac{\partial}{\partial r}(r F_\theta) - \frac{\partial F_r}{\partial \theta} \\[1em]
&= \frac{1}{r} \frac{\partial}{\partial r} ( r \frac{\mu_0 I}{2 \pi r} )\\[1em]
&= \frac{1}{r} \frac{\partial}{\partial r} ( \frac{\mu_0 I}{2 \pi} ) \\[0.5em]
&= 0
\end{align*}
$$

::::

**(c)** Prove Ampere's circuital law for the field of the wire given in part (b).

:::expandable
**Solution.** [Click to Expand]

For a circle of radius $r$, $ds = r \\, d\theta$ and $unit{t} = unit{e}_\theta$. Then, we have:

$$
\oint_{circle} v{B} \cdot unit{t} \, ds = \int_{0}^{2 \pi} \frac{\mu_0 I}{2 \pi r} r \, d\theta = \mu_0 I
$$

For any curve $C$ not passing through the wire, there exists a circle around the wire inside it.
Putting together the results from part (a) and (b), circulation of $v{B}$ around $C$ is equal to the circulation of $v{B}$ around the circle, which is $\mu_0 I$.

So, for any curve $C$ not passing through the wire, we have:

$$
\oint_C v{B} \cdot unit{t} \, ds = \mu_0 I
$$

::::

**Problem III-16.**

**(a)** Consider a vector function with the property $\nabla \times \mathbf{F} = 0$ everywhere on two closed curves $C_1$ and $C_2$ and on any capping surface $S$ of the
region enclosed by them. Show that the circulation of $\mathbf{F}$ around $C_1$ equals
the circulation of $\mathbf{F}$ around $C_2$.

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
\oint_{C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds = \iint_S \nabla \times \mathbf{F} \cdot \hat{\mathbf{n}} \, dS
$$

Since $\nabla \times \mathbf{F} = 0$, we have:

$$
\oint_{C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds = 0 \tag{1}
$$

Since we have reversed the direction of $C_1$ and line integrals along $a$ and $b$ cancel each other, we have:

$$
\oint_{C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds = -\oint_{C_1} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds + \oint_{C_2} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds \tag{2}
$$

Putting (1) and (2) together, we have:

$$
-\oint_{C_1} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds + \oint_{C_2} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds = 0
$$

Thus, we have:

$$
\oint_{C_1} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds = \oint_{C_2} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds
$$
::::

**(b)** The magentic field due to an infinitely long straight wire carrying a uniform current
$I$ is $\mathbf{B} = (\mu_0 I / 2 \pi r) \hat{\mathbf{e}_\theta}$. Show that $\nabla \times \mathbf{B} = 0$ everywhere except at $r = 0$.

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
(\nabla \times \mathbf{B})\_r &= \frac{1}{r} \frac{\partial F_z}{\partial \theta} - \frac{\partial F_\theta}{\partial z} \\[0.8em]
&= - \frac{\partial}{\partial z} \left( \frac{\mu_0 I}{2 \pi r} \right) \\[0.5em]
&= 0 \\[1.5em]
(\nabla \times \mathbf{B})\_\theta &= \frac{\partial F_r}{\partial z} - \frac{\partial F_z}{\partial r} \\[0.5em]
&= 0 \\[1.5em]
(\nabla \times \mathbf{B})\_z &= \frac{1}{r} \frac{\partial}{\partial r}(r F_\theta) - \frac{\partial F_r}{\partial \theta} \\[1em]
&= \frac{1}{r} \frac{\partial}{\partial r} \left( r \frac{\mu_0 I}{2 \pi r} \right)\\[1em]
&= \frac{1}{r} \frac{\partial}{\partial r} \left( \frac{\mu_0 I}{2 \pi} \right) \\[0.5em]
&= 0
\end{align*}
$$

::::

**(c)** Prove Ampere's circuital law for the field of the wire given in part (b).

:::expandable
**Solution.** [Click to Expand]

For a circle of radius $r$, $ds = r \\, d\theta$ and $\hat{\mathbf{t}} = \hat{\mathbf{e}_\theta}$. Then, we have:

$$
\oint_{circle} \mathbf{B} \cdot \hat{\mathbf{t}} \, ds = \int_{0}^{2 \pi} \frac{\mu_0 I}{2 \pi r} r \, d\theta = \mu_0 I
$$

For any curve $C$ not passing through the wire, there exists a circle around the wire inside it.
Putting together the results from part (a) and (b), circulation of $\mathbf{B}$ around $C$ is equal to the circulation of $\mathbf{B}$ around the circle, which is $\mu_0 I$.

So, for any curve $C$ not passing through the wire, we have:

$$
\oint_C \mathbf{B} \cdot \hat{\mathbf{t}} \, ds = \mu_0 I
$$

::::

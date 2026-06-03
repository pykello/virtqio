**Problem III-14.** Use Stokes' theorem to show that

$$
\oint_C unit{t} \, ds = 0
$$

:::expandable
**Solution.** [Click to Expand]

Using $\nabla \times v{F} = v{i} ( \frac{\partial{F_z}}{\partial y} - \frac{\partial{F_y}}{\partial z} ) + v{j} ( \frac{\partial{F_x}}{\partial z} - \frac{\partial{F_z}}{\partial x} ) + v{k} ( \frac{\partial{F_y}}{\partial x} - \frac{\partial{F_x}}{\partial y} )$, we get:
$\nabla \times v{i}$ = $\nabla \times v{j}$ = $\nabla \times v{k} = 0$.

Then, $i$-component of $\oint_C unit{t} \\, ds$ is:

$$
\begin{align*}
v{i} \cdot \oint_C unit{t} \, ds &= \oint_C v{i} \cdot unit{t} \, ds \\
&= \iint_S \nabla \times v{i} \cdot unit{n} \, dS \\
&= 0
\end{align*}
$$

Similarly, we can show that $j$-component and $k$-component of $\oint_C unit{t} \\, ds$ are also zero.

Then, we have:

$$
\oint_C unit{t} \, ds = 0
$$
::::

**Problem III-14.** Use Stokes' theorem to show that

$$
\oint_C \hat{\mathbf{t}} \\, ds = 0
$$

:::expandable
**Solution.** [Click to Expand]

Using $\nabla \times \mathbf{F} = \mathbf{i} \left( \frac{\partial{F_z}}{\partial y} - \frac{\partial{F_y}}{\partial z} \right) + \mathbf{j} \left( \frac{\partial{F_x}}{\partial z} - \frac{\partial{F_z}}{\partial x} \right) + \mathbf{k} \left( \frac{\partial{F_y}}{\partial x} - \frac{\partial{F_x}}{\partial y} \right)$, we get:
$\nabla \times \mathbf{i}$ = $\nabla \times \mathbf{j}$ = $\nabla \times \mathbf{k} = 0$.

Then, $i$-component of $\oint_C \hat{\mathbf{t}} \\, ds$ is:

$$
\begin{align*}
\mathbf{i} \cdot \oint_C \hat{\mathbf{t}} \\, ds &= \oint_C \mathbf{i} \cdot \hat{\mathbf{t}} \\, ds \\\\
&= \iint_S \nabla \times \mathbf{i} \cdot \hat{\mathbf{n}} \\, dS \\\\
&= 0
\end{align*}
$$

Similarly, we can show that $j$-component and $k$-component of $\oint_C \hat{\mathbf{t}} \\, ds$ are also zero.

Then, we have:

$$
\oint_C \hat{\mathbf{t}} \\, ds = 0
$$
::::

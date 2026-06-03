**Problem IV-8.**
Fick's law states that in certain diffusion processes the current density $v{J}$ is
proportional to the negative of the gradient of the density $\rho$; that is, $v{J} = -k \nabla \rho$,
where $k$ is a positive constant. If a substance of density $\rho(x, y, z, t)$ and
velocity $v{v}(x, y, z, t)$ diffuses according to Fick's law, show that the
flow is _irrotational_. That is, $\nabla \times v{v} = 0$.

:::expandable
**Solution.** [Click to Expand]

Since $v{J} = \rho v{v}$ (using the definition at page 52 of the book) and
$v{J} = -k \nabla \rho$ (using the equation at the problem statement), then:

$$
v{v} = -k \frac{\nabla \rho}{\rho}
$$

Then using the identity IV-2e we have:

$$
\nabla \times v{v} = -k (\underbrace{\frac{1}{\rho} \nabla \times \nabla \rho}_{A} + \underbrace{\nabla(\frac{1}{\rho}) \times \nabla \rho}_{B})
$$

Curl of a gradient is zero, so $A = 0$. For $B$, we have:

$$
\begin{align*}
\nabla(\frac{1}{\rho}) &= v{i} ( -\frac{1}{\rho^2} \frac{\partial \rho}{\partial x} ) + v{j} ( -\frac{1}{\rho^2} \frac{\partial \rho}{\partial y} ) + v{k} ( -\frac{1}{\rho^2} \frac{\partial \rho}{\partial z} ) \\[1em]
&= -\frac{1}{\rho^2} \nabla \rho
\end{align*}
$$

Since this is parallel to $\nabla \rho$, then $B$ is zero as well. Therefore:

$$
\nabla \times v{v} = 0
$$
::::

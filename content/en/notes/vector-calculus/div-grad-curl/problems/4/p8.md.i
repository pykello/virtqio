**Problem IV-8.**
Fick's law states that in certain diffusion processes the current density $\mathbf{J}$ is
proportional to the negative of the gradient of the density $\rho$; that is, $\mathbf{J} = -k \nabla \rho$,
where $k$ is a positive constant. If a substance of density $\rho(x, y, z, t)$ and
velocity $\mathbf{v}(x, y, z, t)$ diffuses according to Fick's law, show that the
flow is _irrotational_. That is, $\nabla \times \mathbf{v} = 0$.

:::expandable
**Solution.** [Click to Expand]

Since $\mathbf{J} = \rho \mathbf{v}$ and $\mathbf{J} = -k \nabla \rho$, then:

$$
\mathbf{v} = -k \frac{\nabla \rho}{\rho}
$$

Then using the identity IV-2e we have:

$$
\nabla \times \mathbf{v} = -k \left(\underbrace{\frac{1}{\rho} \nabla \times \nabla \rho}\_{A} + \underbrace{\nabla\left(\frac{1}{\rho}\right) \times \nabla \rho}\_{B}\right)
$$

Curl of a gradient is zero, so $A = 0$. For $B$, we have:

$$
\begin{align*}
\nabla(\frac{1}{\rho}) &= \mathbf{i} \left( -\frac{1}{\rho^2} \frac{\partial \rho}{\partial x} \right) + \mathbf{j} \left( -\frac{1}{\rho^2} \frac{\partial \rho}{\partial y} \right) + \mathbf{k} \left( -\frac{1}{\rho^2} \frac{\partial \rho}{\partial z} \right) \\\\[1em]
&= -\frac{1}{\rho^2} \nabla \rho
\end{align*}
$$

Since this is parallel to $\nabla \rho$, then $B$ is zero as well. Therefore:

$$
\nabla \times \mathbf{v} = 0
$$
::::

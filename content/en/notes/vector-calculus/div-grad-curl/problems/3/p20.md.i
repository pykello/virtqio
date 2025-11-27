**Problem III-20.** Maxwell's equations are:

$$
\begin{align*}
\nabla \cdot \mathbf{E} &= \frac{\rho}{\varepsilon_0} \tag{M1} \\
\nabla \cdot \mathbf{B} &= 0 \tag{M2} \\
\nabla \times \mathbf{E} &= - \frac{\partial \mathbf{B}}{\partial t} \tag{M3} \\
\nabla \times \mathbf{B} &= \varepsilon_0 \mu_0 \frac{\partial \mathbf{E}}{\partial t} + \mu_0 \mathbf{J} \tag{M4}
\end{align*}
$$

where $\mathbf{E}$ is the electric field, $\mathbf{B}$ is the magnetic field, $\rho$ is the charge density, and $\mathbf{J}$ is the current density. Use Maxwell's equations to derive the continuity equation

$$
\nabla \cdot \mathbf{J} + \frac{\partial \rho}{\partial t} = 0
$$

:::expandable
**Solution.** [Click to Expand]

**Lemma.** $\dfrac{\partial}{\partial t} \left( \nabla \cdot \mathbf{E} \right) = \nabla \cdot \left( \dfrac{\partial \mathbf{E}}{\partial t} \right)$.

**Proof of Lemma.** Let $\mathbf{E} = (E_x, E_y, E_z)$. Then

$$
\nabla \cdot \mathbf{E} = \dfrac{\partial E_x}{\partial x} + \dfrac{\partial E_y}{\partial y} + \dfrac{\partial E_z}{\partial z}
$$

Differentiating with respect to $t$, we have:

$$
\begin{align*}
\dfrac{\partial}{\partial t} \left( \nabla \cdot \mathbf{E} \right) &= \dfrac{\partial^2 E_x}{\partial x \partial t} + \dfrac{\partial^2 E_y}{\partial y \partial t} + \dfrac{\partial^2 E_z}{\partial z \partial t} \\[1em]
&= \nabla \cdot \left( \frac{\partial E_x}{\partial t}, \frac{\partial E_y}{\partial t}, \frac{\partial E_z}{\partial t} \right) \\[1em]
&= \nabla \cdot \left( \frac{\partial \mathbf{E}}{\partial t} \right)
\end{align*}
$$

**Proof of Continuity Equation.** From (M4) we have:

$$
\mu_0 \mathbf{J} = \nabla \times \mathbf{B} - \varepsilon_0 \mu_0 \frac{\partial \mathbf{E}}{\partial t}
$$

Taking the divergence of both sides and using the linearity of the divergence operator, we have:

$$
\mu_0 \left( \nabla \cdot \mathbf{J} \right) = \nabla \cdot \left( \nabla \times \mathbf{B} \right) - \varepsilon_0 \mu_0 \nabla \cdot \frac{\partial \mathbf{E}}{\partial t}
$$

In III.7 we proved that $\nabla \cdot \left( \nabla \times \mathbf{B} \right) = 0$. Then, we have:

$$
\mu_0 \left( \nabla \cdot \mathbf{J} \right) = - \varepsilon_0 \mu_0 \nabla \cdot \frac{\partial \mathbf{E}}{\partial t}
$$

which means:

$$
\nabla \cdot \mathbf{J} = - \varepsilon_0 \nabla \cdot \frac{\partial \mathbf{E}}{\partial t} \tag{1}
$$

Differentiating (M1) with respect to $t$, we have:

$$
\frac{\partial}{\partial t} \left( \nabla \cdot \mathbf{E} \right) = \frac{1}{\varepsilon_0} \frac{\partial \rho}{\partial t}
$$

Using the lemma, we have:

$$
\nabla \cdot \frac{\partial \mathbf{E}}{\partial t} = \frac{1}{\varepsilon_0} \frac{\partial \rho}{\partial t} \tag{2}
$$

Putting (1) and (2) together, we have:

$$
\nabla \cdot \mathbf{J} = - \frac{\partial \rho}{\partial t}
$$

Rearranging, we have:

$$
\nabla \cdot \mathbf{J} + \frac{\partial \rho}{\partial t} = 0
$$

::::

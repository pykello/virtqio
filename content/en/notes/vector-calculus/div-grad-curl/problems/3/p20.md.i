**Problem III-20.** Maxwell's equations are:

$$
\begin{align*}
\nabla \cdot v{E} &= \frac{\rho}{\varepsilon_0} \tag{M1} \\
\nabla \cdot v{B} &= 0 \tag{M2} \\
\nabla \times v{E} &= - \frac{\partial v{B}}{\partial t} \tag{M3} \\
\nabla \times v{B} &= \varepsilon_0 \mu_0 \frac{\partial v{E}}{\partial t} + \mu_0 v{J} \tag{M4}
\end{align*}
$$

where $v{E}$ is the electric field, $v{B}$ is the magnetic field, $\rho$ is the charge density, and $v{J}$ is the current density. Use Maxwell's equations to derive the continuity equation

$$
\nabla \cdot v{J} + \frac{\partial \rho}{\partial t} = 0
$$

:::expandable
**Solution.** [Click to Expand]

**Lemma.** $\dfrac{\partial}{\partial t} ( \nabla \cdot v{E} ) = \nabla \cdot ( \dfrac{\partial v{E}}{\partial t} )$.

**Proof of Lemma.** Let $v{E} = (E_x, E_y, E_z)$. Then

$$
\nabla \cdot v{E} = \dfrac{\partial E_x}{\partial x} + \dfrac{\partial E_y}{\partial y} + \dfrac{\partial E_z}{\partial z}
$$

Differentiating with respect to $t$, we have:

$$
\begin{align*}
\dfrac{\partial}{\partial t} ( \nabla \cdot v{E} ) &= \dfrac{\partial^2 E_x}{\partial x \partial t} + \dfrac{\partial^2 E_y}{\partial y \partial t} + \dfrac{\partial^2 E_z}{\partial z \partial t} \\[1em]
&= \nabla \cdot ( \frac{\partial E_x}{\partial t}, \frac{\partial E_y}{\partial t}, \frac{\partial E_z}{\partial t} ) \\[1em]
&= \nabla \cdot ( \frac{\partial v{E}}{\partial t} )
\end{align*}
$$

**Proof of Continuity Equation.** From (M4) we have:

$$
\mu_0 v{J} = \nabla \times v{B} - \varepsilon_0 \mu_0 \frac{\partial v{E}}{\partial t}
$$

Taking the divergence of both sides and using the linearity of the divergence operator, we have:

$$
\mu_0 ( \nabla \cdot v{J} ) = \nabla \cdot ( \nabla \times v{B} ) - \varepsilon_0 \mu_0 \nabla \cdot \frac{\partial v{E}}{\partial t}
$$

In III.7 we proved that $\nabla \cdot ( \nabla \times v{B} ) = 0$. Then, we have:

$$
\mu_0 ( \nabla \cdot v{J} ) = - \varepsilon_0 \mu_0 \nabla \cdot \frac{\partial v{E}}{\partial t}
$$

which means:

$$
\nabla \cdot v{J} = - \varepsilon_0 \nabla \cdot \frac{\partial v{E}}{\partial t} \tag{1}
$$

Differentiating (M1) with respect to $t$, we have:

$$
\frac{\partial}{\partial t} ( \nabla \cdot v{E} ) = \frac{1}{\varepsilon_0} \frac{\partial \rho}{\partial t}
$$

Using the lemma, we have:

$$
\nabla \cdot \frac{\partial v{E}}{\partial t} = \frac{1}{\varepsilon_0} \frac{\partial \rho}{\partial t} \tag{2}
$$

Putting (1) and (2) together, we have:

$$
\nabla \cdot v{J} = - \frac{\partial \rho}{\partial t}
$$

Rearranging, we have:

$$
\nabla \cdot v{J} + \frac{\partial \rho}{\partial t} = 0
$$

::::

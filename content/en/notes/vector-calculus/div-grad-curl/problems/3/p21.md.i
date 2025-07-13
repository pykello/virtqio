**Problem III-21.** The electromagnetic field stores energy, and it is possible to show
that in a volume $V$ the amount of electromagnetic energy is

$$
\iiint_V \rho_E \\, dV
$$

where the energy density is

$$
\rho_E = \frac{1}{2} \left( \varepsilon_0 \mathbf{E} \cdot \mathbf{E} + \mathbf{B} \cdot \mathbf{B} / \mu_0 \right) = \frac{1}{2} \left( \varepsilon_0 E^2 + \frac{B^2}{\mu_0} \right)
$$

Use Maxwell's equations to show that

$$
\frac{\partial \rho_E}{\partial t} + \nabla \cdot \left( \frac{\mathbf{E} \times \mathbf{B}}{\mu_0} \right) = - \mathbf{J} \cdot \mathbf{E}
$$

:::expandable
**Solution.** [Click to Expand]

**Lemma.** $\nabla \cdot \left( \mathbf{E} \times \mathbf{B} \right) = \mathbf{B} \cdot \left( \nabla \times \mathbf{E} \right) - \mathbf{E} \cdot \left( \nabla \times \mathbf{B} \right)$.

**Proof of Lemma.** We have

$$
\mathbf{E} \times \mathbf{B} = (E_y B_z - E_z B_y, E_z B_x - E_x B_z, E_x B_y - E_y B_x)
$$

Then

$$
\begin{align*}
\nabla \cdot \left( \mathbf{E} \times \mathbf{B} \right) &=
E_y \frac{\partial B_z}{\partial x} + B_z \frac{\partial E_y}{\partial x}  - E_z \frac{\partial B_y}{\partial x} - B_y \frac{\partial E_z}{\partial x} + \\\\
&+ E_z \frac{\partial B_x}{\partial y} + B_x \frac{\partial E_z}{\partial y} - E_x \frac{\partial B_z}{\partial y} - B_z \frac{\partial E_x}{\partial y} + \\\\
&+ E_x \frac{\partial B_y}{\partial z} + B_y \frac{\partial E_x}{\partial z} - E_y \frac{\partial B_x}{\partial z} - B_x \frac{\partial E_y}{\partial z}
\end{align*}
$$

Rearranging, we have:

$$
\begin{align*}
\nabla \cdot \left( \mathbf{E} \times \mathbf{B} \right) &=
E_x \left(\frac{\partial B_y}{\partial z} - \frac{\partial B_z}{\partial y}\right) + 
E_y \left(\frac{\partial B_z}{\partial x} - \frac{\partial B_x}{\partial z}\right) + \\\\
&+ E_z \left(\frac{\partial B_x}{\partial y} - \frac{\partial B_y}{\partial x}\right) +
B_x \left(\frac{\partial E_z}{\partial y} - \frac{\partial E_y}{\partial z}\right) + \\\\
&+ B_y \left(\frac{\partial E_x}{\partial z} - \frac{\partial E_z}{\partial x}\right) +
B_z \left(\frac{\partial E_y}{\partial x} - \frac{\partial E_x}{\partial y}\right)
\end{align*}
$$

Which can be rewritten as $B \cdot \left( \nabla \times \mathbf{E} \right) - E \cdot \left( \nabla \times \mathbf{B} \right)$.

**Proof of Energy Density Equation.** 

Inner product of sides of (M3) by $\mathbf{B}$ on the left gives:

$$
\mathbf{B} \cdot (\nabla \times \mathbf{E}) = - \mathbf{B} \cdot \frac{\partial \mathbf{B}}{\partial t} \tag{1}
$$

Inner product of sides of (M4) by $E$ on the left gives:

$$
\mathbf{E} \cdot (\nabla \times \mathbf{B}) = \varepsilon_0 \mu_0 \mathbf{E} \cdot
\frac{\partial \mathbf{E}}{\partial t} + \mu_0 \mathbf{E} \cdot \mathbf{J} \tag{2}
$$

Putting the lemma with (1) and (2) gives:

$$
\nabla \left( \frac{\mathbf{E} \times \mathbf{B}}{\mu_0} \right) =
-\frac{1}{\mu_0} \mathbf{B} \cdot \frac{\partial \mathbf{B}}{\partial t} -
\varepsilon_0 \mathbf{E} \cdot \frac{\partial \mathbf{E}}{\partial t} -
\mathbf{E} \cdot \mathbf{J} \tag{3}
$$

On the other hand, differentiating sides of $\rho_E = \dfrac{1}{2}(\varepsilon_0 \mathbf{E} \cdot \mathbf{E} + \mathbf{B} \cdot \mathbf{B} / \mu_0)$ with respect to $t$ gives:

$$
\frac{\partial \rho_E}{\partial t} = \frac{1}{\mu_0} \frac{\partial \mathbf{B}}{\partial t}
\mathbf{B} + \varepsilon_0 \frac{\partial \mathbf{E}}{\partial t} \mathbf{E} \tag{4}
$$

Putting (3) and (4) together we get:

$$
\frac{\partial \rho_E}{\partial t} + \nabla \cdot \left( \frac{\mathbf{E} \times \mathbf{B}}{\mu_0} \right) = - \mathbf{J} \cdot \mathbf{E}
$$

::::

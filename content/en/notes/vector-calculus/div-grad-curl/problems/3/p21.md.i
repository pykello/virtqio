**Problem III-21.** The electromagnetic field stores energy, and it is possible to show
that in a volume $V$ the amount of electromagnetic energy is

$$
\iiint_V \rho_E \, dV
$$

where the energy density is

$$
\rho_E = \frac{1}{2} ( \varepsilon_0 v{E} \cdot v{E} + v{B} \cdot v{B} / \mu_0 ) = \frac{1}{2} ( \varepsilon_0 E^2 + \frac{B^2}{\mu_0} )
$$

Use Maxwell's equations to show that

$$
\frac{\partial \rho_E}{\partial t} + \nabla \cdot ( \frac{v{E} \times v{B}}{\mu_0} ) = - v{J} \cdot v{E}
$$

:::expandable
**Solution.** [Click to Expand]

**Lemma.** $\nabla \cdot ( v{E} \times v{B} ) = v{B} \cdot ( \nabla \times v{E} ) - v{E} \cdot ( \nabla \times v{B} )$.

**Proof of Lemma.** We have

$$
v{E} \times v{B} = (E_y B_z - E_z B_y, E_z B_x - E_x B_z, E_x B_y - E_y B_x)
$$

Then

$$
\begin{align*}
\nabla \cdot ( v{E} \times v{B} ) &=
E_y \frac{\partial B_z}{\partial x} + B_z \frac{\partial E_y}{\partial x}  - E_z \frac{\partial B_y}{\partial x} - B_y \frac{\partial E_z}{\partial x} + \\
&+ E_z \frac{\partial B_x}{\partial y} + B_x \frac{\partial E_z}{\partial y} - E_x \frac{\partial B_z}{\partial y} - B_z \frac{\partial E_x}{\partial y} + \\
&+ E_x \frac{\partial B_y}{\partial z} + B_y \frac{\partial E_x}{\partial z} - E_y \frac{\partial B_x}{\partial z} - B_x \frac{\partial E_y}{\partial z}
\end{align*}
$$

Rearranging, we have:

$$
\begin{align*}
\nabla \cdot ( v{E} \times v{B} ) &=
E_x (\frac{\partial B_y}{\partial z} - \frac{\partial B_z}{\partial y}) +
E_y (\frac{\partial B_z}{\partial x} - \frac{\partial B_x}{\partial z}) + \\
&+ E_z (\frac{\partial B_x}{\partial y} - \frac{\partial B_y}{\partial x}) +
B_x (\frac{\partial E_z}{\partial y} - \frac{\partial E_y}{\partial z}) + \\
&+ B_y (\frac{\partial E_x}{\partial z} - \frac{\partial E_z}{\partial x}) +
B_z (\frac{\partial E_y}{\partial x} - \frac{\partial E_x}{\partial y})
\end{align*}
$$

Which can be rewritten as $B \cdot ( \nabla \times v{E} ) - E \cdot ( \nabla \times v{B} )$.

**Proof of Energy Density Equation.**

Inner product of sides of (M3) by $v{B}$ on the left gives:

$$
v{B} \cdot (\nabla \times v{E}) = - v{B} \cdot \frac{\partial v{B}}{\partial t} \tag{1}
$$

Inner product of sides of (M4) by $E$ on the left gives:

$$
v{E} \cdot (\nabla \times v{B}) = \varepsilon_0 \mu_0 v{E} \cdot
\frac{\partial v{E}}{\partial t} + \mu_0 v{E} \cdot v{J} \tag{2}
$$

Putting the lemma with (1) and (2) gives:

$$
\nabla ( \frac{v{E} \times v{B}}{\mu_0} ) =
-\frac{1}{\mu_0} v{B} \cdot \frac{\partial v{B}}{\partial t} -
\varepsilon_0 v{E} \cdot \frac{\partial v{E}}{\partial t} -
v{E} \cdot v{J} \tag{3}
$$

On the other hand, differentiating sides of $\rho_E = \dfrac{1}{2}(\varepsilon_0 v{E} \cdot v{E} + v{B} \cdot v{B} / \mu_0)$ with respect to $t$ gives:

$$
\frac{\partial \rho_E}{\partial t} = \frac{1}{\mu_0} \frac{\partial v{B}}{\partial t}
v{B} + \varepsilon_0 \frac{\partial v{E}}{\partial t} v{E} \tag{4}
$$

Putting (3) and (4) together we get:

$$
\frac{\partial \rho_E}{\partial t} + \nabla \cdot ( \frac{v{E} \times v{B}}{\mu_0} ) = - v{J} \cdot v{E}
$$

::::

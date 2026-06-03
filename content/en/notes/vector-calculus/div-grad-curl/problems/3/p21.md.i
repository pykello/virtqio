**Problem III-21.** The electromagnetic field stores energy, and it is possible to show
that in a volume $V$ the amount of electromagnetic energy is

:::math
iiint[V] rho_E \, dV
:::

where the energy density is

:::math
rho_E = \frac{1}{2} ( eps_0 v{E} dot v{E} + v{B} dot v{B} / mu_0 ) = \frac{1}{2} ( eps_0 E^2 + \frac{B^2}{mu_0} )
:::

Use Maxwell's equations to show that

:::math
pd(rho_E, t) + \nabla dot ( \frac{v{E} cross v{B}}{mu_0} ) = - v{J} dot v{E}
:::

:::expandable
**Solution.** [Click to Expand]

**Lemma.** $\nabla dot ( v{E} cross v{B} ) = v{B} dot ( \nabla cross v{E} ) - v{E} dot ( \nabla cross v{B} )$.

**Proof of Lemma.** We have

:::math
v{E} cross v{B} = (E_y B_z - E_z B_y, E_z B_x - E_x B_z, E_x B_y - E_y B_x)
:::

Then

:::math align
\nabla dot ( v{E} cross v{B} ) &= E_y pd(B_z, x) + B_z pd(E_y, x)  - E_z pd(B_y, x) - B_y pd(E_z, x) +
&+ E_z pd(B_x, y) + B_x pd(E_z, y) - E_x pd(B_z, y) - B_z pd(E_x, y) +
&+ E_x pd(B_y, z) + B_y pd(E_x, z) - E_y pd(B_x, z) - B_x pd(E_y, z)
:::

Rearranging, we have:

:::math align
\nabla dot ( v{E} cross v{B} ) &= E_x (pd(B_y, z) - pd(B_z, y)) + E_y (pd(B_z, x) - pd(B_x, z)) +
&+ E_z (pd(B_x, y) - pd(B_y, x)) + B_x (pd(E_z, y) - pd(E_y, z)) +
&+ B_y (pd(E_x, z) - pd(E_z, x)) + B_z (pd(E_y, x) - pd(E_x, y))
:::

Which can be rewritten as $B dot ( \nabla cross v{E} ) - E dot ( \nabla cross v{B} )$.

**Proof of Energy Density Equation.**

Inner product of sides of (M3) by $v{B}$ on the left gives:

:::math
v{B} dot (\nabla cross v{E}) = - v{B} dot pd(v{B}, t) \qquad\text{(1)}
:::

Inner product of sides of (M4) by $E$ on the left gives:

:::math
v{E} dot (\nabla cross v{B}) = eps_0 mu_0 v{E} dot
pd(v{E}, t) + mu_0 v{E} dot v{J} \qquad\text{(2)}
:::

Putting the lemma with (1) and (2) gives:

:::math
\nabla ( \frac{v{E} cross v{B}}{mu_0} ) =
-\frac{1}{mu_0} v{B} dot pd(v{B}, t) -
eps_0 v{E} dot pd(v{E}, t) -
v{E} dot v{J} \qquad\text{(3)}
:::

On the other hand, differentiating sides of $rho_E = \dfrac{1}{2}(eps_0 v{E} dot v{E} + v{B} dot v{B} / mu_0)$ with respect to $t$ gives:

:::math
pd(rho_E, t) = \frac{1}{mu_0} pd(v{B}, t)
v{B} + eps_0 pd(v{E}, t) v{E} \qquad\text{(4)}
:::

Putting (3) and (4) together we get:

:::math
pd(rho_E, t) + \nabla dot ( \frac{v{E} cross v{B}}{mu_0} ) = - v{J} dot v{E}
:::

::::

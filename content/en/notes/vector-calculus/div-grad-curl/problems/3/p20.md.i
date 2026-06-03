**Problem III-20.** Maxwell's equations are:

:::math align
\nabla dot v{E} &= \frac{rho}{eps_0} \tag{M1}
\nabla dot v{B} &= 0 \tag{M2}
\nabla cross v{E} &= - pd(v{B}, t) \tag{M3}
\nabla cross v{B} &= eps_0 mu_0 pd(v{E}, t) + mu_0 v{J} \tag{M4}
:::

where $v{E}$ is the electric field, $v{B}$ is the magnetic field, $rho$ is the charge density, and $v{J}$ is the current density. Use Maxwell's equations to derive the continuity equation

:::math
\nabla dot v{J} + pd(rho, t) = 0
:::

:::expandable
**Solution.** [Click to Expand]

**Lemma.** $pd(\partial, t) ( \nabla dot v{E} ) = \nabla dot ( pd(v{E}, t) )$.

**Proof of Lemma.** Let $v{E} = (E_x, E_y, E_z)$. Then

:::math
\nabla dot v{E} = pd(E_x, x) + pd(E_y, y) + pd(E_z, z)
:::

Differentiating with respect to $t$, we have:

:::math align
pd(\partial, t) ( \nabla dot v{E} ) &= pd2(E_x, x, t) + pd2(E_y, y, t) + pd2(E_z, z, t)
&= \nabla dot ( pd(E_x, t), pd(E_y, t), pd(E_z, t) )
&= \nabla dot ( pd(v{E}, t) )
:::

**Proof of Continuity Equation.** From (M4) we have:

:::math
mu_0 v{J} = \nabla cross v{B} - eps_0 mu_0 pd(v{E}, t)
:::

Taking the divergence of both sides and using the linearity of the divergence operator, we have:

:::math
mu_0 ( \nabla dot v{J} ) = \nabla dot ( \nabla cross v{B} ) - eps_0 mu_0 \nabla dot pd(v{E}, t)
:::

In III.7 we proved that $\nabla dot ( \nabla cross v{B} ) = 0$. Then, we have:

:::math
mu_0 ( \nabla dot v{J} ) = - eps_0 mu_0 \nabla dot pd(v{E}, t)
:::

which means:

:::math
\nabla dot v{J} = - eps_0 \nabla dot pd(v{E}, t) \tag{1}
:::

Differentiating (M1) with respect to $t$, we have:

:::math
pd(\partial, t) ( \nabla dot v{E} ) = \frac{1}{eps_0} pd(rho, t)
:::

Using the lemma, we have:

:::math
\nabla dot pd(v{E}, t) = \frac{1}{eps_0} pd(rho, t) \tag{2}
:::

Putting (1) and (2) together, we have:

:::math
\nabla dot v{J} = - pd(rho, t)
:::

Rearranging, we have:

:::math
\nabla dot v{J} + pd(rho, t) = 0
:::

::::

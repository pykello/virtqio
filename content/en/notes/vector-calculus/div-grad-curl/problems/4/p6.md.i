**Problem IV-6.**

**(a)** An electric dipole of strength $p$ situated at the origin and oriented
in the positive $z$-direction gives rise to the electric field

:::math
v{E(r, theta, phi)} = \frac{1}{4 pi eps_0} \frac{p}{r^3} ( 2 unit{e}_r \cos phi + unit{e}_phi \sin phi )
:::

Show that the dipole potential is given by

:::math
Phi(r, theta, phi) = \frac{1}{4 pi eps_0} \frac{p \cos phi}{r^2}
:::

In spherical coordinates,

:::math
unit{t} = unit{e}_r dd(r, s) + unit{e}_phi r dd(phi, s) + unit{e}_theta r \sin phi dd(theta, s)
:::

:::expandable
**Solution.** [Click to Expand]

We have:

:::math
v{E} dot unit{t} = \frac{1}{4 pi eps_0} \frac{p}{r^3} ( 2 \cos phi dd(r, s) + r \sin phi dd(phi, s) )
:::

Since path integral of $v{E}$ is path independent, then:

:::math align
Phi &= - int[(r_0, theta_0, phi_0)..(r, theta, phi)] v{E} dot unit{t} ds
&= - ( int[(r_0, theta_0, phi_0)..(r, theta_0, phi_0)] v{E} dot unit{t} ds + int[(r, theta_0, phi_0)..(r, theta, phi_0)] v{E} dot unit{t} ds + int[(r, theta, phi_0)..(r, theta, phi)] v{E} dot unit{t} ds )
&= - \frac{p}{4 pi eps_0} ( int[r_0..r] \frac{2 \cos phi_0}{r^3} dr + 0 + int[phi_0..phi] \frac{\sin phi}{r^2} dphi )
&= - \frac{p}{4 pi eps_0} ( - \frac{\cos phi_0}{r^2} +\frac{\cos phi_0}{r_0^2} - \frac{\cos phi}{r^2} + \frac{cos phi_0}{r^2} )
&= \frac{1}{4 pi eps_0} \frac{p \cos phi}{r^2} + \text{constant}
:::

::::

**(b)** Calculate the flux of the dipole field through a sphere of radius $R$ centered at the origin.

:::expandable
**Solution.** [Click to Expand]

In a spherical surface, $unit{n} = unit{e}_r$. Then:

:::math align
Phi_{v{E}} &= iint[S] v{E} dot unit{n} dS
&= iint[S] \frac{1}{4 pi eps_0} \frac{2p}{R^3} \cos phi dS
&= \frac{1}{4 pi eps_0} \frac{2p}{R^3} iint[S] \cos phi dS
:::

We have $dS = R^2 \sin phi \\, dphi \\, d theta$. Then:

:::math align
Phi_{v{E}} &= \frac{1}{4 pi eps_0} \frac{2p}{R^3} int[0..pi] int[0..2pi] R^2 \cos phi \sin phi \, dtheta \, dphi
&=\frac{1}{eps_0} \frac{p}{R} int[0..pi] \cos phi \sin phi \, dphi
&= 0
:::
::::

**(c)** What is the flux of the dipole field over any closed surface that doesn't pass through
the origin?

:::expandable
**Solution.** [Click to Expand]

Divergence in spherical coordinates is given by:

:::math
\nabla dot v{F} = \frac{1}{r^2} pd(\partial, r) ( r^2 F_r ) + \frac{1}{r \sin phi} pd(\partial, phi) ( F_phi \sin phi ) + \frac{1}{r \sin{phi}} pd(F_theta, theta)
:::

Then:

:::math align
\nabla dot v{E} &= \frac{p}{4 pi eps_0} ( \frac{1}{r^2} pd(\partial, r) ( r^2 \frac{2}{r^3} \cos phi ) + \frac{1}{r \sin phi} pd(\partial, phi) ( \frac{\sin^2 phi}{r^3} ) + 0 )
&= \frac{p}{4 pi eps_0} ( \frac{1}{r^2} (-\frac{2}{r^2} \cos phi ) + \frac{1}{r \sin phi} ( \frac{2 \sin phi \cos phi}{r^3} ) )
&= \frac{p}{4 pi eps_0} ( -\frac{2 \cos phi}{r^4} + \frac{2 \cos phi}{r^4} )
&= 0
:::

Now, given any closed surface $S$ that doesn't pass through the origin, there exists a sphere with
$R > 0$ inside $S$ centered at the origin. Using part (b), flux of $v{E}$ over the sphere is 0.
Using problem II-27, since $\nabla dot v{E} = 0$ then flux of $v{E}$ over $S$ is
equal to the flux of $v{E}$ over the sphere, which is 0.

::::

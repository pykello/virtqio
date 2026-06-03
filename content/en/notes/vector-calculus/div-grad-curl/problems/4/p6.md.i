**Problem IV-6.**

**(a)** An electric dipole of strength $p$ situated at the origin and oriented
in the positive $z$-direction gives rise to the electric field

$$
v{E(r, \theta, \phi)} = \frac{1}{4 \pi eps_0} \frac{p}{r^3} ( 2 unit{e}_r \cos \phi + unit{e}_\phi \sin \phi )
$$

Show that the dipole potential is given by

$$
\Phi(r, \theta, \phi) = \frac{1}{4 \pi eps_0} \frac{p \cos \phi}{r^2}
$$

In spherical coordinates,

$$
unit{t} = unit{e}_r \frac{dr}{ds} + unit{e}_\phi r \frac{d\phi}{ds} + unit{e}_\theta r \sin \phi \frac{d\theta}{ds}
$$

:::expandable
**Solution.** [Click to Expand]

We have:

$$
v{E} \cdot unit{t} = \frac{1}{4 \pi eps_0} \frac{p}{r^3} ( 2 \cos \phi \frac{dr}{ds} + r \sin \phi \frac{d\phi}{ds} )
$$

Since path integral of $v{E}$ is path independent, then:

$$
\begin{align*}
\Phi &= - \int_{(r_0, \theta_0, \phi_0)}^{(r, \theta, \phi)} v{E} \cdot unit{t} ds \\[1em]
&= - ( \int_{(r_0, \theta_0, \phi_0)}^{(r, \theta_0, \phi_0)} v{E} \cdot unit{t} ds + \int_{(r, \theta_0, \phi_0)}^{(r, \theta, \phi_0)} v{E} \cdot unit{t} ds + \int_{(r, \theta, \phi_0)}^{(r, \theta, \phi)} v{E} \cdot unit{t} ds ) \\[1em]
&= - \frac{p}{4 \pi eps_0} ( \int_{r_0}^r \frac{2 \cos \phi_0}{r^3} dr + 0 + \int_{\phi_0}^{\phi} \frac{\sin \phi}{r^2} d\phi ) \\[1em]
&= - \frac{p}{4 \pi eps_0} ( - \frac{\cos \phi_0}{r^2} +\frac{\cos \phi_0}{r_0^2} - \frac{\cos \phi}{r^2} + \frac{cos \phi_0}{r^2} ) \\[1em]
&= \frac{1}{4 \pi eps_0} \frac{p \cos \phi}{r^2} + \text{constant}
\end{align*}
$$

::::

**(b)** Calculate the flux of the dipole field through a sphere of radius $R$ centered at the origin.

:::expandable
**Solution.** [Click to Expand]

In a spherical surface, $unit{n} = unit{e}_r$. Then:

$$
\begin{align*}
\Phi_{v{E}} &= \iint_S v{E} \cdot unit{n} dS \\[1em]
&= \iint_S \frac{1}{4 \pi eps_0} \frac{2p}{R^3} \cos \phi dS \\[1em]
&= \frac{1}{4 \pi eps_0} \frac{2p}{R^3} \iint_S \cos \phi dS \\[1em]
\end{align*}
$$

We have $dS = R^2 \sin \phi \\, d\phi \\, d \theta$. Then:

$$
\begin{align*}
\Phi_{v{E}} &= \frac{1}{4 \pi eps_0} \frac{2p}{R^3} \int_{0}^{\pi} \int_{0}^{2\pi} R^2 \cos \phi \sin \phi \, d\theta \, d\phi  \\[1em]
&=\frac{1}{eps_0} \frac{p}{R} \int_{0}^{\pi} \cos \phi \sin \phi \, d\phi \\[1em]
&= 0
\end{align*}
$$
::::

**(c)** What is the flux of the dipole field over any closed surface that doesn't pass through
the origin?

:::expandable
**Solution.** [Click to Expand]

Divergence in spherical coordinates is given by:

$$
\nabla \cdot v{F} = \frac{1}{r^2} \frac{\partial}{\partial r} ( r^2 F_r ) + \frac{1}{r \sin \phi} \frac{\partial}{\partial \phi} ( F_\phi \sin \phi ) + \frac{1}{r \sin{\phi}} \frac{\partial F_\theta}{\partial \theta}
$$

Then:

$$
\begin{align*}
\nabla \cdot v{E} &= \frac{p}{4 \pi eps_0} ( \frac{1}{r^2} \frac{\partial}{\partial r} ( r^2 \frac{2}{r^3} \cos \phi ) + \frac{1}{r \sin \phi} \frac{\partial}{\partial \phi} ( \frac{\sin^2 \phi}{r^3} ) + 0 )
\\[1em]
&= \frac{p}{4 \pi eps_0} ( \frac{1}{r^2} (-\frac{2}{r^2} \cos \phi ) + \frac{1}{r \sin \phi} ( \frac{2 \sin \phi \cos \phi}{r^3} ) )
\\[1em]
&= \frac{p}{4 \pi eps_0} ( -\frac{2 \cos \phi}{r^4} + \frac{2 \cos \phi}{r^4} )
\\[1em]
&= 0
\end{align*}
$$

Now, given any closed surface $S$ that doesn't pass through the origin, there exists a sphere with
$R > 0$ inside $S$ centered at the origin. Using part (b), flux of $v{E}$ over the sphere is 0.
Using problem II-27, since $\nabla \cdot v{E} = 0$ then flux of $v{E}$ over $S$ is
equal to the flux of $v{E}$ over the sphere, which is 0.

::::

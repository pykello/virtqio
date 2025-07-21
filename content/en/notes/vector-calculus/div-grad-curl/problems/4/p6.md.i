**Problem IV-6.**

**(a)** An electric dipole of strength $p$ situated at the origin and oriented
in the positive $z$-direction gives rise to the electric field

$$
\mathbf{E(r, \theta, \phi)} = \frac{1}{4 \pi \epsilon_0} \frac{p}{r^3} \left( 2 \hat{\mathbf{e}}\_r \cos \phi + \hat{\mathbf{e}}\_\phi \sin \phi \right)
$$

Show that the dipole potential is given by

$$
\Phi(r, \theta, \phi) = \frac{1}{4 \pi \epsilon_0} \frac{p \cos \phi}{r^2}
$$

In spherical coordinates,

$$
\hat{\mathbf{t}} = \hat{\mathbf{e}}\_r \frac{dr}{ds} + \hat{\mathbf{e}}\_\phi r \frac{d\phi}{ds} + \hat{\mathbf{e}}\_\theta r \sin \phi \frac{d\theta}{ds}
$$

:::expandable
**Solution.** [Click to Expand]

We have:

$$
\mathbf{E} \cdot \hat{\mathbf{t}} = \frac{1}{4 \pi \epsilon_0} \frac{p}{r^3} \left( 2 \cos \phi \frac{dr}{ds} + r \sin \phi \frac{d\phi}{ds} \right)
$$

Since path integral of $\mathbf{E}$ is path independent, then:

$$
\begin{align*}
\Phi &= - \int_{(r_0, \theta_0, \phi_0)}^{(r, \theta, \phi)} \mathbf{E} \cdot \hat{\mathbf{t}} ds \\\\[1em]
&= - \left( \int_{(r_0, \theta_0, \phi_0)}^{(r, \theta_0, \phi_0)} \mathbf{E} \cdot \hat{\mathbf{t}} ds + \int_{(r, \theta_0, \phi_0)}^{(r, \theta, \phi_0)} \mathbf{E} \cdot \hat{\mathbf{t}} ds + \int_{(r, \theta, \phi_0)}^{(r, \theta, \phi)} \mathbf{E} \cdot \hat{\mathbf{t}} ds \right) \\\\[1em]
&= - \frac{p}{4 \pi \epsilon_0} \left( \int_{r_0}^r \frac{2 \cos \phi_0}{r^3} dr + 0 + \int_{\phi_0}^{\phi} \frac{\sin \phi}{r^2} d\phi \right) \\\\[1em]
&= - \frac{p}{4 \pi \epsilon_0} \left( - \frac{\cos \phi_0}{r^2} +\frac{\cos \phi_0}{r_0^2} - \frac{\cos \phi}{r^2} + \frac{cos \phi_0}{r^2} \right) \\\\[1em]
&= \frac{1}{4 \pi \epsilon_0} \frac{p \cos \phi}{r^2} + \text{constant}
\end{align*}
$$

::::

**(b)** Calculate the flux of the dipole field through a sphere of radius $R$ centered at the origin.

:::expandable
**Solution.** [Click to Expand]

In a spherical surface, $\hat{\mathbf{n}} = \hat{\mathbf{e}}\_r$. Then:

$$
\begin{align*}
\Phi_{\mathbf{E}} &= \iint_S \mathbf{E} \cdot \hat{\mathbf{n}} dS \\\\[1em]
&= \iint_S \frac{1}{4 \pi \epsilon_0} \frac{2p}{R^3} \cos \phi dS \\\\[1em]
&= \frac{1}{4 \pi \epsilon_0} \frac{2p}{R^3} \iint_S \cos \phi dS \\\\[1em]
\end{align*}
$$

We have $dS = R^2 \sin \phi \\, d\phi \\, d \theta$. Then:

$$
\begin{align*}
\Phi_{\mathbf{E}} &= \frac{1}{4 \pi \epsilon_0} \frac{2p}{R^3} \int_{0}^{\pi} \int_{0}^{2\pi} R^2 \cos \phi \sin \phi \\, d\theta \\, d\phi  \\\\[1em]
&=\frac{1}{\epsilon_0} \frac{p}{R} \int_{0}^{\pi} \cos \phi \sin \phi \\, d\phi \\\\[1em]
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
\nabla \cdot \mathbf{F} = \frac{1}{r^2} \frac{\partial}{\partial r} \left( r^2 F_r \right) + \frac{1}{r \sin \phi} \frac{\partial}{\partial \phi} \left( F_\phi \sin \phi \right) + \frac{1}{r \sin{\phi}} \frac{\partial F_\theta}{\partial \theta}
$$

Then:

$$
\begin{align*}
\nabla \cdot \mathbf{E} &= \frac{p}{4 \pi \epsilon_0} \left( \frac{1}{r^2} \frac{\partial}{\partial r} \left( r^2 \frac{2}{r^3} \cos \phi \right) + \frac{1}{r \sin \phi} \frac{\partial}{\partial \phi} \left( \frac{\sin^2 \phi}{r^3} \right) + 0 \right)
\\\\[1em]
&= \frac{p}{4 \pi \epsilon_0} \left( \frac{1}{r^2} \left(-\frac{2}{r^2} \cos \phi \right) + \frac{1}{r \sin \phi} \left( \frac{2 \sin \phi \cos \phi}{r^3} \right) \right)
\\\\[1em]
&= \frac{p}{4 \pi \epsilon_0} \left( -\frac{2 \cos \phi}{r^4} + \frac{2 \cos \phi}{r^4} \right)
\\\\[1em]
&= 0
\end{align*}
$$

Now, given any closed surface $S$ that doesn't pass through the origin, there exists a sphere with 
$R > 0$ inside $S$ centered at the origin. Using part (b), flux of $\mathbf{E}$ over the sphere is 0.
Using problem II-27, since $\nabla \cdot \mathbf{E} = 0$ then flux of $\mathbf{E}$ over $S$ is
equal to the flux of $\mathbf{E}$ over the sphere, which is 0.

::::

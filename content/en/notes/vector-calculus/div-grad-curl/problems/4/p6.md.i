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

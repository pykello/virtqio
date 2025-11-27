# Introduction

This book presents vector calculus in the context of simple electrostatics.
Entire discussion is based on **finding the electrostatic field given the charge distribution that produces it**.

### Vector Functions

An example of a scalar function: $T(x, y, z)$ which associates the temperature at the point $(x, y, z)$ in space.

A vector function $\mathbf{F}(x, y, z)$ has a _magnitude_ and a _direction_ at each point in some region of space. For example, velocity of a fluid $\mathbf{v}(x, y, z)$.

A vector function can be decomposed into its components:

$$
\mathbf{F}(x, y, z) = \mathbf{i} F_x(x, y, z) + \mathbf{j} F_y(x, y, z) + \mathbf{k} F_z(x, y, z)
$$

where each of $F_x$, $F_y$, and $F_z$ are scalar functions themselves.

### Electrostatics
Our discussion is based on three experimental facts:

**1.** **Existence of electric charge.** There are two kinds of electric charge, positive and negative. Every material body contains electric charge. Often, zero net charge.

**2.** **Coulomb's law.** The electrostatic force between two charged particles is
proportional to the product of their charges and inversely proportional to the square of their distance.

The force on $q_0$ due to $q$ is given by

$$
\mathbf{F} = K \frac{q q_0}{r^2} \hat{\mathbf{u}}
$$

where $\hat{\mathbf{u}}$ is the unit vector pointing from $q$ to $q_0$. With
choice of MKS units, electric charge is measured in coulombs, distance in meters, and force in newtons.

Constant $\epsilon_0$ is called the permittivity of free space, and has
value $8.854 \times 10^{-12} \text{C}^2/\text{N m}^2$.
The constant $K$ is given by

$$
K = \frac{1}{4 \pi \epsilon_0}
$$

**3.** **Superposition principle.** If $\mathbf{F}_1$ is the force on $q_0$ due to $q_1$ when there are no other charges nearby, and $\mathbf{F}_2$ is the force on $q_0$ due to $q_2$ when there are no other charges nearby, then the force on $q_0$ due to both $q_1$ and $q_2$ is given by $\mathbf{F}_1 + \mathbf{F}_2$.

### Electrostatic Field
The force per unit charge. Electrostatic field at $\mathbf{r}$ due to the
charge $q$ is given by

$$
\mathbf{E}(\mathbf{r}) = \frac{\mathbf{F}(\mathbf{r})}{q_0}
= \frac{1}{4 \pi \epsilon_0} \frac{q}{r^2} \hat{\mathbf{u}}
\tag{I-2}
$$

Extension of these ideas: Suppose we have a group of $N$ charges $q_1, \ldots, q_N$ at positions $\mathbf{r}_1, \ldots, \mathbf{r}_N$. The force on a charge $q_0$ at position $\mathbf{r}$ is given by

$$
\mathbf{F}(\mathbf{r}) = \frac{1}{4 \pi \epsilon_0} \sum_{i=1}^N \frac{q_0 q_i}{|\mathbf{r} - \mathbf{r}_i|^2} \hat{\mathbf{u}}_{i}
\tag{I-3}
$$

where $\hat{\mathbf{u}}_i$ is the unit vector pointing from $\mathbf{r}_i$ to $\mathbf{r}$.

From this we can define the electrostatic field $\mathbf{E}(\mathbf{r})$ at $\mathbf{r}$ due to the group of charges:

$$
\mathbf{E}(\mathbf{r}) = \frac{1}{4 \pi \epsilon_0} \sum_{i=1}^N \frac{q_i}{|\mathbf{r} - \mathbf{r}_i|^2} \hat{\mathbf{u}}_{i}
\tag{I-4}
$$

That is, superposition principle applies to the electrostatic field as well.

Reasons for introducing the electrostatic field:
1. The problem we are interested in is finding the effect that a group of charges produces on another set. Electrostatic fields  help us divide the problem into two parts: (a) calculating the field due to a group of charges
without worrying about the effect of other charges, and (b) calculating the force on a charge due to the field.

2. The electrostatic field is more basic. Entire classical electromagnetic theory can be codified in terms of four basic equations, called Maxwell's equations, which relate fields to each other and to the charges and currents that produce them.

### Treating the charge distribution as continuous
Suppose in some region of space of volume $\Delta V$ the total electric charge is $\Delta Q$. We can define the _average charge density_ in that region as

$$
\overline{\rho}_{\Delta V} = \frac{\Delta Q}{\Delta V}
\tag{I-5}
$$

Then charge density at point $(x, y, z)$ is defined as

$$
\rho(x, y, z) = \lim_{\Delta V \to 0} \frac{\Delta Q}{\Delta V}
= \lim_{\Delta V \to 0} \overline{\rho}_{\Delta V}
\tag{I-6}
$$

Then the electric charge in some region is given by

$$
Q = \int\int\int_V \rho(x, y, z) dV
$$

Then

$$
\mathbf{E}(\mathbf{r}) = \frac{1}{4 \pi \epsilon_0} \int\int\int_V \frac{\rho(\mathbf{r'})
\hat{\mathbf{u}}(\mathbf{r'})
}{|\mathbf{r} - \mathbf{r'}|^2}  dV'
\tag{I-7}
$$


# Math Playground

This page pairs shorthand source with the rendered math it produces.

### Inline Basics

```text
$v{x}, bb{R}, cal{F}, hat{n}, unit{n}$

$norm(v{x} - v{y}) <= eps,\quad norm[2](v{x}) = 1,\quad abs(t) < del$

$ip(v{u}, v{v}) = dot(v{u}, v{v}),\quad cross(v{u}, v{v}) dot unit{n} = 0$

$dist(x, y) <= norm(tuple(x_1, ..., x_n) - tuple(y_1, ..., y_n))$

$seq(v{x}_n) \text{ converges in } bb{R}^n$
```

$v{x}, bb{R}, cal{F}, hat{n}, unit{n}$

$norm(v{x} - v{y}) <= eps,\quad norm[2](v{x}) = 1,\quad abs(t) < del$

$ip(v{u}, v{v}) = dot(v{u}, v{v}),\quad cross(v{u}, v{v}) dot unit{n} = 0$

$dist(x, y) <= norm(tuple(x_1, ..., x_n) - tuple(y_1, ..., y_n))$

$seq(v{x}_n) \text{ converges in } bb{R}^n$

### Scaled Brackets And Sets

```text
:::math
( \frac{1}{1 + norm(v{x})} )
\;
[ A^{-1} B A ]
\quad
set(v{x} in bb{R}^n | norm(v{x}) < r)
\quad
set(t : 0 <= t <= 1)
:::
```

:::math
( \frac{1}{1 + norm(v{x})} )
\;
[ A^{-1} B A ]
\quad
set(v{x} in bb{R}^n | norm(v{x}) < r)
\quad
set(t : 0 <= t <= 1)
:::

### Topology

```text
:::math
img(f, A) subset B
<=>
A subset pre(f, B)

cl(A) = comp(interior(comp(A)))

bd(A) = cl(A) inter cl(comp(A))

ball(v{x}, r) subset closedball(v{x}, r)
:::
```

:::math
img(f, A) subset B
<=>
A subset pre(f, B)

cl(A) = comp(interior(comp(A)))

bd(A) = cl(A) inter cl(comp(A))

ball(v{x}, r) subset closedball(v{x}, r)
:::

### Cases

```text
$abs(x) = cases(x | x >= 0; -x | x < 0)$

:::math
f(x, y) = cases:
\frac{x y}{x^2 + y^2} | (x, y) != (0, 0)
0 | (x, y) = (0, 0)
:::
```

$abs(x) = cases(x | x >= 0; -x | x < 0)$

:::math
f(x, y) = cases:
\frac{x y}{x^2 + y^2} | (x, y) != (0, 0)
0 | (x, y) = (0, 0)
:::

### Limits And Indexed Operators

```text
:::math
lim[v{x} -> v{x}_0] v{f}(v{x}) = v{a}

lim[h -> 0](\frac{f(x+h) - f(x)}{h}) = dd(f, x)

sum[i=1..n](a_i v{e}_i) = v{a}

prod[i=1..n](lambda_i) = detmat(lambda_1, 0; 0, lambda_2)

sup[x in A](f(x)) >= max[x in K](f(x))

inf[x in A](f(x)) <= min[x in K](f(x))

union[alpha in I](U_alpha) = inter[n=1..inf](V_n)
:::
```

:::math
lim[v{x} -> v{x}_0] v{f}(v{x}) = v{a}

lim[h -> 0](\frac{f(x+h) - f(x)}{h}) = dd(f, x)

sum[i=1..n](a_i v{e}_i) = v{a}

prod[i=1..n](lambda_i) = detmat(lambda_1, 0; 0, lambda_2)

sup[x in A](f(x)) >= max[x in K](f(x))

inf[x in A](f(x)) <= min[x in K](f(x))

union[alpha in I](U_alpha) = inter[n=1..inf](V_n)
:::

### Integrals

```text
:::math
int[a..b](F(x), x) = Phi(b) - Phi(a)

int[C](v{F} dot unit{t}, s)
= int[t_0..t_1](dot(v{F}(v{r}(t)), dd(v{r}, t)), t)

iint[S](v{F} dot unit{n}, S) = iiint[V](div(v{F}), V)

oint[C](v{F} dot unit{t}, s) = iint[S](curl(v{F}) dot unit{n}, S)
:::
```

:::math
int[a..b](F(x), x) = Phi(b) - Phi(a)

int[C](v{F} dot unit{t}, s)
= int[t_0..t_1](dot(v{F}(v{r}(t)), dd(v{r}, t)), t)

iint[S](v{F} dot unit{n}, S) = iiint[V](div(v{F}), V)

oint[C](v{F} dot unit{t}, s) = iint[S](curl(v{F}) dot unit{n}, S)
:::

### Derivatives And Vector Calculus

```text
:::math
dd(x, t) = v{v}(t) \quad dd[2](x, t) = v{a}(t)

pd(f, x) \quad pd[2](f, x) \quad pd2(f, x, y)

grad(phi) = pd(phi, x) v{i} + pd(phi, y) v{j} + pd(phi, z) v{k}

div(v{F}) = pd(F_x, x) + pd(F_y, y) + pd(F_z, z)

curl(v{F}) = detmat(v{i}, v{j}, v{k}; \frac{\partial}{\partial x}, \frac{\partial}{\partial y}, \frac{\partial}{\partial z}; F_x, F_y, F_z)

jac(v{f}) = mat(pd(f_1, x_1), pd(f_1, x_2); pd(f_2, x_1), pd(f_2, x_2))

hess(f) = mat(pd[2](f, x), pd2(f, x, y); pd2(f, y, x), pd[2](f, y))
:::
```

:::math
dd(x, t) = v{v}(t) \quad dd[2](x, t) = v{a}(t)

pd(f, x) \quad pd[2](f, x) \quad pd2(f, x, y)

grad(phi) = pd(phi, x) v{i} + pd(phi, y) v{j} + pd(phi, z) v{k}

div(v{F}) = pd(F_x, x) + pd(F_y, y) + pd(F_z, z)

curl(v{F}) = detmat(v{i}, v{j}, v{k}; \frac{\partial}{\partial x}, \frac{\partial}{\partial y}, \frac{\partial}{\partial z}; F_x, F_y, F_z)

jac(v{f}) = mat(pd(f_1, x_1), pd(f_1, x_2); pd(f_2, x_1), pd(f_2, x_2))

hess(f) = mat(pd[2](f, x), pd2(f, x, y); pd2(f, y, x), pd[2](f, y))
:::

### Matrices

```text
:::math
A = mat(2, 3, 1; 6, 13, 5; 2, 19, 10)

v{x} = pmat(x_1; x_2; x_3)

\det(A) = detmat(a, b; c, d) = ad - bc

Q^T Q = I
:::
```

:::math
A = mat(2, 3, 1; 6, 13, 5; 2, 19, 10)

v{x} = pmat(x_1; x_2; x_3)

\det(A) = detmat(a, b; c, d) = ad - bc

Q^T Q = I
:::

### Differential Forms

```text
:::math
omega = P dx + Q dy + R dz

wedge(dx, dy) = -wedge(dy, dx)

ext(omega) = pd(Q, x) wedge(dx, dy) + pd(R, y) wedge(dy, dz) + pd(P, z) wedge(dz, dx)

pull(T, omega)(v{u}) = omega(T v{u})

form(v{F}) = F_x dx + F_y dy + F_z dz

boundary(Phi) = 0
:::
```

:::math
omega = P dx + Q dy + R dz

wedge(dx, dy) = -wedge(dy, dx)

ext(omega) = pd(Q, x) wedge(dx, dy) + pd(R, y) wedge(dy, dz) + pd(P, z) wedge(dz, dx)

pull(T, omega)(v{u}) = omega(T v{u})

form(v{F}) = F_x dx + F_y dy + F_z dz

boundary(Phi) = 0
:::

### Greek, Logic, And Relations

```text
:::math align
&forall eps > 0, exists del > 0:
&norm(v{x} - v{x}_0) < del
&=> norm(v{f}(v{x}) - v{a}) < eps
&alpha, beta, gamma, theta, lambda, mu, rho, sigma, omega, Phi
&x in A \quad y notin B \quad x != y \quad A <=> B \quad n -> inf \quad 1 + ... + n
:::
```

:::math align
&forall eps > 0, exists del > 0:
&norm(v{x} - v{x}_0) < del
&=> norm(v{f}(v{x}) - v{a}) < eps
&alpha, beta, gamma, theta, lambda, mu, rho, sigma, omega, Phi
&x in A \quad y notin B \quad x != y \quad A <=> B \quad n -> inf \quad 1 + ... + n
:::

### Mixed With LaTeX

```text
:::math align
\sqrt[n]{norm(v{x})^n + norm(v{y})^n} &<= norm(v{x}) + norm(v{y})

v{E} &= \frac{1}{4 \pi eps_0} sum[i=1..N](\frac{q_i}{norm(v{r} - v{r}_i)^2} unit{u}_i)

\operatorname{rank}(jac(v{f})(v{x}_0)) &= n

\left. pd(phi, x)\right|_{x=0} &= 0

S_n &= sum[k=1..n](a_k) \\
&= S_{n-1} + a_n
:::
```

:::math align
\sqrt[n]{norm(v{x})^n + norm(v{y})^n} &<= norm(v{x}) + norm(v{y})

v{E} &= \frac{1}{4 \pi eps_0} sum[i=1..N](\frac{q_i}{norm(v{r} - v{r}_i)^2} unit{u}_i)

\operatorname{rank}(jac(v{f})(v{x}_0)) &= n

\left. pd(phi, x)\right|_{x=0} &= 0

S_n &= sum[k=1..n](a_k) \\
&= S_{n-1} + a_n
:::

### Auto-Aligned Block

```text
:::math
norm(v{a} - v{b})
<= norm(v{a} - v{x}) + norm(v{x} - v{b})
< eps + eps
= 2eps
:::
```

:::math
norm(v{a} - v{b})
<= norm(v{a} - v{x}) + norm(v{x} - v{b})
< eps + eps
= 2eps
:::

### Forced Align And Tags

```text
:::math align tag=VC.1
v{F} &= P v{i} + Q v{j} + R v{k}
curl(v{F}) &= (pd(R, y) - pd(Q, z)) v{i}
&+ (pd(P, z) - pd(R, x)) v{j}
&+ (pd(Q, x) - pd(P, y)) v{k}
:::
```

:::math align tag=VC.1
v{F} &= P v{i} + Q v{j} + R v{k}
curl(v{F}) &= (pd(R, y) - pd(Q, z)) v{i}
&+ (pd(P, z) - pd(R, x)) v{j}
&+ (pd(Q, x) - pd(P, y)) v{k}
:::

### Plain Block

```text
:::math plain
\begin{array}{rcl}
x + y &=& 1 \\
x - y &=& 0
\end{array}
:::
```

:::math plain
\begin{array}{rcl}
x + y &=& 1 \\
x - y &=& 0
\end{array}
:::

### System Block

```text
:::math system tag=linear
2x + 3y = 1
x - y = 0
:::
```

:::math system tag=linear
2x + 3y = 1
x - y = 0
:::

### Matrix Block

```text
:::math matrix tag=A
1, 2, 3
0, 1, 4
5, 6, 0
:::
```

:::math matrix tag=A
1, 2, 3
0, 1, 4
5, 6, 0
:::

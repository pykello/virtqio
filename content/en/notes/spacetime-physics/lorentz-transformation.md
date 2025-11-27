# Special Topic: Lorentz Transformation

Layout of the physical world can be described in two equivalent ways:
- Using events and intervals between them.
- Or isolated events described by their spacetime coordinates (latticework of recording clocks).

**Lorentz transformation** translates event description from lattice of one inertial
frame to that of another inertial frame.

### L.2 Faster than light?

If I fly at 4/5 the speed of light and fire a bullet that I observe to fly forward at
4/5 the speed of light, isn't the bullet flying at 8/5 the speed of light relative
to the observer on the ground?

No. Velocities don't simply add. The speed the observer will measure will be 40/41
the speed of light.

How did we get this result? Using **Lorentz transformation**.

Space and time separations between two events typically don't have the same values in
different inertial frames.

Here the events are:
- Event 1: bullet is fired
- Event 2: bullet strikes a target ahead

Using the invariance of the spacetime interval, we can calculate the separations in
the frame of a passenger on the bullet. But to get the separations in the frame of
the observer on the ground, we need **Lorentz coordinate transformation equations**.

### L.3 First Steps

**Goal.** Find $t$ and $x$ given $t'$, when $x' = 0$.

Assume we have a rocket moving at speed $v_\text{rel}$ relative to the observer in the lab.
Take the spatial origins of the two frames to coincide at time $0$.

Let a spark occur at the origin of the rocket frame ($x' = 0$) at time $t$ of the lab frame.

Since the rocket is moving at speed $v_\text{rel}$ relative to the lab frame,
the spark will occur at position $x = v_\text{rel} t$.

Now, using the invariance of the spacetime interval, we can calculate $t'$,

$$
t' = t \left( 1 - v_\text{rel}^2 \right)^{1/2}
$$

Or

$$
t = \frac{t'}{\left( 1 - v_\text{rel}^2 \right)^{1/2}}
$$

We define the **time stretch factor** as

$$
\gamma = \frac{1}{\left( 1 - v_\text{rel}^2 \right)^{1/2}}
$$

So we have $t = \gamma t'$ (when $x' = 0$).

Then, we have $x = v_\text{rel} \gamma t'$ (when $x' = 0$).

### L.4 Form of the Lorentz Transformation

In this section the book argues that the general form of the transformation must be linear.

That is, the general form should be:

$$
\begin{aligned}
t &= B x' + D t' \\
x &= G x' + H t'
\end{aligned}
$$

Why? since we are free to choose any event as the reference event. See the book for more details.

### L.5 Completing the Derivation

Using the special case in section L.3, we can find $D$ and $H$:

$$
\begin{aligned}
t &= B x' + \gamma t' \\
x &= G x' + v_\text{rel} \gamma t'
\end{aligned}
$$

Demanding the invariance of interval between any pair of events whatsoever,
leads to completed form of the Lorentz transformation:

$$
\begin{aligned}
t &= \gamma \left( t' + v_\text{rel} x' \right) \\
x &= \gamma \left( x' + v_\text{rel} t' \right)
\end{aligned}
$$

or

$$
\begin{aligned}
t &= \frac{v_\text{rel} x' + t'}{\left( 1 - v_\text{rel}^2 \right)^{1/2}} \\[0.5em]
x &= \frac{x' + v_\text{rel} t'}{\left( 1 - v_\text{rel}^2 \right)^{1/2}}
\end{aligned}
$$

### L.6 Inverse Lorentz Transformation

$$
\begin{aligned}
t' &= \frac{-v_\text{rel} x + t}{\left( 1 - v_\text{rel}^2 \right)^{1/2}} \\[0.5em]
x' &= \frac{x - v_\text{rel} t}{\left( 1 - v_\text{rel}^2 \right)^{1/2}}
\end{aligned}
$$

### L.7 Addition of Velocities

Add light velocity to light velocity: gives light velocity!

**Law of addition of velocities:**

$$
v = \frac{v' + v_\text{rel}}{1 + v' v_\text{rel}}
$$

**Example 1.** A rocket moves at $4/5$ the speed of light relative to the lab observer.
A bullet is fired from the rocket at $4/5$ the speed of light relative to the rocket.
What is the speed of the bullet relative to the lab observer?

$$
v = \frac{4/5 + 4/5}{1 + (4/5)(4/5)} = \frac{8/5}{1 + 16/25} = \frac{8/5}{41/25} = \frac{40}{41}
$$

**Example 2.** Suppose that bullet that is fired is in fact a beam of light. What is the
speed of the light beam relative to the lab observer?

$$
v = \frac{1 + 4/5}{1 + (1)(4/5)} = \frac{9/5}{9/5} = 1
$$


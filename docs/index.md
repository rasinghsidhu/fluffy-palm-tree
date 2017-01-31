---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
title: Writeup
---

[Download Source Code Here](https://github.com/rasinghsidhu/fluffy-palm-tree/archive/v1.tar.gz)

![Multiple solutions][multi-solutions]
Figure 1. Multiple solutions generated for Part 4

## Part 1

![Arm crawls around obstacle][p1-view1]
Figure 2. Arm crawls around obstacle, Part 1


# Forward Kinematics

Forward Kinematics are created simply by recursively generating frames for each joint that are parameterized by the r,p,y of all joints before it. This simply boils down to generating a rotation matrix and translation matrix which transforms the current frame into the next joints frame.

# Choosing Criteria

My criteria is a function of 3 separate metrics that I am optimizing over.

* Distance from target point
* Distance from target orientation
* Distance of Joint Parameters from Set Points (average of upper and lower bounds)

The weights of these parameters are all adjusted to heavily weight the first 2 criteria over the 3rd as well as to scale for differences in units.

# Choosing Constraints

There are two constraints enforced.

* Bounds the joints by their upper and lower bounds.
* Distance from each line segments and every obstacle must be greater than an obstacle's radius

# Special Consideration - Quaternion Distance Metric

The distance between the gripper orientation and the target orientation is given by a simple metric, 1 - abs(dot(q1,q2)), given that q1 and q2 are normalized. This metric has a number of advantages as laid out in the paper, [Metrics for 3D Rotations: Comparison and Analysis](http://www.cs.cmu.edu/~cga/dynopt/readings/Rmetric.pdf).

# Special Consideration - Obstacle Distance Optimization

After testing I discovered that computing the distance between each line segment and every obstacle is a very slow operation especially if it's computed using loops in matlab. In order to speed this up I use an approximate heuristic by picking ten points along each line segment and checking the distance using those sampled points. This does result in more distance computations but significantly less branching and looping which leads to a drastic speed up.

## Part 2

# Analytical Derivative

In order to find an analytical derivative, I decided to use Matlab's symbolic toolkit. I basically create symbols for each parameter and run it through my criterion. This generates an expression for the criterion in terms of all the parameters. Matlab then provides a simple function gradient for performing 1st and 2nd order derivatives. The downside to this approach is that it is slow for large number of parameters i.e links.

# Results

The performance of fmincon given the gradient and hessian is a much faster and more robust approach to the target. It often finds a minimum that results in a very good solution and also approaches this minimum much faster.

This makes sense as fmincon itself in some sense estimates the derivative by using finite differences. By providing an analytical solution, fmincon does not need to use finite differences to estimate derivatives at a point and does not suffer from error in choosing a wrong finite step size. 

# Special Considerations - Constraints vs Criterion

Initially I had formulated the constraints and criterion such that it was enforced that the point be at the target position and orientation. However because of this I needed to derivate all constraints which included obstacle distances. This turns out to be a huge computational burden as symbolic math can be incredibly slow. That was when I decided to switch target position and orientation to criteria and only derivate the criteria.


## Part 3

# interior-point vs sqp vs active-set

sqp and active-set seemed to descend very quickly to a minimum which was close to the target but interior-point moves very slowly in the beginning. Unfortunately I couldn't run 'trust-region-reflective' because it was incredibly slow to use symbolic toolkit to calculate an analytic gradient which included distance to obstacles.

# CMAES

CMAES offered highly robust and very, very quick descents to optimal solutions. It worked very well especially considering how expensive computing the criteria is. 

# Results

In terms of speed CMAES was the clear winner. sqp and active-set descending very quickly as well. interior-point seemed to grow very slowly at first with rapid expansions at certain times and slow expansions at other. 

In terms of answer quality, it seems like CMAES offered very a robust solution as it seemed like it would escape local minima that the other optimizers would get stuck in. 


## Part 4

# Multistart

!["Part 4"][fig3]

Figure 3. Another run through of part4. Red and blue are very similar solutions but green is completely distinct.

It can be difficult to "guarantee" that there are multiple distinct solutions but one can attempt to find them by randomly initializing parameters and running a gradient descent optimizer with these various pts. 

I personally used Matlabs multistart solver to try out random params and took the 4 best ones to display. I found that the input space is so large that any randomly chosen inputs would arrive at different unique solutions unless there is one "best" solution that attracts large portions of the input space. A way to combat this is to take a distance metric (like L2 norm) between outputs of the multi start and weight the distance between outputs as a cut off for determining if it is a "distinct" solution.










[multi-solutions]: assets/multiple-fig1.png
[p1-view1]: assets/p1-view1.png
[fig3]: assets/p4-fig1.png
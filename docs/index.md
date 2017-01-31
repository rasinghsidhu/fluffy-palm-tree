---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
title: Writeup
---

![Multiple solutions][multi-solutions]
Figure 1. Multiple solutions generated for Part 4

## Part 1


# Forward Kinematics

# Choosing Criteria

My criteria is a function of 3 separate metrics that I am optimizing over.

* Distance from target point
* Distance from target orientation
* Distance of Joint Parameters from Set Points (average of upper and lower bounds)

The weights of these parameters are all adjusted to weight position and orientation over joint parameters as well as to account for differences in units.

# Choosing Constraints

There are two constraints enforced.

* Bounds the joints by their upper and lower bounds.
* Distance from each line segments and every obstacle must be greater than an obstacle's radius

## Part 2

# Analytical Derivative

In order to find an analytical derivative, I decided to use Matlab's symbolic toolkit. I basically create symbols for each parameter and run it through my criterion. This generates an expression for the criterion in terms of all the parameters. Matlab then provides a simple function gradient for performing 1st and 2nd order derivatives. The downside to this approach is that it is slow for large number of parameters i.e links.

# Results

The performance of fmincon given the gradient and hessian is a much faster and more robust approach to the target. It usually finds a minimum that results in a very close solution and also gives up much faster if it is not going to find a solution. 

This makes sense as fmincon itself in some sense follows the derivative and estimates it using finite differences. By providing an analytical solution, fmincon does not need to use finite differences to estimate derivatives at a point and does not suffer from error in choosing a wrong finite step size. 











[multi-solutions]: assets/multiple-fig1.png
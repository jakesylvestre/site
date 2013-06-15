---
layout: post
title: Basics of Recursion
category: programming
tags: [programming, recursion]
author: [wei2912, manu--27993]
sources: ["http://www.cob.sfasu.edu/rball/342/Luke_Divide-and-conquer.html"]

status: draft

summary: Recursion, while in theory, can be very easy to master, in practice it can be extremely difficult to implement if not learnt well. In this tutorial, we'll try to get you to understand recursion!

location: _posts/programming/2013-02-15-Recursion.md
---

Recursion is basically a function calling itself over and over again, till it reaches a stop.

## Factorial (!) with recursion

If you can remember, factorial is the product of all integers less than or equal to _n_.

For example:

    3! = 3 * 2 * 1
       = 6
       
If you were to write this with normal loops (in psuedocode):

    Assign n to 1.
    For i = 3, i is greater than 0, i--:
        n *= i

This is actually more efficient than the recursive way (since it requires no function calls), but we'll still show the recursive way as an example and part of this tutorial.

First, let's look at the sequence of steps:

1. fact(3) is called.
2. fact(3) asks fact(2) for a value.
3. fact(2) asks fact(1) for a value.
4. fact(1) tells fact(2) the value is 1. (how do we know? because 1! is definitely 1. you can do the same for the other values, but it'd be exhaustive to create a gigantic list of numbers just for that)
5. fact(2) tells fact(3) the value is 1x2 (2).
6. fact(3) tells the caller the value is 2x3 (6).

Now, we shall write the base function in psuedocode.

    fact(n):
        return n * fact(n-1)
        
Notice that this satisfies the above steps.

To end off, we can write the base case to prevent a [stack overflow](https://en.wikipedia.org/wiki/Stack_overflow) and allow the recursive function to stop. Every recursive function must have at least one base case.

    fact(n)
        if n is 1 or n is 0
            return 1
        return n * fact(n-1)
        
<!--more-->
## Fibonacci

Implementing the [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_number) is slightly harder than the previous example. In case you don't know what it is, here's a brief explanation:

The Fibonacci sequence looks like this:

1, 1, 2, 3, 5, 8, 13, 21, 34, 55...

See a pattern? For the nth term of the sequence, the result is (n-1)th term + (n-2)th term.

For example, for the third term:

	3rd term = 2nd term + 1st term
	         = 1 + 1
	         = 2

Writing the base function:

    fib(n)
        return fib(n-1) + fib(n-2)

We already know that the 1st and 2nd term is 1. Thus, we can add a base case for that.

    fib(n)
	    if n is 1 or n is 2
	        return 1

## Even or Odd?

Imagine that you could only use + and - (muhahaha), no / or % (modulus - finding the remainder of a division). How do you check for an even number?

First, let's think of how an even number is defined. An even number can be subtracted by another smaller even number and remain even. The same goes for an odd number. Let's make that smaller even number 2 so that we don't need to do any weird calculations.

If n - 2 is odd, the number is odd.
If n - 2 is even, the number is even.

In this case, we could create a recursive function. Once everything is reduced, the numbers will eventually reach 1 or 0. These two numbers can determine if the number is odd or even.

Let's write the base function first.

    isEven(n)
        return isEven(n-2)

Now to add the base case:

    isEven(n)
        if n is 0
            return true
        else if n is 1
            return false
        return isEven(n-2)

## Why did we go through all these exercises?

Recursion is not easy to master. It's an easy concept to learn, but once you delve into it, you'll need to master it before you can come up with complex recursive methods.

That said... let's get into some ways you can conquer recursion.

## Divide and Conquer

[Divide and Conquer](https://en.wikipedia.org/wiki/Divide_and_conquer_algorithm) is taking a large problem and dividing it into smaller subproblems. These subproblems can be divided even further. This allows 1) problems to be solved more efficiently 2) problems to be solved easily. Code is actually *cleaner* and *more efficient* when you apply this.

Let's take a look at the [Merge sort](https://en.wikipedia.org/wiki/Mergesort). The function takes in a list that contains *n* objects.

First, the list is split in half. And half. Repeatedly (that's the nature of recursion) till it reaches 1, since a list that contains only 1 object is somewhat *already* sorted, since the original result and the result after sorting is the same.

	{9, 5, 21, 7, 23, 4}
	{9, 5} {21, 7} {23, 4}
	{9} {5} {21} {7} {23} {4}

Base case: All lists contain only 1 object.

**This is the first problem.**

Now, we merge the lists together. Two lists are merged together. The smaller object comes first, then the larger object.

	{9} {5} {21} {7} {23} {4}
	{5, 9} {7, 21} {4, 23}
	
Base case: The first value of each list is smaller than the second value.
	
**This is the second problem.**

Now, the smallest object from the first two lists (remember - it's the first object)is checked to find out the smallest of them all. The smallest object is then placed in the new list. The lists on the left of the seperator are the lists above, while the list on the right is the new list.

	{5, 9} {7, 21} {4, 23} | {}
	{9} {7, 21} {4, 23} | {5}
	{9} {21} {4, 23} | {5, 7}
	{} {21} {4, 23} | {5, 7, 9}
	
Since the first list is now empty, the new list and the second list is now merged.. A new empty list is then created.

    {5, 7, 9, 21} {4, 23} | {}
    {5, 7, 9, 21} {23} | {4}
    {7, 9, 21} {23} | {4, 5}
    {9, 21} {23} | {4, 5, 7}
    {21} {23} | {4, 5, 7, 9}
    {} {23} | {4, 5, 7, 9, 21}
    
Once again, the list is merged. The algorithm detects that there is only one list and thus returns that list.

    {4, 5, 7, 9, 21, 23}
	
Base case: There is only one list left.

**This is the third problem.**

As from the above diagrams, this problem is not easy to solve. Let's try to solve each subproblem first.

### Splitting lists (1st problem)

Splitting lists is easy.

    split_list(List l)
        List of lists new_l
        for i in l
            Create a new list with l[i] and put it in new_l
        return new_l
        
### Merging lists (2nd problem)

Psuedocode (no recursion required):

    merge_list(List x, List y)
        if x[0] is less than y[0]
            return {x[0], y[0]}
        else if x[0] is more than y[0]
            return {y[0], x[0]}
            
### Sorting everything (3rd problem)

This is the most difficult subproblem to solve...
        
First, we need multiple lists for the main function.

    sort_list(List of lists l)
        Assign new_list to a newly created list.
        .
        .
        .
        
Second, let's divide it further. We need an algorithm to find the smallest possible value. This means we have to sort (what?)... nah, just compare two values.
        
    sort_list(List of lists l)
        Assign new_list to a newly created list.
        Assign x to l[0].
        Assign y to l[1].
        if x[0] is less than y[0]
            .
            .
            .
        else
            .
            .
            .
            
Remember that it doesn't matter which comes first if the values are equal, thus you can simply use an else clause instead of checking if the value is more.

Thirdly, we need to add the new values to the list.
        
    sort_list(List of lists l)
        Assign new_list to a newly created list.
        Assign x to l[0].
        Assign y to l[1].
        if x[0] is less than y[0]
            Add x[0] to new_list.
            Remove first index of x[0].
        else
            Add y[0] to new_list.
            Remove first index of y[0].
        
Now, we need to rearrange the lists and assign the new values.
        
    sort_list(List of lists l)
        .
        .
        .
        if x has no objects
            Add new_list before y.
            Remove first index of l.
            Set (now) first index of l to y.
        if y has no objects
            Add new_list before x (merging).
            Remove second index of l.
            Set first index of l to x.
        l[0] = x
        l[1] = y

And call the new function once more.

        return sort_list(l)

We need to add the base case now.

    sort_list(List of lists l)
        if l has only one list
            return l
        .
        .
        .
        
Finally... here's the whole function:

    sort_list(List of lists l)
        if l has only one list
            return l
        
        Assign new_list to a newly created list.
        Assign x to l[0].
        Assign y to l[1].
        if x[0] is less than y[0]
            Add x[0] to new_list.
            Remove first index of x[0].
        else
            Add y[0] to new_list.
            Remove first index of y[0].
        if x has no objects
            Add new_list before y.
            Remove first index of l which is x, which no longer has any objects.
            Set (now) first index of l to y.
        if y has no objects
            Add new_list before x (merging).
            Remove second index of l which is y, which no longer has any objects.
            Set first index of l to x.
        l[0] = x
        l[1] = y
        return sort_list(l)

We've finally done it!

### Combining everything up

Right now, we have these functions:

    split_list(List l)
        List of lists new_l
        for i in l
            Create a new list with l[i] and put it in new_l
        return new_l
        
    merge_list(List x, List y)
        if x[0] is less than y[0]
            return {x[0], y[0]}
        else if x[0] is more than y[0]
            return {y[0], x[0]}
            
    sort_list(List of lists l)
        if l has only one list
            return l[0]
        
        Assign new_list to a newly created list.
        Assign x to l[0].
        Assign y to l[1].
        if x[0] is less than y[0]
            Add x[0] to new_list.
            Remove first index of x[0].
        else
            Add y[0] to new_list.
            Remove first index of y[0].
        if x has no objects
            Add new_list before y.
            Remove first index of l which is x, which no longer has any objects.
            Set (now) first index of l to y.
        if y has no objects
            Add new_list before x (merging).
            Remove second index of l which is y, which no longer has any objects.
            Set first index of l to x.
        l[0] = x
        l[1] = y
        return sort_list(l)

We need to combine it all together. This can be easily done with this:

    msort(List l)
        List of lists new_l = split_list(l)
        List of lists new_l2
        for i in new_l
            Add merge_list(i, i+1) to new_l2
            i++
        return sort_list(l)
        
Despite the fact that we didn't use recursion for everything, we still managed to solve the problem efficiently. Recursion is not something that should be used at all times; rather, it is the same as other programming techniques: use it when you need it.

## Binary search (another problem?!)

[Binary search](https://en.wikipedia.org/wiki/Binary_search) is slightly less complicated than the above. If you've ever struggled to search through a dictionary, you may have tried something similar to this before in your life...

### Demonstration

Binary search basically finds an index based on a number obtained. Instead of brute forcing through everything (called the [Linear search](https://en.wikipedia.org/wiki/Linear_search)), it uses an intelligent algorithm.

Firstly, we will take a look at how linear search works.

Linear search basically goes through every index and checks if it's equal to the number given. If it isn't, continue. This isn't exactly efficient, but it is very simple.

Now, let's talk about binary search. Binary search requires an array to be sorted (note that to execute a sort + binary search is still faster than a linear search) beforehand. You'll see why soon.

Let's start off with an array.

    {9, 2, 3, 5, 67, 21, 932, 534, 656, 23, 90, 34}

Of course, this isn't sorted. We'll not go indepth into how this is sorted. Instead, we'll assume it's already sorted:

    {2, 3, 5, 9, 21, 23, 34, 67, 90, 534, 656, 932}

First, we'll assume we're searching for 21. We start off from the middle. The middle for this is index 7 (*n / 2 + 1* since the decimal places are to be truncated).

    {2, 3, 5, 6, 21, 23, [[[34]]], 67, 90, 534, 656, 932}

Is 21 smaller or larger? Compared to 34, it is smaller. Thus, we move on to the left side and cut at the middle. (other side will be truncated for clarity)

    **{2, 3, 5, [[[6]]], 21, 23}** {34, 67, 90, 534, 656, 932}

6 is smaller than 21, so we'll move on to the right side:

    {2, 3, 5, 6} **{21, [[[23]]]}** {34, 67, 90, 534, 656, 932}

23 is larger than 21, so we'll move on to the left side:

    {2, 3, 5, 6} **{[[[21]]]}** {23} {34, 67, 90, 534, 656, 932}

The middle is now 21 (of a one size list). Congrats, we found the index! The index of 21 is 5.

### Subproblem

This binary search problem is the type of Divide and Conquer problems where there is only one subproblem. The whole problem requires that solution to be solved.

The subproblem in this case is basically a smaller version of the binary search problem. We have 3 values.

    {1, 2, 3}
    
How do we obtain the index of each?

Let's start with a basic definition of the function

    bsearch(List l, number)
        Assign middle to l/2+1
        bsearch(l, middle, number)

    bsearch(l, index, number)
        .
        .
        .

We overloaded the functions to provide easy access. Now, the first thing we need to do is obtain the index and check if it's the correct number.

    bsearch(l, index, number)
        if l[index] is equal to number
            return number
        .
        .
        .

Now, we are going to compare.

    bsearch(l, index, number)
        if l[index] is equal to number
            return number
        else if l[index] is greater than number
            return bsearch(l, (l.length - index)/2+1, number)
        else if l[index] is lower than number
            return bsearch(l, index/2+1, number)
            
Interestingly, we've solved not only this subproblem, but the *full* problem, as this can also be used for the larger problem.

Get the algorithm? This is much simpler than mergesort, but it shows a type of Divide and Conquer problem that has one small subproblem which you focus on.

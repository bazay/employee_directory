# Interview Question

Imagine you are the team that maintains the Atlassian employee directory.
At Atlassian - there are multiple groups, and each can have one or more groups. Every employee is part of a group.
You are tasked with designing a system that could find the closest common parent group given a target set of employees in the organization.

**Data Model Diagram**

![group and employee tree diagram](/images/diagram.jpg)

## Installation

Install gem dependencies with the following command:

    $ bundle install

## Usage

==> Input dataType = String
==> You can decide on the output datatype

Input Target employees (String) - Lisa, Marley
Output (String/Group) : FE
Input Target employees (String) - Alice, Marley
Output (String/Group): Engg
Input Target employees (String) - Mona, Lisa, Bob
Output (String/Group): Company

EXT1: How can you solve for multiple groups

fun getCommonGroupForEmployees(...)

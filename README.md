# Interview Question

Imagine you are the team that maintains the Atlassian employee directory.
At Atlassian - there are multiple groups, and each can have one or more groups. Every employee is part of a group.

### Question
You are tasked with designing a system that could find the closest common parent group given a target set of employees in the organization.

For example:
```
==> Input dataType = String
==> You can decide on the output datatype

1. Input Target employees (String) - Lisa, Marley
==> Output (String/Group) : FE

2. Input Target employees (String) - Alice, Marley
==> Output (String/Group): Engg

3. Input Target employees (String) - Mona, Lisa, Bob
==> Output (String/Group): Company
```

This can be solved by implementing the following method:
```ruby
def get_common_group_for_employees(employees: ["Mona", "Lisa", "Bob"]); end
```

### Extension Questions

1. How can you solve when employees belong to multiple groups?

### Data Model Diagram

![group and employee tree diagram](/images/diagram.jpg)

## Installation

Install gem dependencies with the following command:

    $ bundle install

## Usage

To run all tests use the following command from root directory path:
```
rspec spec/
```

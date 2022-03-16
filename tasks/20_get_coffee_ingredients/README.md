This is a template project for simple for Robot Framework projects that are based on Camunda and plain Robot Framework. 
It provides a basic directory structure:

- **libraries** : Folder for local python keywords
- **resources** : Folder for local robot keywords
- **tasks** : Folder containing actual robot tasks
- **tests** : Folder for robot tests
- **variables** : Folder for variable files

# Testing task
*Prerequisites:*
- Make sure you have Camunda Platform running at http://localhost:8080

## Prepare test cases
Run from root folder of this project:
```
robot -d logs -b debug.log tests/20_get_coffee_ingredients/prepare.robot
```
The test case will create a process instance per test case with individual parameters.

## Execute task
Run from root folder of this project:
```
robot -d logs -b debug.log tasks/20_get_coffee_ingredients/task.robot
```
The task processes all process instances.

## Validate test results
Run from root folder of this project:
```
robot -d logs -b debug.log tests/20_get_coffee_ingredients/validate.robot
```
This will check if all process instances have the expected variables and states, such as next task.

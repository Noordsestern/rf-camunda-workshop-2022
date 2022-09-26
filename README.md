# A fork of the Camunda Workshop at Robocon 2022

This is a fork of the actual workshop, serving mainly as demo and POC.
The actual workshop material can be found here: https://github.com/Nlea/Camunda-Robotframework-Workshop

# Setting up environment
You need Python 3 and install requirements from `requirements.txt` of this repository:
```
pip install -r requirements.txt
```

# Tasks execution

1. You need first to deploy the models from the models folder
1. You need to start a process instance for the process `coffee_brewing`
1. Find in tasks folder the 4 service tasks serving the process

## Start external task worker for Robot Framework#
From the directory of the `worker.py` start the worker. For instance:
```
cd tasks/10_define_coffee_type

python worker.py
```

The worker will pick up process instances automatically.

## Start pure Robot Framework task
Other tasks do not use an external task worker, but a keyword driven approach using CamundaLibrary for communicating with Camunda 7. Those robot tasks run on their own:

```
robot -d output_logs tasks/20_get_coffee_ingredients.robot
```

TEST_DATA=[
    {
        'testcase' : 'Succesfully find ingredients for Espresso',
        'process_key': 'coffee_brewing',
        'description' : 'Validate that ingredients for Espresso are retrieved',   
        'prepare': {
            'variables' : {
                'coffee_type': 'Espresso'
            },
            'activity_ids': ['robot_get_ingredients'],
        },
        'validate': {
            'variables' : {
                'ingredients' : ['1oz Espresso']
            },
            'activity_ids': ['robot_prepare_coffee'],
        }
    },
    {
        'testcase' : 'Succesfully find ingredients for Americano',
        'process_key': 'coffee_brewing',
        'description' : 'Validate that ingredients for Americano are retrieved',   
        'prepare': {
            'variables' : {
                'coffee_type': 'Americano'
            },
            'activity_ids': ['robot_get_ingredients'],
        },
        'validate': {
            'variables' : {
                'ingredients' : ['Espresso','Hot Water']
            },
            'activity_ids': ['robot_prepare_coffee'],
        }
    },
    {
        'testcase' : 'Fail to find ingredients for Nespresso',
        'process_key': 'coffee_brewing',
        'description' : 'Validate that ingredients for Americano are retrieved',   
        'prepare': {
            'variables' : {
                'coffee_type': 'Nespresso'
            },
            'activity_ids': ['robot_get_ingredients'],
        },
        'validate': {
            'variables' : {
            },
            'activity_ids': ['user_add_ingredients'],
        }
    }
]
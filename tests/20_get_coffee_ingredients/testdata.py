TEST_DATA=[
    {
        'testcase' : 'Espresso',
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
    }
]
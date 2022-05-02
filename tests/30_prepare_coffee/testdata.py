TEST_DATA=[
    {
        'testcase' : 'Succesfully prepare Espresso and share on social media',
        'process_key': 'coffee_brewing',
        'description' : 'Validate preparing Espresso does not throw exception',   
        'prepare': {
            'variables' : {
                'coffee_type': 'Espresso',
                'ingredients' : ['1oz Espresso'],
                'social_media': True
            },
            'activity_ids': ['robot_prepare_coffee'],
        },
        'validate': {
            'activity_ids': ['python_tweet_coffee'],
        }
    }
]
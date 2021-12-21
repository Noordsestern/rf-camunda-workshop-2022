from robot.api.deco import keyword, library
from typing import List, Dict

@library(scope='Global')
class CoffeeApi():

    @keyword(name="Identify coffee from recipes")
    def identify_recipe_for_coffee(self, coffee_type: str, recipes: List[Dict]):
        matching_recipe = [recipe for recipe in recipes if recipe.get('title')==coffee_type]
        if matching_recipe:
            return matching_recipe[0]
        return {}
from flask import jsonify
import random
from . import app

FRUIT = "apple banana strawberry pear".split()


@app.route("/fruit")
def get_fruit():
    """Return a randomly chosen fruit, in JSON format."""
    return jsonify(fruit=random.choice(FRUIT))

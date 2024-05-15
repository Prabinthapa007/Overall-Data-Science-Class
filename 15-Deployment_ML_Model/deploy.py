from FASTAPI import FastAPI
from helpers import get_save_file
import numpy as np

app = FastAPI()

LABELS = {
    'Iris-setosa': 0,
    'Iris-versicolor':1,
    'Iris-virginica':2
}
best_scaler = get_save_file("Best_model/standard_scaler.pkl")
best_model = get_save_file("best_model/reg_logistic_model.pkl")

def prediction(user_input):
    model_output = best_model.predict(
        best_scaler.transform(
            user_input
        )
    )
    return LABELS[model_output]

@app.post("/predict")
def web_prediction(user_input):
    user_input = np.array(eval[user_input])
    model_output = prediction(user_input)

    return{
        'status': 'sucess',
        'result': LABELS[model_output]
    }


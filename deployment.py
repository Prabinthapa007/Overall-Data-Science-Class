from helpers import get_save_file
import numpy as np

LABELS = {
    'Iris-setosa': 0,
    'Iris-versicolor':1,
    'Iris-virginica':2
}
best_scaler = get_save_file("Best_model/standard_scaler.pkl")
best_model = get_save_file("best_model/reg_logistic_model.pkl")

model_output = best_model.predict(
    best_scaler.transform(
        user_input
    )
)

if __name__ == "__main__":

    st.title("Hello Everyone !")

    sl = st.number_input("Enter Sepal Length")
    sw = st.number_input("Enter Sepal width")
    pl = st.number_input("Enter Petal Length")
    pw = st.number_input("Enter Petal Width")

    user_input = np.array([[sl, sw, pl, pw]])
    if st.button("Predict"):
        st.write(f"Given flower is of {predict(user_input)} type !\nThank you !")
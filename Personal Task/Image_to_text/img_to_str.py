import pytesseract as tess
tess.pytesseract.tesseract_cmd = r'C:\\Users\\Prabin\\Tesseract-OCR\\tesseract'
from PIL import Image

image = Image.open('image1.jpg')
text = tess.image_to_string(image)

print(text)
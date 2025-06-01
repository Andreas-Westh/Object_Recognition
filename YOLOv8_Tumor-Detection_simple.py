from ultralytics import YOLO
import matplotlib.pyplot as plt
import os
 
 # load model
model = YOLO("yolov8n-cls.pt")

# training
data = "Data/Brain-Tumor-simple/"
model.train(
    data = data,
    epochs=20,
    project="tumor_classification",
    name="yolov8n",
    pretrained=True
)

trained_model = YOLO("tumor_classification/yolov8n6/weights/best.pt")

image_test = "Data/Brain-Tumor-simple/val/tumor/image(6).jpg"
test = trained_model.predict(source=image_test)

probs = test[0].probs
class_id = probs.top1
class_name = test[0].names[class_id]
print(f"Predicted class: {class_name} ({probs.data[class_id]*100:.2f}% confidence)")


metrics = trained_model.val()

cm = metrics.confusion_matrix
print(cm.matrix)

from PIL import Image
import os, hashlib

def img_hash(path):
    return hashlib.md5(Image.open(path).convert("RGB").tobytes()).hexdigest()

folder1 = "Data/Brain-Tumor-simple/train/tumor"
folder2 = "Data/Brain-Tumor-simple/val/tumor"

hashes1 = {img_hash(os.path.join(folder1, f)) for f in os.listdir(folder1)}
hashes2 = {img_hash(os.path.join(folder2, f)) for f in os.listdir(folder2)}

dupes = hashes1 & hashes2
print(f"Found {len(dupes)} duplicate images.")

# 104 dupes found
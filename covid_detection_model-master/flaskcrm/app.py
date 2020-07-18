import os
from flask import Flask, jsonify, request
from flask_restful import Api, Resource
from tensorflow.keras.models import load_model
import numpy as np
import base64
import cv2
from keras.preprocessing.image import img_to_array
from tensorflow import keras
import tensorflow as tf

config = tf.ConfigProto(
    device_count={'GPU': 1},
    intra_op_parallelism_threads=1,
    allow_soft_placement=True
)

config.gpu_options.allow_growth = True
config.gpu_options.per_process_gpu_memory_fraction = 0.6

session = tf.Session(config=config)

keras.backend.set_session(session)

app = Flask(__name__)
api = Api(app)
model = load_model('C:\\inetpub\\wwwroot\\flaskcrm\\app200.model') 
@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        # check if the post request has the file part
        if '' in request.files:
            file = request.files[''].read() 
            npimg = np.fromstring(file, np.uint8)
            img = cv2.imdecode(npimg,cv2.IMREAD_COLOR)
            image = cv2.resize(img, (96, 96))
            image = image.astype("float") / 255.0
            image = img_to_array(image)
            image = np.expand_dims(image, axis=0)
            with session.as_default():
                with session.graph.as_default():
                    proba = model.predict(image)[0]
            #print(proba)
            label=[]
            final_prob=[]
            idx_max=np.argmax(proba)
            for i in range(4):
                idx = np.argmax(proba)
                if idx==0:
                    label.append('COVID 19')
    
                if idx==1:
                    label.append('No Findings')
                        
                if idx==2:
                    label.append('Pneumonia')
                        
                if idx==3:
                    label.append('Tuberculosis')
                final_prob.append(proba[idx])
                proba[idx]=-1
            final=''
            for i in range (4):
                final+=(str(label[i])+' : '+str(final_prob[i]*100)+'%'+'. ')
            #symp=''
            #symp+='Symptoms: '
            if idx_max==0:
                symp= 'Cough. Fever. Tiredness. Difficulty in breathing (severe cases)'
            elif idx_max==1:
                symp='None'
            elif idx_max==2:
                symp='Cough, which may produce greenish, yellow or even bloody mucus. Fever, sweating and shaking chills. Shortness of breath. Rapid, shallow breathing. Sharp or stabbing chest pain that gets worse when you breathe deeply or cough. Loss of appetite, low energy, and fatigue.'
            elif idx_max==3:
                symp='Coughing that lasts three or more weeks. Coughing up blood. Chest pain, or pain with breathing or coughing. Unintentional weight loss. Fatigue. Fever. Night sweats. Chills.'
            return jsonify({'1:':label[0],'2:':str(final_prob[0]*100),'3:':label[1],'4:':str(final_prob[1]*100),'5:':label[2],'6:':str(final_prob[2]*100),'7:':label[3],'8:':str(final_prob[3]*100),'Symptoms: ':symp})


mod = load_model('C:\\inetpub\\wwwroot\\flaskcrm\\app200ct.model')
#mod=load_model('app200ct.model')
@app.route('/predictct', methods=['POST'])
def predictct():
    if request.method == 'POST':
        # check if the post request has the file part
        if '' in request.files:
            file = request.files[''].read() 
            npimg = np.fromstring(file, np.uint8)
            img = cv2.imdecode(npimg,cv2.IMREAD_COLOR)
            image = cv2.resize(img, (224, 224))
            image = image.astype("float") / 255.0
            image = img_to_array(image)
            image = np.expand_dims(image, axis=0)
            with session.as_default():
                with session.graph.as_default():
                    classes = mod.predict(image)
                
            if float(classes[0][1])+0.3<float(classes[0][0]):
                final="COVID-19 +ve: "+str(classes[0][0])+". "+"NO FINDINGS: "+str(classes[0][1])
                pred1="COVID-19 +ve: "
                acc_1=str(classes[0][0]*100)
                pred2="NO FINDINGS: "
                acc_2=str(classes[0][1]*100)
            else:
                final="NO FINDINGS: "+str(classes[0][1])+". "+"COVID-19 +ve: "+str(classes[0][0])
                pred2="COVID-19 +ve: "
                acc_2=str(classes[0][0]*100)
                pred1="NO FINDINGS: "
                acc_1=str(classes[0][1]*100)
            return jsonify({'1:':pred1,'2:':acc_1,'3:':pred2,'4:':acc_2})

if __name__=='__main__':
    app.run(debug=False)
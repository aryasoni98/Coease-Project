import os
from flask import Flask, jsonify, request
from flask_restful import Api, Resource
from tensorflow.keras.models import load_model
from math import sqrt

app = Flask(__name__)
api = Api(app)

@app.route('/', methods=['POST'])
def home():
    return 'API Live'

model = load_model('app200.model') 
@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' in request.files:
            img = request.files.get('file')  
            proba = model.predict(img)[0]
            #print(proba)
            label=[]
            final_prob=[]
            idx_max=np.argmax(proba)
            for i in range(4):
                idx = np.argmax(proba)
                print(idx)
                if idx==0:
                    label.append('COVID 19')
    
                if idx==1:
                    label.append('No Findings')
                        
                if idx==2:
                    label.append('Pneumonia')
                        
                if idx==3:
                    label.append('Tuberculosis')
                final_prob.append(proba[idx])
                proba[idx]=0
            final=''
            for i in range (4):
                final+=(str(label[i])+' : '+str(final_prob[i]*100)+'%'+'\n')
            final+='Symptoms: '
            if idx_max==0:
                final+= 'cough \nfever\ntiredness\ndifficulty in breathing (severe cases)'
            elif idx_max==1:
                final+='None'
            elif idx_max==2:
                final+='Cough, which may produce greenish, yellow or even bloody mucus.\nFever, sweating and shaking chills.\nShortness of breath.\nRapid, shallow breathing.\nSharp or stabbing chest pain that gets worse when you breathe deeply or cough.\nLoss of appetite, low energy, and fatigue.'
            elif idx_max==3:
                final+='Coughing that lasts three or more weeks.\nCoughing up blood.\nChest pain, or pain with breathing or coughing.\nUnintentional weight loss.\nFatigue.\nFever.\nNight sweats.\nChills.'
            return jsonify({'Prediction:':final})
            #resp_data = {'name': name }
            #return json.dumps(resp_data)
            return jsonify({name})

modelct = load_model('app200ct.model') 
@app.route('/predictct', methods=['POST'])
def predictct():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' in request.files:
            img = request.files.get('file')                           
            classes = modelct.predict(img)
            if classes[0][0]<classes[0][1]:
                final="COVID-19 +ve: "+str(classes[0][1])+"\n"+"NO FINDINGS: "+str(classes[0][0])+'\nSymptoms: '+'cough \nfever\ntiredness\ndifficulty in breathing (severe cases)'
            else:
                final="NO FINDINGS: "+str(classes[0][0])+"\n"+"COVID-19 +ve: "+str(classes[0][1])+'\nSymptoms: '+'None'
            return jsonify({'Prediction:':final})
            #resp_data = {'name': name }
            #return json.dumps(resp_data)

@app.route('/geoloc')
def geoloc():
    while(1):
        try:
            if locations==None:
                locations=[]
        except:
            locations=[]
        minute = datetime.datetime.now().minute
        seconds = datetime.datetime.now().second
        if minute%10==0 and seconds==0:        
            ip_request = requests.get('https://get.geojs.io/v1/ip.json')
            my_ip = ip_request.json()['ip'] 
            geo_request_url = 'https://get.geojs.io/v1/ip/geo/' + my_ip + '.json'
            geo_request = requests.get(geo_request_url)
            geo_data = geo_request.json()
                    
            
            if geo_data!=None:
                longitude = geo_data['longitude']
                lat = geo_data['latitude']
                if len(locations)==0:
                    locations.append(longitude)
                    locations.append(longitude)
                    locations.append(lat)
                    locations.append(lat)
                    prev_lat=lat
                    prev_long=longitude
                if len(locations)==4:
                    locations[1]=longitude
                    locations[3]=lat
                    prev_lat=locations[2]
                    prev_long=locations[0]
                
                prev_lat=float(prev_lat)
                prev_long=float(prev_long)
                long=float(long)
                lat=float(lat)
                diff_lat=prev_lat-lat
                diff_long=prev_long-long
                diff_dist=sqrt(diff_lat*diff_lat+diff_long*diff_long)
                dist=diff_dist*111320
                if dist>300:
                    return jsonify({"GO HOME"})
                locations[0]=locations[1]
                locations[2]=locations[3]

if __name__ == '__main__':
    app.run(debug = False)

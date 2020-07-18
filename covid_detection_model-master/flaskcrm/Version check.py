# -*- coding: utf-8 -*-
"""
Created on Sun Apr 19 23:18:06 2020

@author: Administrator
"""
import os
from flask import Flask, jsonify, request
from flask_restful import Api, Resource
from tensorflow.keras.models import load_model
from math import sqrt
import numpy as np
import base64
import cv2
from keras.preprocessing.image import img_to_array
from tensorflow import keras
import tensorflow as tf
import flask

print(cv2.__version__)
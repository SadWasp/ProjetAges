from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import ItemSerializer
from .serializers import UserSerializer
from .serializers import OrderSerializer
from .serializers import Item_OrderSerializer
from .models import Item
from .models import User
from .models import Item_Order
from .models import Order
import pymongo
#import json
#from pymongo import MongoClient
import ssl
#import base64
#from OpenSSL import SSL

#from flask import Flask
#from flask.ext.bcrypt import Bcrypt

#from cryptography.fernet import Fernet
#import basehash

connection_string = "mongodb+srv://admin2:123@cluster0.khvrb.mongodb.net/ages?retryWrites=true&w=majority"
client = pymongo.MongoClient(connection_string, ssl_cert_reqs=ssl.CERT_NONE, connectTimeoutMS=30000, socketTimeoutMS=None, socketKeepAlive=True, connect=False, maxPoolsize=1)

db = client['ages']
items_collection = db["Items"]
users_collection = db["Users"]
orders_collection = db["Order"]
item_Orders_collection = db["Item_Order"]

client.close()
@api_view(['GET'])
def getRoutes(request):
    routes = [
        {
            'Endpoint': '/items',
            'method': 'GET',
            'body': None,
            'description': 'Returns an array of items'
        },
        {
            'Endpoint': '/items/id',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single item object'
        },
        {
            'Endpoint': '/items/create',
            'method': 'POST',
            'body': {'body': ""},
            'description': 'Creates a new item with data sent in post request'
        },
        {
            'Endpoint': '/items/update',
            'method': 'PUT',
            'body': {'body': ""},
            'description': 'Creates an existing item with data sent in put request'
        },
        {
            'Endpoint': '/items/delete',
            'method': 'DELETE',
            'body': None,
            'description': 'Deletes an existing item'
        },
        #######################   USERS   #####################################
        {
            'Endpoint': '/users',
            'method': 'GET',
            'body': None,
            'description': 'Returns an array of users'
        },
        {
            'Endpoint': '/users/id',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single user'
        },
        {
            'Endpoint': '/users/create',
            'method': 'POST',
            'body': {'body': ""},
            'description': 'Creates a new user with data sent in post request'
        },
        {
            'Endpoint': '/users/update',
            'method': 'PUT',
            'body': {'body': ""},
            'description': 'Creates an existing user with data sent in put request'
        },
        {
            'Endpoint': '/users/delete',
            'method': 'DELETE',
            'body': None,
            'description': 'Deletes an existing user'
        },
    ]
    return Response(routes)

@api_view(['GET'])
def getItems(request):
    items_ = items_collection.find()
    serializer = ItemSerializer(items_, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getItem(request, pk):
    item_ = items_collection.find_one({"id": pk})
    serializer = ItemSerializer(item_, many=False)
    return Response(serializer.data)

@api_view(['POST'])
def createItem(request):
    data = request.data



    item = Item.objects.create(
        name = data['name'],
        description = data['description'],
        location = data['location'],
        quantity = data['quantity'],
    )
    serializer = ItemSerializer(item, many=False)
    items_collection.insert_one(serializer.data).inserted_id
    return Response(serializer.data)

@api_view(['PUT'])
def updateItem(request, pk):
    reqdata = request.data
    item = items_collection.find_one({"id": pk})#change to Id
    for key in reqdata:
        if reqdata[key] != item[key]:
            change = {"$set": {key: reqdata[key]}}
            items_collection.update_one(item, change)

    changedItem = items_collection.find_one({"id": pk})
    serializer = ItemSerializer(changedItem, many=False)
    return Response(serializer.data)

@api_view(['DELETE'])
def deleteItem(request, pk):
    item = items_collection.find_one({"id": pk})
    items_collection.delete_one(item)
    return Response({"res": True, "message": "item deleted"})


@api_view(['GET'])
def getUsers(request):
    users = users_collection.find()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getUser(request, pk):
    user = users_collection.find_one({"id": pk})
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data)

#restrict to admins.
@api_view(['POST'])
def createUser(request):
    data = request.data
    user = User.objects.create(
        userName = data['userName'],
        password = data['password'], #encrypt password.
        role = data['role'], #lst of choices.
        nbOrdersFilled = data['nbOrdersFilled'],
    )
    serializer = UserSerializer(user, many=False)
    users_collection.insert_one(serializer.data).inserted_id
    return Response(serializer.data)

@api_view(['PUT'])
def updateUser(request, pk):
    reqdata = request.data
    user = users_collection.find_one({"id": pk})
    for key in reqdata:
        if reqdata[key] != user[key]:
            change = {"$set": {key: reqdata[key]}}
            users_collection.update_one(user, change)

    changedUser = users_collection.find_one({"id": pk})
    serializer = UserSerializer(changedUser, many=False)
    return Response(serializer.data)

@api_view(['DELETE'])
def deleteUser(request, pk):
    user = users_collection.find_one({"id": pk})
    users_collection.delete_one(user)
    return Response('User was deleted')



#try catch user not existing.
@api_view(['POST'])
def authLogin(request):
    data = request.data
    print("loging msg",request.data)
    if db['Users'].count_documents({ 'userName': data['userName'] }, limit = 1) != 0:


        user = users_collection.find_one({"userName": data['userName']})
        print("user msg", user)
    else:
        print("user not found")
        return Response(False)




    if user["password"] == data["password"]:
        print("update user", user)
        newUser = updateUserFunc("isConnected", True, user['id'])

        print("updated", user)
        #user = users_collection.find_one({"userName": data['userName']})


        serializer = UserSerializer(newUser, many=False)


        print("serializer", serializer)
        return Response(serializer.data)


    print("password not valid")
    return Response(False)


@api_view(['POST'])
def authLogout(request, pk):
    user = users_collection.find_one({"id": pk})
    updateUserFunc("isConnected", False, user['id'])
    return Response(True)



@api_view(['POST'])
def authReg(request):
    print("reg msg",request.data)
    data = request.data
    if db['Users'].count_documents({ 'userName': data['userName'] }, limit = 1) != 0:
        return Response(False)

    user = User.objects.create(
        userName = data['userName'],
        password = data['password'], #encrypt password.
        role = data['role'], #lst of choices.
        nbOrdersFilled = 0,
        isConnected = False,
    )
    serializer = UserSerializer(user, many=False)

    
    users_collection.insert_one(serializer.data).inserted_id
    return Response(serializer.data)

def updateUserFunc(row, value, pk):
    user = users_collection.find_one({"id": pk})
    if user[row] != value:
        change = {"$set": {row: value}}
        users_collection.update_one(user, change)

    changedUser = users_collection.find_one({"id": pk})
    return changedUser


def createOrder(request):
    data = request.data
    order = Order.objects.create(
        clientId = data['clientId'],
        price = data['price'],
        isFilled = data['isFilled'],
    )
    serializer = OrderSerializer(order, many=False)
    orders_collection.insert_one(serializer.data).inserted_id
    return Response(serializer.data)


def createItem_Order(request):
    data = request.data
    item_order = Item_Order.objects.create(
        orderId = data['orderId'],
        itemId = data['itemId'],
        quantity = data['quantity'],
        checked = data['checked'],
    )
    serializer = Item_OrderSerializer(item_order, many=False)
    item_Orders_collection.insert_one(serializer.data).inserted_id
    return Response(serializer.data)


def fetchOrder(orderPk):
    order = orders_collection.find_one({"id": orderPk})
    items = item_Orders_collection.find({"orderId": orderPk})

    return Response({'clientId': order['clientId'],'orders': items, 'price': order['price'], 'isFilled': order['isFilled']})

def checkItem(orderPk, itemId):
    item = items_collection.find_one({"id": itemId})
    order_item = item_Orders_collection.find({"orderId": orderPk})

    if item['quantity'] >= order_item['quantity']:
        change = {"$set": {'checked': True}}
        order_item.update_one(item, change)
        change = {"$set": {'quantity': item['quantity'] - order_item['quantity']}}
        items_collection.update_one(order_item, change)
        return Response("OK")

    return Response("quantities insufficient")


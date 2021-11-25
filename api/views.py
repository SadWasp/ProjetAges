from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import ItemSerializer
from .serializers import UserSerializer
from .serializers import LocationSerializer

from .serializers import OrdersSerializer
from .serializers import Clients_OrdersSerializer

from .models import Item
from .models import User
from .models import Location

from .models import Order
from .models import Client_Order
rowNum = [-1, 0, 0, 1]
colNum = [0, -1, 1, 0]

ROW = 17
COL = 21

from sys import maxsize
from itertools import permutations


manager = None
data = {}

import math


#from ortools.constraint_solver import routing_enums_pb2
#from ortools.constraint_solver import pywrapcp
from collections import deque
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
orders_collection = db["Orders"]
client_orders_collection = db["Client_Orders"]
location_collection = db["Locations"]

client.close()

mat = [
   # 0 1 2 3 4 5 6 7 8 9                       21
    [0,1,0,0,0,1,1,0,1,0,1,1,0,1,1,1,1,1,1,1,1,0],
    [0,1,0,0,0,0,1,0,1,0,1,1,0,1,1,1,1,1,1,1,1,1],
    [0,1,0,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,0,1,0],
    [0,1,0,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,0,1,0],
    [0,1,0,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,0,1,0],
    [0,1,0,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,0,1,0],
    [0,1,0,0,0,0,1,0,1,0,1,1,0,1,0,1,1,0,1,0,1,0],
    [0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0,1,0],
    [0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0,1,0],
    [0,1,1,1,0,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0,1,0],
    [0,1,1,1,0,1,1,0,1,0,1,0,1,1,0,1,1,0,1,0,1,0],
    [0,1,1,1,0,1,1,0,1,0,1,0,1,1,0,1,1,0,1,0,1,0],
    [0,1,1,1,1,1,1,0,1,0,1,0,1,1,0,1,1,0,1,0,1,0],
    [0,1,1,1,0,1,1,0,1,0,1,0,1,1,0,1,1,0,1,0,1,0],
    [0,1,1,1,0,1,1,0,1,0,1,0,1,1,0,1,1,0,1,0,1,0],
    [0,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [0,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] #17
    ]

class Point:
    def __init__(self,x: int, y: int):
        self.x = x
        self.y = y

class queueNode:
    def __init__(self,pt: Point, dist: int):
        self.pt = pt  # The coordinates of the cell
        self.dist = dist  # Cell's distance from the source

def isValid(row: int, col: int):
    return (row >= 0) and (row < ROW) and (col >= 0) and (col < COL)

def BFS(mat, src: Point, dest: Point):
    if mat[src.x][src.y]!=1 or mat[dest.x][dest.y]!=1:
        return -1

    visited = [[False for i in range(COL)]
                       for j in range(ROW)]

    visited[src.x][src.y] = True

    q = deque()

    s = queueNode(src,0)
    q.append(s)
    while q:
        curr = q.popleft()
        pt = curr.pt
        if pt.x == dest.x and pt.y == dest.y:
            return curr.dist

        for i in range(4):
            row = pt.x + rowNum[i]
            col = pt.y + colNum[i]

            if (isValid(row,col) and
               mat[row][col] == 1 and
                not visited[row][col]):
                visited[row][col] = True
                Adjcell = queueNode(Point(row,col),
                                    curr.dist+1)
                q.append(Adjcell)

    return -1

def createDistance_Matrix(points):
    distance_mat = []
    for p in points:
        dist = []
        for p2 in points:
            #dist.append(pythagoras(p,p2)) #BFS(map,p,p2)
            ans = BFS(mat,p,p2)
            dist.append(ans)
            #dist.append(BFS(mat,p,p2))
        distance_mat.append(dist)
    return distance_mat

def pythagoras(p1: Point, p2: Point):
    return math.sqrt(( (p2.x - p1.x)**2 + (p2.y - p1.y)**2 ))






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

@api_view(['GET'])
def getItemWithScan(request, pk):
    item_ = items_collection.find_one({"scan": pk})
    serializer = ItemSerializer(item_, many=False)
    return Response(serializer.data)

@api_view(['POST'])
def createItem(request):
    data = request.data



    item = Item.objects.create(
        name = data['name'],
        description = data['description'],
        scan = data['scan'],
        locationId = data['locationId'],
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


    orders = orders_collection.find({"itemId": pk})
    orders_collection.remove(orders)


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
    #valid = False
    print("reg msg",request.data)
    #json_acceptable_string = request.data.replace("'", "\"")
    data = request.data

    #data = request.data#mess with that

    #last = users_collection.find().sort("id", pymongo.ASCENDING)
   # newId = last
    #encPass = data['password'].encode("utf-8")
    if db['Users'].count_documents({ 'userName': data['userName'] }, limit = 1) != 0:
        return Response(False)

    user = User.objects.create(
        userName = data['userName'],
        password = data['password'], #encrypt password.
        role = data['role'], #lst of choices.
        nbOrdersFilled = 0,
        isConnected = True,
    )
    serializer = UserSerializer(user, many=False)

    # userdb = {
    #     "id": user.id,
    #     "userName": data['userName'],
    #     "password" : base64.b64encode(encPass),
    #     "role" : data['role'],
    #     "nbOrdersFilled" : 0,
    #     "isConnected" : False
    # }
    users_collection.insert_one(serializer.data).inserted_id
    return Response(serializer.data)

    #return Response("User created.")

def updateUserFunc(row, value, pk):
    user = users_collection.find_one({"id": pk})
    if user[row] != value:
        change = {"$set": {row: value}}
        users_collection.update_one(user, change)

    changedUser = users_collection.find_one({"id": pk})
    return changedUser





@api_view(['POST'])
def createOrder(request, pk):
    print("in function")
    data = request.data

    print("request:", request.data)

    client_order = Client_Order.objects.create(
        idClient = pk,
        status = "todo"

    )
    serializer = Clients_OrdersSerializer(client_order, many=False)
    client_orders_collection.insert_one(serializer.data).inserted_id









    for order in data['Order']:
        #order_id = client_order.id
        #print("here pls:", serializer.data['id'])

        item = items_collection.find_one({"id": order['itemId']})

        quant = item['quantity'] - order['quantity']

        #if(quant >= -10):

        change = {"$set": {"quantity": quant}}
        items_collection.update_one(item, change)


        order_1 = {
            "clientId" : pk,
            "itemId": order['itemId'],
            "orderId" : serializer.data['id'],
            "quantity": order['quantity'],
            "picked": False
        }
        orders_collection.insert_one(order_1)

    return Response(True)

@api_view(['DELETE'])
def deleteOrder(request, pk):
    order = client_orders_collection.find_one({"id": pk})

    ordersToDelete = orders_collection.find({'orderId': pk, 'clientId': order['idClient']})
    for o in ordersToDelete:
        item = items_collection.find_one({"id": o['itemId']})
        quant = item['quantity'] + o['quantity']
        change = {"$set": {"quantity": quant}}
        items_collection.update_one(item, change)
        orders_collection.delete_one(o)


    client_orders_collection.delete_one(order)


    return Response({"res": True, "message": "order deleted"})


@api_view(['GET'])
def getAllOrdersFrom(request, pk):
    ordersLst = client_orders_collection.find({'idClient': pk})
    lst = []

    for client_order in ordersLst:
        orders_ = orders_collection.find({'orderId': client_order['id']})
        olst = []
        for o in orders_:
            olst.append({"itemId" : o['itemId'], "quantity": o['quantity'] })

        lst.append({"orderId": client_order['id'], "Status":  client_order['status'],"Orders": olst})

    return Response(lst)

@api_view(['GET'])
def getAllOrders(request):

    ordersLst = client_orders_collection.find()
    lst = []

    for client_order in ordersLst:
        orders_ = orders_collection.find({'orderId': client_order['id']})
        olst = []
        for o in orders_:
            olst.append({"itemId" : o['itemId'], "quantity": o['quantity'] })

        lst.append({"orderId": client_order['id'], "Status":  client_order['status'], "Orders": olst})

    return Response(lst)



@api_view(['DELETE'])
def deleteItemInOrder(request, orderId, itemId):
    order = orders_collection.find({'orderId': orderId, 'itemId': itemId})
    orders_collection.delete_one(order)
    return Response({"res": True, "message": "item in order deleted"})

#@api_view(['POST'])
#def addItemInOrder(request, orderId):




@api_view(['PUT'])
def updateOrder(request, orderId):
    order = client_orders_collection.find({'id': orderId})
    change = {"$set": {"status": "todo"}}
    if(order['status'] == "todo"):
        change = {"$set": {"status": "En cours"}}
    if(order['status'] == "En cours"):
        change = {"$set": {"status": "Done"}}
    client_orders_collection.update_one(order, change)

    return Response(True)


@api_view(['GET'])
def getLocationById(request, pk):
    locations = location_collection.find({'id': pk})
    serializer = LocationSerializer(locations, many=True)
    return Response(serializer.data)



@api_view(['GET'])
def getLocations(request):
    locations = location_collection.find()
    serializer = LocationSerializer(locations, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def createLocation(request):
    data = request.data
    loc = Location.objects.create(
        location = data['location']
    )
    serializer = LocationSerializer(loc, many=False)
    location_collection.insert_one(serializer.data).inserted_id
    return Response(serializer.data)

@api_view(['GET'])
def getItemsAtLocation(request, pk): #pk : locationID
    items = items_collection.find({'locationId': pk})
    serializer = ItemSerializer(items, many=True)
    return Response(serializer.data)

@api_view(['PUT'])
def pickedItem(request, orderId, itemId):
    item = orders_collection.find_one({'orderId': orderId,'itemId': itemId })

    change = {"$set": {"picked": True}}
    orders_collection.update_one(item, change)

    return Response(True)




@api_view(['GET'])
def getOrdersInOrder(request, pk):



    orders_ = orders_collection.find({'orderId': pk})
    lst = []
    for o in orders_:
        item = items_collection.find_one({'id': o['itemId']})
        #print("test",item['id'])
        location = location_collection.find_one({'id': item['locationId']})
        lst.append({"itemId" : o['itemId'],"name":item['name'] , "quantity": o['quantity'], "x": location['x'], "y": location['y'], "zone": location['zone'] + 1, "picked": o['picked']})


        for l in lst:
            print("item order", l['itemId'])
    #return Response(lst)

    return Response(proxyOrder(lst))




def proxyOrder(lst):
    #nbItems = len(lst)
    ans = []

    points = [Point(11,1)]
    for l in lst:
        points.append(Point(l['x'],l['y']))

    print("len",len(points))

    for p in points:
        print(p.x,p.y)


    graph = createDistance_Matrix(points)
    #graph.pop(0)






    ord = TSP(graph, 0, len(points))[:-1]
    ord.pop(0)

    for idx, val in enumerate(ord):
        print(val-1)



    for idx, val in enumerate(ord):
        ans.append(lst[val-1])
        print(lst[val-1])

    return ans




def TSP(graph, s, nbItems):
    # store all vertex apart from source vertex
    vertex = []
    for i in range(nbItems):
        if i != s:
            vertex.append(i)

    # store minimum weight Hamiltonian Cycle
    min_path = maxsize
    next_permutation=permutations(vertex)
    best_path = []
    for i in next_permutation:

        # store current Path weight(cost)
        current_pathweight = 0

        # compute current path weight
        k = s
        for j in i:
            current_pathweight += graph[k][j]
            k = j
        current_pathweight += graph[k][s]

        # update minimum
        if current_pathweight < min_path:
            min_path = current_pathweight
            best_path = [s]
            best_path.extend(list(i))
            best_path.append(s)

    return best_path

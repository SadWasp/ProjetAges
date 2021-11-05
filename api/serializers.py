from rest_framework.serializers import ModelSerializer
from .models import Item
from .models import User
from .models import Order
from .models import Client_Order
from .models import Location

class ItemSerializer(ModelSerializer):
    class Meta:
        model = Item
        fields = '__all__'

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class OrdersSerializer(ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'

class Clients_OrdersSerializer(ModelSerializer):
    class Meta:
        model = Client_Order
        fields = '__all__'

class LocationSerializer(ModelSerializer):
    class Meta:
        model = Location
        fields = '__all__'

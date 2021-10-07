from rest_framework.serializers import ModelSerializer
from .models import Item
from .models import Order
from .models import Item_Order
from .models import User

class ItemSerializer(ModelSerializer):
    class Meta:
        model = Item
        fields = '__all__'

class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class OrderSerializer(ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'

class Item_OrderSerializer(ModelSerializer):
    class Meta:
        model = Item_Order
        fields = '__all__'


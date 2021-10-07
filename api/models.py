from django.db import models

class Item(models.Model):
    name = models.TextField()
    location = models.TextField()
    quantity = models.IntegerField()
    #add price.


    def __str__(self):
        return self.name

    class Meta:
        ordering = ['quantity']

class User(models.Model):
    userName = models.TextField()
    password = models.TextField()

    role = models.TextField()
    nbOrdersFilled = models.IntegerField()
    isConnected = models.BooleanField()

    def __str__(self):
        return self.userName

    class Meta:
        ordering = ['role']

class Order(models.Model):
    clientId = models.IntegerField()
    price = models.FloatField()
    isFilled = models.BooleanField()

    def __str__(self):
        return self.clientId

    class Meta:
        ordering = ['isFilled']

class Item_Order(models.Model):
    orderId = models.IntegerField()
    itemId = models.IntegerField()
    quantity = models.IntegerField()
    checked = models.BooleanField()

    def __str__(self):
        return self.orderId

    class Meta:
        ordering = ['orderId']
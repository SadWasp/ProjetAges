from django.db import models

class Item(models.Model):
    name = models.TextField()
    description = models.TextField()
    scan = models.TextField()
    locationId = models.IntegerField()
    quantity = models.IntegerField()

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
    idClient = models.IntegerField()
    idItem  = models.IntegerField()
    idOrder  = models.IntegerField()
    quantity  = models.IntegerField()

    def __str__(self):
        return self.idOrder

    class Meta:
        ordering = ['idOrder']

class Client_Order(models.Model):
    idClient = models.IntegerField()
    status = models.TextField()

    def __str__(self):
        return self.idClient

    class Meta:
        ordering = ['idClient']


class Location(models.Model):
    location = models.TextField()

    def __str__(self):
        return self.location

    class Meta:
        ordering = ['location']

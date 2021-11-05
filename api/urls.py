from django.urls import path
from . import views

urlpatterns = [
    path('', views.getRoutes),
    path('items/', views.getItems),
    path('items/create/', views.createItem),
    path('items/<int:pk>/update/', views.updateItem),
    path('items/<int:pk>/delete/', views.deleteItem),
    path('items/<int:pk>/', views.getItem),
    path('items/<int:pk>/', views.getItemWithScan),

    path('users/', views.getUsers),
    path('users/create/', views.createUser),
    path('users/<int:pk>/update/', views.updateUser),
    path('users/<int:pk>/delete/', views.deleteUser),
    path('users/<int:pk>/', views.getUser),

    path('auth/login', views.authLogin),
    path('auth/<int:pk>/logout', views.authLogout),
    path('auth/register', views.authReg),


    path('orders/<int:pk>/', views.getAllOrdersFrom),
    path('orders/', views.getAllOrders),


    #whole order:
    path('orders/<int:pk>/create/', views.createOrder),

    path('orders/<int:pk>/delete/', views.deleteOrder),


    #items in order:
    path('orders/<int:orderId>/<int:itemId>/delete/', views.deleteItemInOrder),
    path('orders/<int:orderId>/update/', views.updateOrder),

    #path('orders/<int:orderId>/addItem/', views.addItemInOrder),
    #path('orders/<int:orderId>/<int:itemId>/modify/', views.modifyItemInOrder),

    path('locations/', views.getLocations),
    path('locations/create/', views.createLocation),
    path('locations/<int:pk>/getItems/', views.getItemsAtLocation),

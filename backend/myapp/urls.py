from django.urls import path
from . import views
from rest_framework_simplejwt.views import TokenRefreshView


urlpatterns = [
    path('signup/', views.signup, name='signup'),
    path('verify-email/<uuid:token>/', views.verify_email, name='verify-email'),
    path('verify-email-app/<uuid:token>/', views.verify_email_app, name='verify-email-appp'),
    path('login/', views.custom_login, name='custom-login'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    path('forgot-password/', views.forgot_password, name='forgot-password'),  # POST email
    path('reset-password/<int:user_id>/<str:token>/', views.reset_password_page, name='reset-password-page'),  # GET page link
    path("check-reset-verification/<int:user_id>/<str:token>/", views.check_reset_verification, name="check_reset_verification"),
    path('reset-password/<int:user_id>/<str:token>/submit/', views.reset_password, name='reset-password-submit'),  # POST new password

    path('products/', views.get_products),
    path('products/<int:pk>/', views.get_product), #searching a product
    path('categories/', views.get_categories),

    path('my-products/', views.my_products),
    path('products/create/', views.create_product),
    path('products/update/<int:pk>/', views.update_product),
    path('products/delete/<int:pk>/', views.delete_product),

    path('profile/', views.get_profile),
    path('profile/update/', views.update_profile),
    path("users/<int:user_id>/", views.get_user_profile, name="get_user_profile"),

    path('products/<int:product_id>/favourite/', views.toggle_favourite),
    path('favourites/', views.my_favourites),
]
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status


from .models import Product, Category, UserProfile, ProductImage, Favourite
from .serializers import SignupSerializer,CustomLoginSerializer,ProductSerializer, CategorySerializer, UserProfileSerializer
from .utils import send_verification_email, send_password_reset_email
from django.shortcuts import get_object_or_404, render
from rest_framework.permissions import AllowAny
from django.contrib.auth.models import User
from django.contrib.auth.tokens import PasswordResetTokenGenerator

token_gen = PasswordResetTokenGenerator()



@api_view(['POST'])
@permission_classes([AllowAny])
def signup(request):
    serializer = SignupSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.save()
        send_verification_email(user)

        token = str(user.userprofile.verification_token)
        return Response({
            "message": "User created. Check your email for verification link.",
            "verification_token": token
        }, status=status.HTTP_201_CREATED)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([AllowAny])
def verify_email(request, token):
    profile = get_object_or_404(UserProfile, verification_token=token)
    profile.is_verified = True
    profile.user.is_active = True
    profile.user.save()
    profile.save()
    context = {
        'success': True,
        'message': 'Email verified! You can now log in.'
    }
    return render(request, 'verification_result.html', context)

@api_view(['GET'])
@permission_classes([AllowAny])
def verify_email_app(request, token):
    profile = get_object_or_404(UserProfile, verification_token=token)

    if profile.is_verified:
        return Response({
            "success": True,
            "message": "Email already verified"
        })

    profile.is_verified = True
    profile.user.is_active = True
    profile.user.save()
    profile.save()

    return Response({
        "success": True,
        "message": "Email verified successfully"
    })

@api_view(['POST'])
@permission_classes([AllowAny])
def custom_login(request):
    serializer = CustomLoginSerializer(data=request.data)
    serializer.is_valid(raise_exception=True)
    user = serializer.validated_data['user']

    # Generate JWT token
    refresh = RefreshToken.for_user(user)
    return Response({
        'refresh': str(refresh),
        'access': str(refresh.access_token),
        'username': user.username,
        'email': user.email,
    })

@api_view(['POST'])
@permission_classes([AllowAny])
def forgot_password(request):
    email = request.data.get("email")
    if not email:
        return Response({"error": "Email is required"}, status=400)

    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return Response({"error": "Email not found"}, status=404)

    token = token_gen.make_token(user)
    send_password_reset_email(user, token)

    # Return id and token so Flutter can use
    return Response({
        "message": "Check your email for the password reset link.",
        "user_id": user.id,
        "token": token
    }, status=200)


@api_view(['GET'])
@permission_classes([AllowAny])
def reset_password_page(request, user_id, token):

    user = get_object_or_404(User, pk=user_id)
    token_valid = token_gen.check_token(user, token)

    context = {
        "valid": token_valid
    }

    return render(request, "reset_password_result.html", context)

@api_view(['GET'])
@permission_classes([AllowAny])
def check_reset_verification(request, user_id, token):

    user = get_object_or_404(User, pk=user_id)
    token_valid = token_gen.check_token(user, token)

    return Response({
        "success": token_valid
    })


@api_view(['POST'])
@permission_classes([AllowAny])
def reset_password(request, user_id, token):
    user = get_object_or_404(User, pk=user_id)

    if not token_gen.check_token(user, token):
        return Response({"error": "Invalid or expired token"}, status=400)

    new_password = request.data.get("password")
    if not new_password:
        return Response({"error": "Password is required"}, status=400)

    user.set_password(new_password)
    user.save()

    return Response({"message": "Password updated successfully!"}, status=200)

@api_view(['GET'])
def get_products(request):
    category = request.GET.get('category')
    sort = request.GET.get('sort', 'oldest')  # default to oldest first

    products = Product.objects.all()

    # filter by category
    if category is not None:
        products = products.filter(category_id=int(category))

     # Sort products
    if sort == 'newest':
        products = products.order_by('-created_at')
    elif sort == 'oldest':
        products = products.order_by('created_at')
    elif sort == 'price_asc':
        products = products.order_by('price')
    elif sort == 'price_desc':
        products = products.order_by('-price')
        
    serializer = ProductSerializer(products, many=True)
    return Response(serializer.data)


@api_view(['GET'])
def get_product(request, pk):

    try:
        product = Product.objects.get(id=pk)
    except Product.DoesNotExist:
        return Response({"error": "Product not found"}, status=status.HTTP_404_NOT_FOUND)

    serializer = ProductSerializer(product)

    return Response(serializer.data)

@api_view(['GET'])
def my_products(request):
    products = Product.objects.filter(seller=request.user)
    serializer = ProductSerializer(products, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def create_product(request):
    serializer = ProductSerializer(data=request.data)
    if serializer.is_valid():
        product = serializer.save(seller=request.user)

        images = request.FILES.getlist('images')
        for img in images:
            ProductImage.objects.create(product=product, image=img)

        # Return success with created product data
        return Response({
            "success": True,
            "message": "Product created successfully!",
            "product": ProductSerializer(product).data
        }, status=status.HTTP_201_CREATED)

    return Response({
        "success": False,
        "message": "Product creation failed",
        "errors": serializer.errors
    }, status=status.HTTP_400_BAD_REQUEST)


@api_view(['PUT'])
def update_product(request, pk):
    try:
        product = Product.objects.get(id=pk)
    except Product.DoesNotExist:
        return Response({"error": "Product not found"}, status=status.HTTP_404_NOT_FOUND)
    
    if product.seller != request.user:
        return Response(
            {"error": "You don't have permission to edit this product"}, 
            status=status.HTTP_403_FORBIDDEN
        )
    
    serializer = ProductSerializer(product, data=request.data, partial=False)
    if serializer.is_valid():
        serializer.save(seller=product.seller)
        return Response(serializer.data, status=status.HTTP_200_OK)

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['DELETE'])
def delete_product(request, pk):

    try:
        product = Product.objects.get(id=pk)
    except Product.DoesNotExist:
        return Response({"error": "Product not found"}, status=status.HTTP_404_NOT_FOUND)

    if product.seller != request.user:
        return Response(
            {"error": "You don't have permission to edit this product"}, 
            status=status.HTTP_403_FORBIDDEN
        )
    product.delete()

    return Response({"message": "Product deleted"})


@api_view(['GET'])
@permission_classes([AllowAny])
def get_categories(request):

    categories = Category.objects.all()

    serializer = CategorySerializer(categories, many=True)

    return Response(serializer.data)


@api_view(['GET'])
def get_profile(request):

    profile = request.user.userprofile
    serializer = UserProfileSerializer(profile)

    return Response(serializer.data)


@api_view(['PUT'])
def update_profile(request):

    profile = request.user.userprofile

    serializer = UserProfileSerializer(
        profile,
        data=request.data,
        partial=True
    )

    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def get_user_profile(request, user_id):
    try:
        user = User.objects.get(id=user_id)
        profile = UserProfile.objects.get(user=user)
    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
    except UserProfile.DoesNotExist:
        return Response({"error": "Profile not found"}, status=status.HTTP_404_NOT_FOUND)

    serializer = UserProfileSerializer(profile)
    return Response(serializer.data)


@api_view(["POST"])
def toggle_favourite(request, product_id):

    product = Product.objects.get(id=product_id)

    fav, created = Favourite.objects.get_or_create(
        user=request.user,
        product=product
    )

    if not created:
        fav.delete()
        return Response({"favourited": False})

    return Response({"favourited": True})

@api_view(["GET"])
def my_favourites(request):

    favs = Favourite.objects.filter(user=request.user)

    products = [f.product for f in favs]

    serializer = ProductSerializer(products, many=True)

    return Response(serializer.data)
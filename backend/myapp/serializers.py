#serializer converts database object 
# like tables to api json data

from rest_framework import serializers
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib.auth.password_validation import validate_password
from .models import Product,Category,UserProfile,ProductImage,Favourite

class SignupSerializer(serializers.ModelSerializer):

    whatsapp = serializers.CharField(required=False, allow_blank=True)
    telegram = serializers.CharField(required=False, allow_blank=True)
    facebook = serializers.CharField(required=False, allow_blank=True)

    class Meta:
        model = User
        fields = [
            "username",
            "email",
            "password",
            "whatsapp",
            "telegram",
            "facebook",
        ]

    def create(self, validated_data):

        whatsapp = validated_data.pop("whatsapp", None)
        telegram = validated_data.pop("telegram", None)
        facebook = validated_data.pop("facebook", None)

        user = User.objects.create_user(**validated_data)
        user.is_active = False
        user.save()

        UserProfile.objects.create(
            user=user,
            whatsapp=whatsapp,
            telegram=telegram,
            facebook=facebook
        )

        return user

class CustomLoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        email = data.get('email')
        password = data.get('password')

        # Check if user exists
        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            raise serializers.ValidationError("User with this email does not exist.")

        # Check password
        user = authenticate(username=user.username, password=password)
        if not user:
            raise serializers.ValidationError("Incorrect credentials.")

        # Check if email is verified
        if not user.userprofile.is_verified:
            raise serializers.ValidationError("Email not verified. Please verify your email first.")

        data['user'] = user
        return data

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ["id", "name", "slug"]


class ProductImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = ProductImage
        fields = ["id", "image"]


class ProductSerializer(serializers.ModelSerializer):

    images = ProductImageSerializer(many=True, read_only=True)

    class Meta:
        model = Product
        fields = [
            "id",
            "seller",
            "category",
            "title",
            "description",
            "price",
            "location",
            "images",
            "created_at"
        ]
        read_only_fields = ["seller", "id", "created_at"]


class UserProfileSerializer(serializers.ModelSerializer):
    username = serializers.CharField(source="user.username", read_only=True)
    email = serializers.EmailField(source="user.email", read_only=True)

    class Meta:
        model = UserProfile
        fields = [
            "id",
            "username",
            "email",
            "whatsapp",
            "telegram",
            "facebook",
            "is_verified"
        ]

    def validate(self, data):
        if not data.get("whatsapp") and not data.get("telegram") and not data.get("facebook"):
            raise serializers.ValidationError(
                "At least one contact method is required."
            )
        return data
    

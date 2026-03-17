#here python class -> converted to db tables

from django.db import models
from django.contrib.auth.models import User
import uuid
from cloudinary.models import CloudinaryField


class UserProfile(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE
    )

    whatsapp = models.URLField(unique=True,blank=True, null=True)
    telegram = models.URLField(unique=True,blank=True, null=True)
    facebook = models.URLField(unique=True,blank=True, null=True)

    is_verified = models.BooleanField(default=False)
    verification_token = models.UUIDField(default=uuid.uuid4, editable=False)

    def __str__(self):
        return self.user.username


class Category(models.Model):
    name = models.CharField(max_length=100)
    slug = models.SlugField(unique=True)

    def __str__(self):
        return self.name
    

class Product(models.Model):
    seller = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name="products", #geting products from seller without query
    
    )

    category = models.ForeignKey(
        Category,
        on_delete=models.CASCADE,
       
    )

    title = models.CharField(max_length=200)

    description = models.TextField()

    price = models.DecimalField(
        max_digits=10,
        decimal_places=2
    )

    location = models.CharField(max_length=150,)

    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    
    def __str__(self):
        return self.title
    

class ProductImage(models.Model):
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name="images"
    )

    image = CloudinaryField('image')

    def __str__(self):
        return f"Image for {self.product.title}"
    

class Favourite(models.Model):
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name="favourites"
    )

    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name="favourited_by"
    )

    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ["user", "product"]

    def __str__(self):
        return f"{self.user.username} ❤️ {self.product.title}"
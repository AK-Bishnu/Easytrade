from django.contrib import admin
from .models import Product, Category, ProductImage, UserProfile

# Inline to handle multiple images in the same product page
class ProductImageInline(admin.TabularInline):
    model = ProductImage
    extra = 1  # how many empty image slots show by default

# Register Product with inline images
class ProductAdmin(admin.ModelAdmin):
    inlines = [ProductImageInline]

# Register models
admin.site.register(Product, ProductAdmin)
admin.site.register(Category)
admin.site.register(UserProfile)
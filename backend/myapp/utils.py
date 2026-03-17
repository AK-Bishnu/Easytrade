# myapp/utils.py

from django.core.mail import send_mail
from django.conf import settings

def send_verification_email(user):
    profile = user.userprofile
    token = profile.verification_token
    link = f"http://127.0.0.1:8000/api/verify-email/{token}/"
    
    subject = "Verify your EasyTrade account"
    message = f"Hi {user.username},\n\nPlease verify your email by clicking this link:\n{link}\n\nThanks!"
    
    send_mail(

        subject,
        message,
        settings.DEFAULT_FROM_EMAIL,
        [user.email],
        fail_silently=False
    )


def send_password_reset_email(user, token):
    
    reset_link = f"http://127.0.0.1:8000/api/reset-password/{user.pk}/{token}/"  
    subject = "Reset Your Password"
    message = f"Hi {user.username},\n\nClick the link below to reset your password:\n{reset_link}\n\nIf you didn't request this, ignore this email."
    send_mail(
        subject,
        message,
        "noreply@easytrade.com",
        [user.email],
    )
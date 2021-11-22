from .models import Cart , CartItem
from .views import _cart_id

def counter(request):
    cart_count=0

    if 'admin' in request.path:
        return {}
    else:
        try:
            print("counter working..0")
            cart=Cart.objects.filter(cart_id=_cart_id(request))
            print("counter working..1")
            cart_items=CartItem.objects.all().filter(cart_id=cart[:1])
            print("counter working..2")
            for cart_item in cart_items:
                cart_count+=cart_item.quantity
        except Cart.DoesNotExist:
            cart_item=0
    return dict(cart_count=cart_count) 

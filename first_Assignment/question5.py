# services.py
def calculate_discount(price, discount_percentage):
    """Calculates the discount amount."""
    return price * (discount_percentage / 100)

def final_price(price, discount_percentage):
    """Calculates the final price after discount."""
    discount = calculate_discount(price, discount_percentage)
    return price - discount


# test_services.py
import unittest

class TestCalculateDiscount(unittest.TestCase):
    def test_calculate_discount(self):
        self.assertEqual(calculate_discount(100, 10), 10)  # 10% of 100 is 10
        self.assertEqual(calculate_discount(200, 15), 30)  # 15% of 200 is 30
        self.assertEqual(calculate_discount(0, 50), 0)     # Edge case: price is 0
        self.assertEqual(calculate_discount(500, 0), 0)    # Edge case: discount is 0
        self.assertAlmostEqual(calculate_discount(99.99, 10), 9.999)  # Precision test

class TestFinalPriceIntegration(unittest.TestCase):
    def test_final_price(self):
        self.assertEqual(final_price(100, 10), 90)         # Final price after 10% discount
        self.assertEqual(final_price(200, 15), 170)       # Final price after 15% discount
        self.assertEqual(final_price(0, 50), 0)           # Edge case: price is 0
        self.assertEqual(final_price(500, 0), 500)        # Edge case: discount is 0
        self.assertAlmostEqual(final_price(99.99, 10), 89.991)  # Precision test

unittest.main()

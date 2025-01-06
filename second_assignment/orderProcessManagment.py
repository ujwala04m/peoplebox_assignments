class OrderService:
    def __init__(self):
        # In-memory stock data: item_name -> (price, quantity)
        self.stock = {
            "smart watch": {"price": 199.99, "quantity": 20},
            "phone": {"price": 699.99, "quantity": 15},
            "laptop": {"price": 999.99, "quantity": 10},
            "camera": {"price": 499.99, "quantity": 12},
        }

    def validateOrder(self, order):
        """Validates item availability and requested quantities."""
        for item, quantity in order.items():
            if item not in self.stock:
                raise ValueError(f"Item '{item}' is not in stock.")
            if quantity > self.stock[item]["quantity"]:
                raise ValueError(f"Requested quantity for '{item}' exceeds available stock.")

    def calculateTotal(self, order):
        """Calculates total price including tax and discounts."""
        total_price = 0.0
        for item, quantity in order.items():
            total_price += self.stock[item]["price"] * quantity

        # Apply tax (10%)
        tax = total_price * 0.10
        total_price += tax

        # Apply discount (5% for orders above $100)
        discount = 0.0
        if total_price > 100:
            discount = total_price * 0.05
            total_price -= discount

        return total_price, tax, discount

    def processOrder(self, order):
        """Combines validation, calculation, updates stock, and generates a receipt."""
        try:
            # Step 1: Validate order
            self.validateOrder(order)

            # Step 2: Calculate total price, tax, and discount
            total_price, tax, discount = self.calculateTotal(order)

            # Step 3: Update stock based on order quantities
            for item, quantity in order.items():
                self.stock[item]["quantity"] -= quantity

            # Step 4: Generate and return receipt
            return self.generateReceipt(order, total_price, tax, discount)

        except ValueError as e:
            # Handle validation errors gracefully
            return f"Error processing order: {e}"

    def generateReceipt(self, order, total_price, tax, discount):
        """Generates and returns a receipt string."""
        receipt_lines = ["Order Receipt:"]
        receipt_lines.append("Item          Quantity    Price")
        receipt_lines.append("--------------------------------")
        for item, quantity in order.items():
            price = self.stock[item]["price"] * quantity
            receipt_lines.append(f"{item:<12}{quantity:<12}${price:.2f}")

        receipt_lines.append("--------------------------------")
        receipt_lines.append(f"Tax: ${tax:.2f}")
        receipt_lines.append(f"Discount: -${discount:.2f}")
        receipt_lines.append(f"Total: ${total_price:.2f}")
        return "\n".join(receipt_lines)

    def displayStock(self):
        """Displays the current stock details."""
        print("Available items:")
        for item, details in self.stock.items():
            print(f"- {item} (Price: ${details['price']}, Stock: {details['quantity']})")

# Instantiate the service
service = OrderService()

while True:
    # Display stock before each order
    service.displayStock()

    print("\nEnter your order (item name and quantity, one per line). Type 'done' when finished.")
    order = {}
    while True:
        user_input = input("Item and quantity: ").strip()
        if user_input.lower() == "done":
            break
        try:
            item, quantity = user_input.rsplit(" ", 1)
            quantity = int(quantity)
            if item in service.stock:
                order[item] = order.get(item, 0) + quantity
            else:
                print(f"Item '{item}' is not available.")
        except ValueError:
            print("Invalid input. Please enter in the format 'item_name quantity'.")

    # Process the order
    if order:
        receipt = service.processOrder(order)
        print(receipt)
    else:
        print("No items ordered.")

    # Ask if the user wants to place another order
    continue_ordering = input("\nDo you want to place another order? (yes/no): ").strip().lower()
    if continue_ordering != "yes":
        break

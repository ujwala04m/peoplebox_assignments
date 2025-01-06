# Function to calculate the product of two numbers and then add the second number to the result
def calculateProductAndAdd(number1, number2):
    product = number1 * number2  # Product of the two numbers
    result = product + number2  # Add the second number to the product
    return result

# Function to calculate the sum of two numbers and the result of the product-and-add calculation
def calculateSumAndProduct(number1, number2):
    sumOfNumbers = number1 + number2  # Calculate the sum of the two numbers
    productAndAddResult = calculateProductAndAdd(number1, number2)  # Call the product-and-add function
    return sumOfNumbers, productAndAddResult


number1 = 5
number2 = 3

# Call the function and print the results
sumOfNumbers, productAndAddResult = calculateSumAndProduct(number1, number2)
print(f"The sum of {number1} and {number2} is: {sumOfNumbers}")
print(f"The product of {number1} and {number2}, plus {number2}, is: {productAndAddResult}")


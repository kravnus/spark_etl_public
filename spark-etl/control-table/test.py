# Define sample variables
user_name = "Alice"
item_count = 3
price_per_unit = 15.756

def dynamic_string(name):
    print (f"hi there {name}")
    
# 1. Modern F-Strings (Recommended)
# Directly embed variables inside curly braces
message_f = f"Hello {user_name}, you bought {item_count} items."
print(message_f)

# 2. F-String with Number Formatting
# Use ':.2f' to round a floating-point number to 2 decimal places
total_cost = item_count * price_per_unit
cost_message = f"Your total is ${total_cost:.2f} dollars."
print(cost_message)

# 3. The str.format() Method (Alternative)
# Uses curly braces as placeholders filled by the .format() arguments
message_format = "Hello {}, your total is ${:.2f}.".format(user_name, total_cost)
print(message_format)

dynamic_string("Lucy")


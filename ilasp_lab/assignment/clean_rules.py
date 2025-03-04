import re

def is_redundant_or_inconsistent(rule):
    conditions = re.findall(r'V[234]\s*([<>]=?)\s*(-?\d+)', rule)
    if not conditions:
        return False
    
    values = {}
    for op, val in conditions:
        val = int(val)
        if op in ('>=', '>'):
            if '<=' in values and val > values['<=']:
                return True  # Contradiction (e.g., V2 >= 5 and V2 <= 4)
            values[op] = max(values.get(op, val), val)
        elif op in ('<=', '<'):
            if '>=' in values and val < values['>=']:
                return True  # Contradiction
            values[op] = min(values.get(op, val), val)
    
    # Redundancy check
    if '>=' in values and '<=' in values and values['>='] == values['<=']:
        return True  # Rule is equivalent to V2, V3, or V4 = constant, often redundant
    
    return False

def remove_duplicates(rules):
    return list(set(rules))  # Removes exact duplicates

def filter_rules(input_file, output_file):
    with open(input_file, 'r') as f:
        rules = f.readlines()
    
    # Remove redundant or inconsistent rules
    filtered_rules = [rule for rule in rules if not is_redundant_or_inconsistent(rule)]
    
    # Remove duplicate rules
    filtered_rules = remove_duplicates(filtered_rules)
    
    with open(output_file, 'w') as f:
        f.writelines(filtered_rules)
    
    print(f"Filtered rules saved to {output_file}")

# Usage
input_file = "s_m.txt"  # Replace with actual path if needed
output_file = "filtered_s_m.txt"
filter_rules(input_file, output_file)

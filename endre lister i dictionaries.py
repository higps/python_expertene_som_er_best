list1 = ["a", "b", "c"]
dict2 = {"John": list1}
dict3 = {"Person": dict2}

for values in dict3.values():
    for key, i in values.items():
        
        empty_list = []
        for k in i:
            empty_list.append("f")
        values[key] = empty_list

print(list1)
print(dict2)
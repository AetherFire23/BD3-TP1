melanges = ["eat", "tea", "tan", "ate", "nat", "bat"]

expected = [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]

print(sorted("bella"))


def haveAllLettersInCommon(word, other):
    if len(word) != len(other):
        return False

    firstSorted = sorted(word)
    otherSorted = sorted(other)
    for i in range(0, len(word) - 1):
        if firstSorted[i] != otherSorted[i]:
            return False

    return True

dic = {}
for word in melanges:
    amount_of_values_in_section = 1
    for innerWord in melanges:
        # if words are the same, skip
        if word == innerWord:
            continue
        else: # are they all in common ?
            if haveAllLettersInCommon(word, innerWord):
                key = "".join(sorted(innerWord))
                if key in dic: # if so, add the word to the string -> string[]
                    dic[key].append(word)
                else:
                    dic[key] = []
                    dic[key].append(word)
                amount_of_values_in_section = amount_of_values_in_section + 1


    if amount_of_values_in_section == 1:
        key= "".join(sorted(word))
        if key in dic:  # if so, add the word to the string -> string[]
            dic[key].append(word)
        else:
            dic[key] = []
            dic[key].append(word)

arr = []
lastArr = []
for kvp in dic.items():
    innerArr =  []
    arr.append(innerArr)  # new dictionary for new word sequence
    for word in kvp[1]:
        innerArr.append(word)
    lastArr.append(list(dict.fromkeys(innerArr)))


print(lastArr)
# transform all kvps into
# print(dic)
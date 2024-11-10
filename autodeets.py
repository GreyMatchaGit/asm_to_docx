import os
 
files = os.listdir()

# Fill the deets below first
# before running the script.
 
name = "put your name here."
desc = "[placeholder]"
date = "put the date here."
 
for f in files:
    if (f[len(f) - 3:].lower() != "asm"): continue
    print(f"Making copy of {f}...")
   
    already_found = False
    data_found = False
    things2 = []
    random_name = "zxcvasdfqw"
 
    a = f
    file = open(f, "r+")
    temp = open("temp.txt", "w+")
    lines = file.readlines()
 
    things = [f"Filename: {a}",
          f"Programmer Name: {name}",
          f"Program Description: {desc}",
          f"Date Created: {date}"]
 
    for t in things:
        temp.write(f"; {t}\n")
 
    for _ in lines:
        temp.write(_)
        if ".data" in _.lower() and not data_found:
            for e in things:
                temp.write(f"\t{random_name} DB \"{e}\", 13, 10, 36\n")
                things2.append(random_name)
                random_name += "a"
            data_found = True
 
        if (".startup" in _.lower() or "mov ds, ax" in _.lower()) and not already_found:
            temp.write(f"\tmov ah, 9\n")
            for e in things2:
                temp.write(f"\tlea dx, {e}\n")
                temp.write(f"\tint 21h\n")
            already_found = True
 
    file.close()
    temp.close()
 
    temp = open("temp.txt", "r")
    file = open(a, "w")
 
    tempContent = temp.readlines()
    for content in tempContent:
        file.write(content)
 
    file.close()
    temp.close()

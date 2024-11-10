import os

# This script compiles all your assembly files
# inside a folder into one document (.docx) file
# with this format:
#
# 1. {File name with file type}
#     Code:
#         {...}
#     Screenshot:
#         [placeholder]     
#
# All you need to do is take the screenshots of
# each of your assembly file.

# Put the name of the document file here.
# Example:
# name_of_doc = "WEEK13"
#
name_of_doc = "name"

files = os.listdir()
document = open(f"{name_of_doc}.docx", "w")
file_number = 0

for file in sorted(files):
    if file.split('.')[1] != "asm":
        continue

    file_number += 1
    
    current_file = open(file, "r")
    current_contents = current_file.readlines()

    document.write(f"{file_number}. {file}\n\tCode:\n")
    for content in current_contents:
        document.write(f"\t{content}")
    document.write("\tScreenshot:\n\t\t[Placeholder]\n")

    current_file.close()

document.close()

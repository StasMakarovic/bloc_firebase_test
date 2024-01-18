import os

# Root directory containing .dart files
root_directory = 'lib'

# Output file
output_file = 'dart_files_combined.txt'

# Splitter to separate content from different files
splitter = '\n' + '-' * 50 + '\n'

# Start processing
with open(output_file, 'w', encoding='utf-8') as outfile:  # Specify UTF-8 encoding here
    for subdir, dirs, files in os.walk(root_directory):
        for filename in files:
            if filename.endswith('.dart'):
                filepath = os.path.join(subdir, filename)
                outfile.write(f'File: {filepath}\n')
                outfile.write(splitter)
                with open(filepath, 'r', encoding='utf-8') as infile:  # Also specify UTF-8 when reading
                    outfile.write(infile.read())
                outfile.write(splitter)

print("Process completed. Check the file:", output_file)

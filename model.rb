# Str -> Int
# Takes a directory and returns a random integer that's
# in the intervall 1-n, where n is the number of files
# in that directory
# 
def get_file_count(dir)

    count = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }

    return rand(1..count)
end


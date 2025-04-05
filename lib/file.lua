local file = {}


function get_name(filepath)
    return filepath:match("(.+)%..+") --"^.+/(.+)$"
end


function get_extension(filepath)
    return filepath:match("^.+(%..+)$")
end


return file
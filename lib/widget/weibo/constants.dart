
/// Email Regex - A predefined type for handling email matching
const emailPattern = r"\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b";

/// URL Regex - A predefined type for handling URL matching
const urlPattern =
    r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:_\+.~#?&//=]*)";

/// Phone Regex - A predefined type for handling phone matching
const phonePattern =
    r"(\+?( |-|\.)?\d{1,2}( |-|\.)?)?(\(?\d{3}\)?|\d{3})( |-|\.)?(\d{3}( |-|\.)?\d{4})";

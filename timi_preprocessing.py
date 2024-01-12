# raw string to preprocessed list of tokens

def preprocess_text(text: str):
    replace_with_space = ['\n', '/']
    for to_replace in replace_with_space:
        text = text.replace(to_replace, ' ')

    replace_with_nothing = ['"', "''", '.', '!', '?', '(', ')', '=', ';', ':', ',', "'s", '{', '}' '“', '“', '”', '‘', '’', '«', '»', '¨', '·', '£', '₤', '$', '#', '@', '§', '[', ']', "*", '~', '&', '^']
    for to_replace in replace_with_nothing:
        text = text.replace(to_replace, '')

    text = text.lower()
    text = text.split(" ")

    tokens = []
    for i in range(0, len(text)):
        stripped_token = text[i].strip().strip("'")
        if (stripped_token.isalpha()):
            tokens.append(stripped_token)
        
    return tokens
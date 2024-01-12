from multiprocessing import Pool, cpu_count
from datetime import datetime

def preprocess(text: str):
    '''
    Description:                            This function preprocesses a text string. It replaces certain characters, converts them to lowercase, divides them into tokens, and filters out non-alphabetic tokens.
    Arguments:      text                    Input text to be preprocessed
    Returns:        list                    List of preprocessed tokens
    '''
    
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
        if stripped_token.isalpha():
            tokens.append(stripped_token)
        
    return tokens

def process(review):
    '''
    Description:                            This function processes a single review.
    Arguments:      review                  Input review to be preprocessed
    Returns:        tokens                  List of preprocessed tokens
        
    '''
    tokens = preprocess(review)
    return tokens

def count_tokens(reviews):
    '''
    Description:                             This function counts the occurrence of each token in a list of reviews
    Arguments:      reviews                  List of reviews
    Returns:        token_count              A dictionary with tokens as keys and their corresponding counts as values
    '''
    token_count = {}
    for review in reviews:
        tokens = process(review)
        for token in tokens:
            token_count[token] = token_count.get(token, 0) + 1
    return token_count

def write_unique_tokens(tokens):
    '''
    Description:                             This function writes the unique tokens to a file
    Arguments:      tokens                   Set of unique tokens to be written
    Returns:        none                      
    '''
    with open("unique_tokens.txt", "w", encoding="utf-8") as file:
        for token in sorted(tokens):
            file.write(token + "\n")

def write_top_tokens(top_tokens):
    '''
    Description:                             This function writes the top tokens and their counts to a file
    Arguments:      top_tokens               List of tuples containing the top tokens and their counts
    Returns:        none                      
    '''
    with open(".txt", "w", encoding="utf-8") as file:
        for token, count in top_tokens:
            file.write(f"{token}: {count}\n")

def read_reviews(file_path):
    '''
    Description:                             This function reads a file containing reviews
    Arguments:      file_path                Path to the file containing the reviews
    Returns:        reviews                  List of reviews read from the file
    '''
    reviews = []
    with open(file_path, encoding="utf-8") as file:
        lines = file.readlines()
        for line in lines:
            review = line.strip()
            reviews.append(review)
    return reviews

def main():
    start_time = datetime.now()
    reviews = read_reviews("movie_reviews_dataset.csv")

    pool = Pool(processes=cpu_count())
    results = pool.map(process, reviews)
    pool.close()
    pool.join()

    all_tokens = {token for result in results for token in result} 
    write_unique_tokens(all_tokens)

    token_count = count_tokens(reviews)
    top100_tokens = sorted(token_count.items(), key=lambda x: x[1], reverse=True)[:100]
    write_top_tokens(top100_tokens)

    total_count = sum(token_count.values())
    print(f"Total count of all tokens: {total_count}")

    total_unique_tokens = len(all_tokens)
    print(f"Total number of unique tokens: {total_unique_tokens}")

    end_time = datetime.now()
    execution_time = end_time - start_time
    print(f"Execution time: {execution_time}")

if __name__ == '__main__':
    main()
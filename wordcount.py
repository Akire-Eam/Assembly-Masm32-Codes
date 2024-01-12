
# Imports 

import multiprocessing
import datetime

nr_threads = 10

# raw string to preprocessed list of tokens

def preprocess_text(text: str):
    """
    Parameters: text (str) - The raw string of text to be preprocessed.

    Returns: tokens (list) - The preprocessed list of tokens extracted from the text.
    """
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

def preprocess():
    """
    This function reads the content of the "movie_reviews_dataset.csv" file and 
    applies the preprocess_text function to preprocess the text. The preprocessed 
    text is stored in a list called text_filepath, and this list is returned.
        
    Parameters: None

    Returns: text (list) - The preprocessed text stored in a list.
    """

    with open("movie_reviews_dataset.csv", 'r', encoding='utf-8') as file:
        csv_data = file.read()
        text = []
        text.append(preprocess_text(csv_data))
        return text

def count_occurrences( lines ):
    """
    Clean text and count each word in the text, iterating per line provided. 
    Takes a list of lines as input and performs word count analysis on the text. 
    It iterates over each line and extracts individual words. The counter function 
    is used to count the occurrences of each word, and the results are returned 
    as a list of tuples containing the word and its count.
    
    Parameters: lines (list) - A list of lines containing the text to be analyzed.

    Returns: result (list) - A list of tuples containing the word and its count.
    """
    cleansed = []
    for line in lines:
        clean_line = line
        for word in clean_line:
            cleansed.append(word)
        
    count = counter(cleansed)
    result = [(key, value) for key, value in count.items()]
    return result

def counter(it):
    """
    This function takes an iterable as input and counts the occurrences 
    of each item in it. It uses a dictionary to keep track of the counts 
    and returns the dictionary.

    Parameters: it (iterable) - An iterable (e.g., list, tuple) containing items to be counted.

    Returns: counts (dict) - A dictionary with items from the iterable as keys and their counts as values.
    """
    
    counts = {}
    for item in it:
        try:
            counts[item] += 1
        except KeyError:
            counts[item] = 1
    return counts

def custom_groupby(iterable, key_func):
    """
    This function groups consecutive items in an iterable based on a 
    key function. It yields tuples containing the key and the group of items.
    
    Parameters:
    iterable (iterable) - An iterable (e.g., list, tuple) of items to be grouped.
    key_func (function) - A key function that specifies the grouping criterion.

    Yields: Tuples containing the key and the group of items.
    """

    current_key = None
    group = []
    
    for item in iterable:
        key = key_func(item)
        
        if key != current_key:
            if group:
                yield current_key, group
                group = []
            
            current_key = key
        
        group.append(item)
    
    if group:
        yield current_key, group

def write_file ( destination_filepath , wordcount_list ):
     """
    This function writes the word count information to a file specified
    by the destination file path. It writes the top 100 words and their
    counts in descending order in the format "word, count".

    Parameters:
    destination_filepath (str) - The file path where the word count information will be written.
    wordcount_list (list) - A list of tuples containing word-count pairs.
    """

     with open( destination_filepath, 'w+', encoding='utf-8') as f:
          for word, value in sorted(wordcount_list[:100], key=lambda x: x[1], reverse=False): 
              f.write("{} , {}\n".format(word, value))
                        
def unique_write_file ( destination_filepath , wordcount_list ):
     """
    Similar to write_file, but it writes all unique words to the file.

    Parameters:
    destination_filepath (str) - The file path where the unique word information will be written.
    wordcount_list (list) - A list of tuples containing word-count pairs.

    """
     with open( destination_filepath, 'w+', encoding='utf-8') as f:
          for word, value in wordcount_list: 
              f.write("{}\n".format(word))

def main():
    """
    Coordinates the overall workflow of the script. It calls the preprocess function to 
    obtain the preprocessed text, creates a pool of worker processes using multiprocessing.Pool, 
    and applies the count_occurrences function to the preprocessed text using pool.map. 
    The results are then flattened and grouped by word using the custom_groupby function. 
    The word counts are aggregated, sorted, and saved to two output files using the write_file 
    and unique_write_file functions.
    """
    text = preprocess()
    results = pool.map(count_occurrences, [text])
    
    words = [ entry for line in results for entry in line]

    key = lambda x: x[0]
    sorted_words = custom_groupby(sorted(words), key)
    
    word_aggregate = [ [key, sum(value for _, value in group)] for key, group in sorted_words ]
    
    sorted_counts = sorted(word_aggregate, key = lambda x: x[1], reverse=True)
    
    # save results
    output_filepath = "top_100_tokens.txt"
    write_file( output_filepath , sorted_counts )

    unique_output_filepath = "unique_tokens.txt"
    unique_write_file( unique_output_filepath , sorted_counts )

if __name__ == '__main__':
    start = datetime.datetime.now()
    print("START:", start)
    
    pool = multiprocessing.Pool(processes=nr_threads)
    main()
    
    end = datetime.datetime.now()
    print("END:", end)
    print("DURATION:", end-start)
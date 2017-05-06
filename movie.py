    import pandas as pd
    import numpy as np
    from sklearn.metrics import mean_squared_error

    def fast_similarity(ratings, kind='user', epsilon=1e-9):
        # epsilon -> small number for handling dived-by-zero errors
        if kind == 'user':
            sim = ratings.dot(ratings.T) + epsilon
        elif kind == 'item':
            sim = ratings.T.dot(ratings) + epsilon
        norms = np.array([np.sqrt(np.diagonal(sim))])
        return (sim / norms / norms.T)



    #Reading users file: (943x5)
    DATA_PATH = "data\\ml-100k\\"
    u_cols = ['user_id', 'age', 'sex', 'occupation', 'zip_code']
    users = pd.read_csv(DATA_PATH+'u.user', sep='|', names=u_cols,
    encoding='latin-1')


    #Reading ratings file: (100000x4)
    r_cols = ['user_id', 'movie_id', 'rating', 'unix_timestamp']
    ratings = pd.read_csv(DATA_PATH+'u.data', sep='\t', names=r_cols,encoding='latin-1')


    #Reading movies file: (1682x4)
    m_cols = ['movie id', 'movie title' ,'release date','video release date', 'IMDb URL', 'unknown', 'Action', 'Adventure',
    'Animation', 'Children\'s', 'Comedy', 'Crime', 'Documentary', 'Drama', 'Fantasy',
    'Film-Noir', 'Horror', 'Musical', 'Mystery', 'Romance', 'Sci-Fi', 'Thriller', 'War', 'Western']

    movies = pd.read_csv(DATA_PATH+'u.item', sep='|', names=m_cols,
    encoding='latin-1')

    n_users =ratings.user_id.unique().shape[0]
    n_items = ratings.movie_id.unique().shape[0]


    ratings_map = np.zeros((n_users, n_items))

    for row in ratings.itertuples():
        ratings_map[row[1]-1, row[2]-1] = row[3]
        

    # divied the data set into test data and training data

    # base data
    # ratings_base = pd.read_csv(DATA_PATH+'ua.base', sep='\t', names=r_cols, encoding='latin-1')

    # test data
    # ratings_test = pd.read_csv(DATA_PATH+'ua.test', sep='\t', names=r_cols, encoding='latin-1')
    sim  = fast_similarity(ratings_map)

    def train_test_split(ratings):
        test = np.zeros(ratings.shape)
        train = ratings.copy()
        for user in xrange(ratings.shape[0]):
            test_ratings = np.random.choice(ratings[user, :].nonzero()[0], 
                                            size=10, 
                                            replace=False)
            train[user, test_ratings] = 0.
            test[user, test_ratings] = ratings[user, test_ratings]
            
        # Test and training are truly disjoint
        assert(np.all((train * test) == 0)) 
        return train, test

    train, test = train_test_split(ratings_map)


    def predict_fast_simple(ratings, similarity, kind='user'):
        if kind == 'user':
            return similarity.dot(ratings) / np.array([np.abs(similarity).sum(axis=1)]).T
        elif kind == 'item':
            return ratings.dot(similarity) / np.array([np.abs(similarity).sum(axis=1)])




    user_prediction = predict_fast_simple(train, sim, kind='user')
    print user_prediction

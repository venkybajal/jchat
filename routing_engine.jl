module RoutingEngine

    using Recommendation

    n_users = 10
    n_agents = 5

    export get_the_recommendation, save_ratings
    function load_ratings()
    
        # need to load it from a file 
        ratings = Event[]
        open("ratings.matr") do f
                s = readlines(f)
                
                for i in s            
                    row = split(i)
                    
                    push!(ratings, Event(parse(Int64,String(row[1])),parse(Int64,String(row[2])), parse(Float64,String(row[3]))))
                end
            end
        return ratings
    end
    

    # returns dictions of agent id with thier predicted rating
    function get_the_recommendation(user, number)
       
        # Needs to be persisted
        ratings = load_ratings()
        
        global n_users
        global n_agents

        da = DataAccessor(ratings, n_users, n_agents)
        
        # apply Matrix Factorisation
        recommender = MF(da, Parameters(:k => 2))
        println(is_build(recommender)) 
        build(recommender, learning_rate=15e-4, max_iter=100)
        agents = [i for i in 1:n_agents] # get all the agent ids
        reco = recommend(recommender, user.id, number, agents)
        
        return reco
    end

    function save_ratings(user, agent, rating)
    
        # TODO: saves the user rating for future us
        open("ratings.matr","a") do f
            write(f, string(user," ", agent, " ",rating))
        end
        return true   
    end

    function is_build(rec)
      
        if !haskey(rec.states, :is_built) || !rec.states[:is_built]
            false
        end
        return true
    end
    

end
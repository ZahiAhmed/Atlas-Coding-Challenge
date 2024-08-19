def findMinTempSpread(input)
    w_data = []
    
    #only first 3 columns are required
    labels = [:Day, :Max, :Min] 
    
    File.readlines(input).each do |line|
        parts = line.split
        
        #relevant data starts with a numerical value
        next if parts[0].to_i < 1 
        
        d_data = {}
        
        #fill in data hashes with corresponding values 
        labels.each.with_index do |label, i|
            d_data[label] = parts[i]
        end
        
        #create :TempSpread key for each data hash
        d_data[:TempSpread] = d_data[:Max].to_i - d_data[:Min].to_i
        
        w_data << d_data
    end
    
    #sort by :TempSpread and return first element
    w_data.sort_by{|d_data| d_data[:TempSpread]}[0]
end

p findMinTempSpread("w_data.dat")[:Day]
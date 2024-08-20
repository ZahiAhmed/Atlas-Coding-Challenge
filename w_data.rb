def findMinTempSpread(input)
    w_data = []
    
    #only first 4 columns are required
    labels = [:Day, :Max, :Min, :Avg] 
    
    File.readlines(input).each do |line|
        parts = line.split
        
        #relevant data starts with a numerical value
        next if parts[0].to_i < 1 
        
        d_data = {}
        
        #fill in data hashes with corresponding values 
        labels.each.with_index do |label, i|
            d_data[label] = parts[i]
        end
        
        if weatherValid?(d_data) 
            #create :TempSpread key for each data hash
            d_data[:TempSpread] = (d_data[:Max].to_i - d_data[:Min].to_i).abs
        else 
            next
        end
        
        w_data << d_data
    end
    
    #sort by :TempSpread and return first element
    w_data.sort_by{|d_data| d_data[:TempSpread]}[0]
end

#cases for data being incomplete or incorrect
def weatherValid?(d_data)
    if d_data.any? {|key,value| value.empty? || (key == :Day ? value.to_i <= 1 : value.to_i < 1 && value != "0")}
        return false
    end

    d_data[:Avg].to_i <= d_data[:Max].to_i && d_data[:Avg].to_i >= d_data[:Min].to_i
end

p findMinTempSpread("w_data.dat")[:Day]
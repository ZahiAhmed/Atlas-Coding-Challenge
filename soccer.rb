def findMinDiff(input)
    all_stats = []

    #creating custom labels in case different datasets have different headings
    labels = [:Team, :P, :W, :L, :D, :F, :A, :Points]
    
    File.readlines(input).each do |line|
        parts = line.split
        
        next if parts.length < 2
        labels = parts.map {|label| label.to_sym} if labels.empty?

        #relevant data starts with a numerical value
        next if parts[0].to_i < 1 
        
        #grabs integer value of standings column
        standing = parts.shift.to_i
        
        stats = {}
        
        labels.each.with_index do |label, i| 
            #bypass "-" between :F and :A columns
            i+=1 if parts[i].to_i < 1 unless label == :Team || parts[i] == "0"

            stats[label] = parts[i]
        end
        
        #create standing and difference key in data hash
        stats[:Standing] = standing

        if validateStats(stats)
            stats[:Difference] = (stats[:F].to_i - stats[:A].to_i).abs
        else
            next
        end

        all_stats << stats
    end
    
    #sort data by difference and return first element
    all_stats.sort_by{|stats| stats[:Difference]}[0]
end

#case for when data incomplete or incorrect
def validateStats(stats)
    if stats[:A].empty? || stats[:F].empty? || stats[:Team].empty?
        return false
    end

    (stats[:A] == "0" || stats[:A].to_i >= 1) && (stats[:F] == "0" || stats[:F].to_i >= 1)
end

p findMinDiff("soccer.dat")[:Team]
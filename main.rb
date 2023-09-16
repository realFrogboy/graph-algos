require_relative "graph.rb"

class ParseError < ::StandardError
end

def getEdges
  edges = []
  n_line = 0

  while(line = gets)
    edge = line.scan(/\d+/)
    raise ParseError.new("can't parse line ##{n_line}") if edge[0] == nil || edge[1] == nil || edge[2] == nil
    edges.push(Edge.new(Integer(edge[0]), Integer(edge[1]), Integer(edge[2])))
  end
  edges
end

def main
  begin 
    edges = getEdges
    graph = Graph_t.new edges

    bipartite = graph.is_bipartite

    puts "Bipartite: #{bipartite == 0 ? "no" : "yes"}"
    puts graph if bipartite == 1

    File.open("graph.dot", 'w') { |file| graph.dump file }
    system("dot -Tpng graph.dot -o graph.png")
  rescue StandardError => e
    puts "#{e.class}:: #{e.message}"
  end
end 

main
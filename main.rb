require_relative "graph.rb"

def getEdges
  edges = Array.new
  while(line = gets)
    edge = line.scan(/\d+/)
    edges.push(Edge.new(Integer(edge[0]), Integer(edge[1]))) if edge[0] != nil && edge[1] != nil
  end
  edges
end

def main
  edges = getEdges
  graph = Graph_t.new edges

  puts graph.is_bipartite

  File.open("graph.dot", 'w') { |file| graph.dump file }
  system("dot -Tpng graph.dot -o graph.png")
end 

main
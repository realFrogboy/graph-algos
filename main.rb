require_relative "graph.rb"

def main
  begin
    edges = Parser.getEdges STDIN
    graph = Graph_t.new(edges[0], edges[1])

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

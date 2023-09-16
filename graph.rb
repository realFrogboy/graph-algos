Node = Struct.new(:a, :t, :n, :p)
Edge = Struct.new(:first, :second)

module GraphDump
  def dump file
    file.write("digraph tree {\n")

    @nodes.first(@n_nodes).each do |node| 
      file.write("\tnode#{node.a} [shape = \"record\", label = \"#{node.a}\"];\n")
    end

    @nodes.first(@n_nodes).each do |node|
      child = @nodes[node.n]
      while child.a != node.a
        file.write("node#{node.a} -> node#{child.t};\n") if child.t != nil
        child = @nodes[child.n]
      end
    end

    file.write("}")
  end
end

class Graph_t
  include GraphDump

  private def to_s = @nodes.map { |node| "a: #{node.a}, t: #{node.t}, n: #{node.n}, p: #{node.p}" }.join("\n")

  def initialize edges
    @nodes = []
    edge_hash = {}
    vertex_poses = []

    edges.each do |edge|
      mate_edge = Edge.new(edge.second, edge.first)        
      edge_pos = 0

      if edge_hash.include?(mate_edge)
        mate_pos = edge_hash[mate_edge]
        edge_pos = mate_pos ^ 1;

        @nodes[edge_pos] = Node.new(edge_pos, edge.second, edge_pos, edge_pos)
      else
        edge_pos = @nodes.size
        @nodes.push(Node.new(edge_pos, edge.second, edge_pos, edge_pos))
        @nodes.push(Node.new(edge_pos + 1, nil, edge_pos + 1, edge_pos + 1))
      end

      if (pos = vertex_poses[edge.first]) != nil
        head = @nodes[pos].n

        @nodes[edge_pos].n = head
        @nodes[edge_pos].p = pos
        
        @nodes[pos].n = edge_pos
        @nodes[head].p = edge_pos
      end

      vertex_poses[edge.second] = -1 if vertex_poses[edge.second] == nil

      vertex_poses[edge.first] = edge_pos
      edge_hash[edge] = edge_pos
    end

    @n_nodes = vertex_poses.size

    @nodes = vertex_poses.map.with_index do |pos, index|
      next Node.new(index, nil, index, index) if pos == -1
      head = @nodes[pos].n

      @nodes[pos].n = index - @n_nodes
      @nodes[head].p = index - @n_nodes

      Node.new(index, nil, head + @n_nodes, pos + @n_nodes)
    end + @nodes.map! { |node| Node.new(node.a + @n_nodes, node.t, node.n + @n_nodes, node.p + @n_nodes) }
  end
end

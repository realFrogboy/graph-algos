require_relative "graph.rb"
require "minitest/autorun"

class TestGraph < Minitest::Test
  def test_is_bipartite_1
    edges = Parser.getEdges File.open("graphs/graph")
    graph = Graph_t.new(edges[0], edges[1])

    assert_equal(0, graph.is_bipartite)
  end
  def test_is_bipartite_2
    edges = Parser.getEdges File.open("graphs/heawood_graph")
    graph = Graph_t.new(edges[0], edges[1])

    assert_equal(1, graph.is_bipartite)
  end
  def test_is_bipartite_3
    edges = Parser.getEdges File.open("graphs/seminar_3")
    graph = Graph_t.new(edges[0], edges[1])

    assert_equal(1, graph.is_bipartite)
  end
  def test_is_bipartite_4
    edges = Parser.getEdges File.open("graphs/seminar_4")
    graph = Graph_t.new(edges[0], edges[1])

    assert_equal(0, graph.is_bipartite)
  end
  def test_is_bipartite_5
    edges = Parser.getEdges File.open("graphs/star")
    graph = Graph_t.new(edges[0], edges[1])

    assert_equal(1, graph.is_bipartite)
  end
  def test_is_bipartite_6
    edges = Parser.getEdges File.open("graphs/triangle")
    graph = Graph_t.new(edges[0], edges[1])

    assert_equal(0, graph.is_bipartite)
  end
end

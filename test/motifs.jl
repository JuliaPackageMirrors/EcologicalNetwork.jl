module TestMotifs
  using Base.Test
  using ProbabilisticNetwork

  # Test with a single link
  A = [0.2 0.8; 0.2 0.1]
  m = [0.0 1.0; 0.0 0.0]
  pmotif = ProbabilisticNetwork.motif_internal(A, m)
  @test pmotif == vec([0.8 0.8 0.8 0.9])

  # Test with a perfect match
  A = [0.0 1.0; 0.0 0.0]
  m = [0.0 1.0; 0.0 0.0]
  pmotif = ProbabilisticNetwork.motif_internal(A, m)
  @test pmotif == vec([1.0 1.0 1.0 1.0])
  @test motif_p(A, m) == 1.0
  @test motif_v(A, m) == 0.0

  # Test on a three-species network
  B = [0.0 1.0 1.0; 0.0 0.0 1.0; 0.0 0.0 0.0]
  @test motif(B, B) == 1.0
  @test motif_var(B, B) == 0.0

  # Test with some variation
  ovl = [0.0 1.0 1.0; 0.0 0.0 1.0; 0.0 0.0 0.0]
  A = [0.0 1.0 0.8; 0.0 0.0 1.0; 0.0 0.0 0.0]
  @test_approx_eq motif(A, ovl) 0.8
  fchain = [0.0 1.0 0.0; 0.0 0.0 1.0; 0.0 0.0 0.0]
  @test_approx_eq motif(A, fchain) 0.2

  # Test of the simplest situation: two nodes, ten random matrices
  for i in 1:10
    A = rand((2, 2))
    possible_motifs = {
      [0 1; 0 0], [1 0; 0 0], [0 0; 1 0], [0 0; 0 1],
      [1 1; 0 0], [1 0; 0 1], [1 0; 1 0],
      [0 1; 1 0], [0 1; 0 1],
      [0 0; 1 1],
      [0 1; 1 1], [1 0; 1 1], [1 1; 1 0], [1 1; 0 1],
      [0 0; 0 0], [1 1; 1 1]
    }
    all_probas = map((x) -> motif_p(A, float(x)), possible_motifs)
    @test_approx_eq sum(all_probas) 1.0
  end

  # Test for all motifs of three nodes
  for i in 1:10
    A = rand((3, 3))
    possible_motifs = {
    [0 0 0; 0 0 0; 0 0 0],
    [1 0 0; 0 0 0; 0 0 0],
    [0 1 0; 0 0 0; 0 0 0],
    [1 1 0; 0 0 0; 0 0 0],
    [0 0 1; 0 0 0; 0 0 0],
    [1 0 1; 0 0 0; 0 0 0],
    [0 1 1; 0 0 0; 0 0 0],
    [1 1 1; 0 0 0; 0 0 0],
    [0 0 0; 1 0 0; 0 0 0],
    [1 0 0; 1 0 0; 0 0 0],
    [0 1 0; 1 0 0; 0 0 0],
    [1 1 0; 1 0 0; 0 0 0],
    [0 0 1; 1 0 0; 0 0 0],
    [1 0 1; 1 0 0; 0 0 0],
    [0 1 1; 1 0 0; 0 0 0],
    [1 1 1; 1 0 0; 0 0 0],
    [0 0 0; 0 1 0; 0 0 0],
    [1 0 0; 0 1 0; 0 0 0],
    [0 1 0; 0 1 0; 0 0 0],
    [1 1 0; 0 1 0; 0 0 0],
    [0 0 1; 0 1 0; 0 0 0],
    [1 0 1; 0 1 0; 0 0 0],
    [0 1 1; 0 1 0; 0 0 0],
    [1 1 1; 0 1 0; 0 0 0],
    [0 0 0; 1 1 0; 0 0 0],
    [1 0 0; 1 1 0; 0 0 0],
    [0 1 0; 1 1 0; 0 0 0],
    [1 1 0; 1 1 0; 0 0 0],
    [0 0 1; 1 1 0; 0 0 0],
    [1 0 1; 1 1 0; 0 0 0],
    [0 1 1; 1 1 0; 0 0 0],
    [1 1 1; 1 1 0; 0 0 0],
    [0 0 0; 0 0 1; 0 0 0],
    [1 0 0; 0 0 1; 0 0 0],
    [0 1 0; 0 0 1; 0 0 0],
    [1 1 0; 0 0 1; 0 0 0],
    [0 0 1; 0 0 1; 0 0 0],
    [1 0 1; 0 0 1; 0 0 0],
    [0 1 1; 0 0 1; 0 0 0],
    [1 1 1; 0 0 1; 0 0 0],
    [0 0 0; 1 0 1; 0 0 0],
    [1 0 0; 1 0 1; 0 0 0],
    [0 1 0; 1 0 1; 0 0 0],
    [1 1 0; 1 0 1; 0 0 0],
    [0 0 1; 1 0 1; 0 0 0],
    [1 0 1; 1 0 1; 0 0 0],
    [0 1 1; 1 0 1; 0 0 0],
    [1 1 1; 1 0 1; 0 0 0],
    [0 0 0; 0 1 1; 0 0 0],
    [1 0 0; 0 1 1; 0 0 0],
    [0 1 0; 0 1 1; 0 0 0],
    [1 1 0; 0 1 1; 0 0 0],
    [0 0 1; 0 1 1; 0 0 0],
    [1 0 1; 0 1 1; 0 0 0],
    [0 1 1; 0 1 1; 0 0 0],
    [1 1 1; 0 1 1; 0 0 0],
    [0 0 0; 1 1 1; 0 0 0],
    [1 0 0; 1 1 1; 0 0 0],
    [0 1 0; 1 1 1; 0 0 0],
    [1 1 0; 1 1 1; 0 0 0],
    [0 0 1; 1 1 1; 0 0 0],
    [1 0 1; 1 1 1; 0 0 0],
    [0 1 1; 1 1 1; 0 0 0],
    [1 1 1; 1 1 1; 0 0 0],
    [0 0 0; 0 0 0; 1 0 0],
    [1 0 0; 0 0 0; 1 0 0],
    [0 1 0; 0 0 0; 1 0 0],
    [1 1 0; 0 0 0; 1 0 0],
    [0 0 1; 0 0 0; 1 0 0],
    [1 0 1; 0 0 0; 1 0 0],
    [0 1 1; 0 0 0; 1 0 0],
    [1 1 1; 0 0 0; 1 0 0],
    [0 0 0; 1 0 0; 1 0 0],
    [1 0 0; 1 0 0; 1 0 0],
    [0 1 0; 1 0 0; 1 0 0],
    [1 1 0; 1 0 0; 1 0 0],
    [0 0 1; 1 0 0; 1 0 0],
    [1 0 1; 1 0 0; 1 0 0],
    [0 1 1; 1 0 0; 1 0 0],
    [1 1 1; 1 0 0; 1 0 0],
    [0 0 0; 0 1 0; 1 0 0],
    [1 0 0; 0 1 0; 1 0 0],
    [0 1 0; 0 1 0; 1 0 0],
    [1 1 0; 0 1 0; 1 0 0],
    [0 0 1; 0 1 0; 1 0 0],
    [1 0 1; 0 1 0; 1 0 0],
    [0 1 1; 0 1 0; 1 0 0],
    [1 1 1; 0 1 0; 1 0 0],
    [0 0 0; 1 1 0; 1 0 0],
    [1 0 0; 1 1 0; 1 0 0],
    [0 1 0; 1 1 0; 1 0 0],
    [1 1 0; 1 1 0; 1 0 0],
    [0 0 1; 1 1 0; 1 0 0],
    [1 0 1; 1 1 0; 1 0 0],
    [0 1 1; 1 1 0; 1 0 0],
    [1 1 1; 1 1 0; 1 0 0],
    [0 0 0; 0 0 1; 1 0 0],
    [1 0 0; 0 0 1; 1 0 0],
    [0 1 0; 0 0 1; 1 0 0],
    [1 1 0; 0 0 1; 1 0 0],
    [0 0 1; 0 0 1; 1 0 0],
    [1 0 1; 0 0 1; 1 0 0],
    [0 1 1; 0 0 1; 1 0 0],
    [1 1 1; 0 0 1; 1 0 0],
    [0 0 0; 1 0 1; 1 0 0],
    [1 0 0; 1 0 1; 1 0 0],
    [0 1 0; 1 0 1; 1 0 0],
    [1 1 0; 1 0 1; 1 0 0],
    [0 0 1; 1 0 1; 1 0 0],
    [1 0 1; 1 0 1; 1 0 0],
    [0 1 1; 1 0 1; 1 0 0],
    [1 1 1; 1 0 1; 1 0 0],
    [0 0 0; 0 1 1; 1 0 0],
    [1 0 0; 0 1 1; 1 0 0],
    [0 1 0; 0 1 1; 1 0 0],
    [1 1 0; 0 1 1; 1 0 0],
    [0 0 1; 0 1 1; 1 0 0],
    [1 0 1; 0 1 1; 1 0 0],
    [0 1 1; 0 1 1; 1 0 0],
    [1 1 1; 0 1 1; 1 0 0],
    [0 0 0; 1 1 1; 1 0 0],
    [1 0 0; 1 1 1; 1 0 0],
    [0 1 0; 1 1 1; 1 0 0],
    [1 1 0; 1 1 1; 1 0 0],
    [0 0 1; 1 1 1; 1 0 0],
    [1 0 1; 1 1 1; 1 0 0],
    [0 1 1; 1 1 1; 1 0 0],
    [1 1 1; 1 1 1; 1 0 0],
    [0 0 0; 0 0 0; 0 1 0],
    [1 0 0; 0 0 0; 0 1 0],
    [0 1 0; 0 0 0; 0 1 0],
    [1 1 0; 0 0 0; 0 1 0],
    [0 0 1; 0 0 0; 0 1 0],
    [1 0 1; 0 0 0; 0 1 0],
    [0 1 1; 0 0 0; 0 1 0],
    [1 1 1; 0 0 0; 0 1 0],
    [0 0 0; 1 0 0; 0 1 0],
    [1 0 0; 1 0 0; 0 1 0],
    [0 1 0; 1 0 0; 0 1 0],
    [1 1 0; 1 0 0; 0 1 0],
    [0 0 1; 1 0 0; 0 1 0],
    [1 0 1; 1 0 0; 0 1 0],
    [0 1 1; 1 0 0; 0 1 0],
    [1 1 1; 1 0 0; 0 1 0],
    [0 0 0; 0 1 0; 0 1 0],
    [1 0 0; 0 1 0; 0 1 0],
    [0 1 0; 0 1 0; 0 1 0],
    [1 1 0; 0 1 0; 0 1 0],
    [0 0 1; 0 1 0; 0 1 0],
    [1 0 1; 0 1 0; 0 1 0],
    [0 1 1; 0 1 0; 0 1 0],
    [1 1 1; 0 1 0; 0 1 0],
    [0 0 0; 1 1 0; 0 1 0],
    [1 0 0; 1 1 0; 0 1 0],
    [0 1 0; 1 1 0; 0 1 0],
    [1 1 0; 1 1 0; 0 1 0],
    [0 0 1; 1 1 0; 0 1 0],
    [1 0 1; 1 1 0; 0 1 0],
    [0 1 1; 1 1 0; 0 1 0],
    [1 1 1; 1 1 0; 0 1 0],
    [0 0 0; 0 0 1; 0 1 0],
    [1 0 0; 0 0 1; 0 1 0],
    [0 1 0; 0 0 1; 0 1 0],
    [1 1 0; 0 0 1; 0 1 0],
    [0 0 1; 0 0 1; 0 1 0],
    [1 0 1; 0 0 1; 0 1 0],
    [0 1 1; 0 0 1; 0 1 0],
    [1 1 1; 0 0 1; 0 1 0],
    [0 0 0; 1 0 1; 0 1 0],
    [1 0 0; 1 0 1; 0 1 0],
    [0 1 0; 1 0 1; 0 1 0],
    [1 1 0; 1 0 1; 0 1 0],
    [0 0 1; 1 0 1; 0 1 0],
    [1 0 1; 1 0 1; 0 1 0],
    [0 1 1; 1 0 1; 0 1 0],
    [1 1 1; 1 0 1; 0 1 0],
    [0 0 0; 0 1 1; 0 1 0],
    [1 0 0; 0 1 1; 0 1 0],
    [0 1 0; 0 1 1; 0 1 0],
    [1 1 0; 0 1 1; 0 1 0],
    [0 0 1; 0 1 1; 0 1 0],
    [1 0 1; 0 1 1; 0 1 0],
    [0 1 1; 0 1 1; 0 1 0],
    [1 1 1; 0 1 1; 0 1 0],
    [0 0 0; 1 1 1; 0 1 0],
    [1 0 0; 1 1 1; 0 1 0],
    [0 1 0; 1 1 1; 0 1 0],
    [1 1 0; 1 1 1; 0 1 0],
    [0 0 1; 1 1 1; 0 1 0],
    [1 0 1; 1 1 1; 0 1 0],
    [0 1 1; 1 1 1; 0 1 0],
    [1 1 1; 1 1 1; 0 1 0],
    [0 0 0; 0 0 0; 1 1 0],
    [1 0 0; 0 0 0; 1 1 0],
    [0 1 0; 0 0 0; 1 1 0],
    [1 1 0; 0 0 0; 1 1 0],
    [0 0 1; 0 0 0; 1 1 0],
    [1 0 1; 0 0 0; 1 1 0],
    [0 1 1; 0 0 0; 1 1 0],
    [1 1 1; 0 0 0; 1 1 0],
    [0 0 0; 1 0 0; 1 1 0],
    [1 0 0; 1 0 0; 1 1 0],
    [0 1 0; 1 0 0; 1 1 0],
    [1 1 0; 1 0 0; 1 1 0],
    [0 0 1; 1 0 0; 1 1 0],
    [1 0 1; 1 0 0; 1 1 0],
    [0 1 1; 1 0 0; 1 1 0],
    [1 1 1; 1 0 0; 1 1 0],
    [0 0 0; 0 1 0; 1 1 0],
    [1 0 0; 0 1 0; 1 1 0],
    [0 1 0; 0 1 0; 1 1 0],
    [1 1 0; 0 1 0; 1 1 0],
    [0 0 1; 0 1 0; 1 1 0],
    [1 0 1; 0 1 0; 1 1 0],
    [0 1 1; 0 1 0; 1 1 0],
    [1 1 1; 0 1 0; 1 1 0],
    [0 0 0; 1 1 0; 1 1 0],
    [1 0 0; 1 1 0; 1 1 0],
    [0 1 0; 1 1 0; 1 1 0],
    [1 1 0; 1 1 0; 1 1 0],
    [0 0 1; 1 1 0; 1 1 0],
    [1 0 1; 1 1 0; 1 1 0],
    [0 1 1; 1 1 0; 1 1 0],
    [1 1 1; 1 1 0; 1 1 0],
    [0 0 0; 0 0 1; 1 1 0],
    [1 0 0; 0 0 1; 1 1 0],
    [0 1 0; 0 0 1; 1 1 0],
    [1 1 0; 0 0 1; 1 1 0],
    [0 0 1; 0 0 1; 1 1 0],
    [1 0 1; 0 0 1; 1 1 0],
    [0 1 1; 0 0 1; 1 1 0],
    [1 1 1; 0 0 1; 1 1 0],
    [0 0 0; 1 0 1; 1 1 0],
    [1 0 0; 1 0 1; 1 1 0],
    [0 1 0; 1 0 1; 1 1 0],
    [1 1 0; 1 0 1; 1 1 0],
    [0 0 1; 1 0 1; 1 1 0],
    [1 0 1; 1 0 1; 1 1 0],
    [0 1 1; 1 0 1; 1 1 0],
    [1 1 1; 1 0 1; 1 1 0],
    [0 0 0; 0 1 1; 1 1 0],
    [1 0 0; 0 1 1; 1 1 0],
    [0 1 0; 0 1 1; 1 1 0],
    [1 1 0; 0 1 1; 1 1 0],
    [0 0 1; 0 1 1; 1 1 0],
    [1 0 1; 0 1 1; 1 1 0],
    [0 1 1; 0 1 1; 1 1 0],
    [1 1 1; 0 1 1; 1 1 0],
    [0 0 0; 1 1 1; 1 1 0],
    [1 0 0; 1 1 1; 1 1 0],
    [0 1 0; 1 1 1; 1 1 0],
    [1 1 0; 1 1 1; 1 1 0],
    [0 0 1; 1 1 1; 1 1 0],
    [1 0 1; 1 1 1; 1 1 0],
    [0 1 1; 1 1 1; 1 1 0],
    [1 1 1; 1 1 1; 1 1 0],
    [0 0 0; 0 0 0; 0 0 1],
    [1 0 0; 0 0 0; 0 0 1],
    [0 1 0; 0 0 0; 0 0 1],
    [1 1 0; 0 0 0; 0 0 1],
    [0 0 1; 0 0 0; 0 0 1],
    [1 0 1; 0 0 0; 0 0 1],
    [0 1 1; 0 0 0; 0 0 1],
    [1 1 1; 0 0 0; 0 0 1],
    [0 0 0; 1 0 0; 0 0 1],
    [1 0 0; 1 0 0; 0 0 1],
    [0 1 0; 1 0 0; 0 0 1],
    [1 1 0; 1 0 0; 0 0 1],
    [0 0 1; 1 0 0; 0 0 1],
    [1 0 1; 1 0 0; 0 0 1],
    [0 1 1; 1 0 0; 0 0 1],
    [1 1 1; 1 0 0; 0 0 1],
    [0 0 0; 0 1 0; 0 0 1],
    [1 0 0; 0 1 0; 0 0 1],
    [0 1 0; 0 1 0; 0 0 1],
    [1 1 0; 0 1 0; 0 0 1],
    [0 0 1; 0 1 0; 0 0 1],
    [1 0 1; 0 1 0; 0 0 1],
    [0 1 1; 0 1 0; 0 0 1],
    [1 1 1; 0 1 0; 0 0 1],
    [0 0 0; 1 1 0; 0 0 1],
    [1 0 0; 1 1 0; 0 0 1],
    [0 1 0; 1 1 0; 0 0 1],
    [1 1 0; 1 1 0; 0 0 1],
    [0 0 1; 1 1 0; 0 0 1],
    [1 0 1; 1 1 0; 0 0 1],
    [0 1 1; 1 1 0; 0 0 1],
    [1 1 1; 1 1 0; 0 0 1],
    [0 0 0; 0 0 1; 0 0 1],
    [1 0 0; 0 0 1; 0 0 1],
    [0 1 0; 0 0 1; 0 0 1],
    [1 1 0; 0 0 1; 0 0 1],
    [0 0 1; 0 0 1; 0 0 1],
    [1 0 1; 0 0 1; 0 0 1],
    [0 1 1; 0 0 1; 0 0 1],
    [1 1 1; 0 0 1; 0 0 1],
    [0 0 0; 1 0 1; 0 0 1],
    [1 0 0; 1 0 1; 0 0 1],
    [0 1 0; 1 0 1; 0 0 1],
    [1 1 0; 1 0 1; 0 0 1],
    [0 0 1; 1 0 1; 0 0 1],
    [1 0 1; 1 0 1; 0 0 1],
    [0 1 1; 1 0 1; 0 0 1],
    [1 1 1; 1 0 1; 0 0 1],
    [0 0 0; 0 1 1; 0 0 1],
    [1 0 0; 0 1 1; 0 0 1],
    [0 1 0; 0 1 1; 0 0 1],
    [1 1 0; 0 1 1; 0 0 1],
    [0 0 1; 0 1 1; 0 0 1],
    [1 0 1; 0 1 1; 0 0 1],
    [0 1 1; 0 1 1; 0 0 1],
    [1 1 1; 0 1 1; 0 0 1],
    [0 0 0; 1 1 1; 0 0 1],
    [1 0 0; 1 1 1; 0 0 1],
    [0 1 0; 1 1 1; 0 0 1],
    [1 1 0; 1 1 1; 0 0 1],
    [0 0 1; 1 1 1; 0 0 1],
    [1 0 1; 1 1 1; 0 0 1],
    [0 1 1; 1 1 1; 0 0 1],
    [1 1 1; 1 1 1; 0 0 1],
    [0 0 0; 0 0 0; 1 0 1],
    [1 0 0; 0 0 0; 1 0 1],
    [0 1 0; 0 0 0; 1 0 1],
    [1 1 0; 0 0 0; 1 0 1],
    [0 0 1; 0 0 0; 1 0 1],
    [1 0 1; 0 0 0; 1 0 1],
    [0 1 1; 0 0 0; 1 0 1],
    [1 1 1; 0 0 0; 1 0 1],
    [0 0 0; 1 0 0; 1 0 1],
    [1 0 0; 1 0 0; 1 0 1],
    [0 1 0; 1 0 0; 1 0 1],
    [1 1 0; 1 0 0; 1 0 1],
    [0 0 1; 1 0 0; 1 0 1],
    [1 0 1; 1 0 0; 1 0 1],
    [0 1 1; 1 0 0; 1 0 1],
    [1 1 1; 1 0 0; 1 0 1],
    [0 0 0; 0 1 0; 1 0 1],
    [1 0 0; 0 1 0; 1 0 1],
    [0 1 0; 0 1 0; 1 0 1],
    [1 1 0; 0 1 0; 1 0 1],
    [0 0 1; 0 1 0; 1 0 1],
    [1 0 1; 0 1 0; 1 0 1],
    [0 1 1; 0 1 0; 1 0 1],
    [1 1 1; 0 1 0; 1 0 1],
    [0 0 0; 1 1 0; 1 0 1],
    [1 0 0; 1 1 0; 1 0 1],
    [0 1 0; 1 1 0; 1 0 1],
    [1 1 0; 1 1 0; 1 0 1],
    [0 0 1; 1 1 0; 1 0 1],
    [1 0 1; 1 1 0; 1 0 1],
    [0 1 1; 1 1 0; 1 0 1],
    [1 1 1; 1 1 0; 1 0 1],
    [0 0 0; 0 0 1; 1 0 1],
    [1 0 0; 0 0 1; 1 0 1],
    [0 1 0; 0 0 1; 1 0 1],
    [1 1 0; 0 0 1; 1 0 1],
    [0 0 1; 0 0 1; 1 0 1],
    [1 0 1; 0 0 1; 1 0 1],
    [0 1 1; 0 0 1; 1 0 1],
    [1 1 1; 0 0 1; 1 0 1],
    [0 0 0; 1 0 1; 1 0 1],
    [1 0 0; 1 0 1; 1 0 1],
    [0 1 0; 1 0 1; 1 0 1],
    [1 1 0; 1 0 1; 1 0 1],
    [0 0 1; 1 0 1; 1 0 1],
    [1 0 1; 1 0 1; 1 0 1],
    [0 1 1; 1 0 1; 1 0 1],
    [1 1 1; 1 0 1; 1 0 1],
    [0 0 0; 0 1 1; 1 0 1],
    [1 0 0; 0 1 1; 1 0 1],
    [0 1 0; 0 1 1; 1 0 1],
    [1 1 0; 0 1 1; 1 0 1],
    [0 0 1; 0 1 1; 1 0 1],
    [1 0 1; 0 1 1; 1 0 1],
    [0 1 1; 0 1 1; 1 0 1],
    [1 1 1; 0 1 1; 1 0 1],
    [0 0 0; 1 1 1; 1 0 1],
    [1 0 0; 1 1 1; 1 0 1],
    [0 1 0; 1 1 1; 1 0 1],
    [1 1 0; 1 1 1; 1 0 1],
    [0 0 1; 1 1 1; 1 0 1],
    [1 0 1; 1 1 1; 1 0 1],
    [0 1 1; 1 1 1; 1 0 1],
    [1 1 1; 1 1 1; 1 0 1],
    [0 0 0; 0 0 0; 0 1 1],
    [1 0 0; 0 0 0; 0 1 1],
    [0 1 0; 0 0 0; 0 1 1],
    [1 1 0; 0 0 0; 0 1 1],
    [0 0 1; 0 0 0; 0 1 1],
    [1 0 1; 0 0 0; 0 1 1],
    [0 1 1; 0 0 0; 0 1 1],
    [1 1 1; 0 0 0; 0 1 1],
    [0 0 0; 1 0 0; 0 1 1],
    [1 0 0; 1 0 0; 0 1 1],
    [0 1 0; 1 0 0; 0 1 1],
    [1 1 0; 1 0 0; 0 1 1],
    [0 0 1; 1 0 0; 0 1 1],
    [1 0 1; 1 0 0; 0 1 1],
    [0 1 1; 1 0 0; 0 1 1],
    [1 1 1; 1 0 0; 0 1 1],
    [0 0 0; 0 1 0; 0 1 1],
    [1 0 0; 0 1 0; 0 1 1],
    [0 1 0; 0 1 0; 0 1 1],
    [1 1 0; 0 1 0; 0 1 1],
    [0 0 1; 0 1 0; 0 1 1],
    [1 0 1; 0 1 0; 0 1 1],
    [0 1 1; 0 1 0; 0 1 1],
    [1 1 1; 0 1 0; 0 1 1],
    [0 0 0; 1 1 0; 0 1 1],
    [1 0 0; 1 1 0; 0 1 1],
    [0 1 0; 1 1 0; 0 1 1],
    [1 1 0; 1 1 0; 0 1 1],
    [0 0 1; 1 1 0; 0 1 1],
    [1 0 1; 1 1 0; 0 1 1],
    [0 1 1; 1 1 0; 0 1 1],
    [1 1 1; 1 1 0; 0 1 1],
    [0 0 0; 0 0 1; 0 1 1],
    [1 0 0; 0 0 1; 0 1 1],
    [0 1 0; 0 0 1; 0 1 1],
    [1 1 0; 0 0 1; 0 1 1],
    [0 0 1; 0 0 1; 0 1 1],
    [1 0 1; 0 0 1; 0 1 1],
    [0 1 1; 0 0 1; 0 1 1],
    [1 1 1; 0 0 1; 0 1 1],
    [0 0 0; 1 0 1; 0 1 1],
    [1 0 0; 1 0 1; 0 1 1],
    [0 1 0; 1 0 1; 0 1 1],
    [1 1 0; 1 0 1; 0 1 1],
    [0 0 1; 1 0 1; 0 1 1],
    [1 0 1; 1 0 1; 0 1 1],
    [0 1 1; 1 0 1; 0 1 1],
    [1 1 1; 1 0 1; 0 1 1],
    [0 0 0; 0 1 1; 0 1 1],
    [1 0 0; 0 1 1; 0 1 1],
    [0 1 0; 0 1 1; 0 1 1],
    [1 1 0; 0 1 1; 0 1 1],
    [0 0 1; 0 1 1; 0 1 1],
    [1 0 1; 0 1 1; 0 1 1],
    [0 1 1; 0 1 1; 0 1 1],
    [1 1 1; 0 1 1; 0 1 1],
    [0 0 0; 1 1 1; 0 1 1],
    [1 0 0; 1 1 1; 0 1 1],
    [0 1 0; 1 1 1; 0 1 1],
    [1 1 0; 1 1 1; 0 1 1],
    [0 0 1; 1 1 1; 0 1 1],
    [1 0 1; 1 1 1; 0 1 1],
    [0 1 1; 1 1 1; 0 1 1],
    [1 1 1; 1 1 1; 0 1 1],
    [0 0 0; 0 0 0; 1 1 1],
    [1 0 0; 0 0 0; 1 1 1],
    [0 1 0; 0 0 0; 1 1 1],
    [1 1 0; 0 0 0; 1 1 1],
    [0 0 1; 0 0 0; 1 1 1],
    [1 0 1; 0 0 0; 1 1 1],
    [0 1 1; 0 0 0; 1 1 1],
    [1 1 1; 0 0 0; 1 1 1],
    [0 0 0; 1 0 0; 1 1 1],
    [1 0 0; 1 0 0; 1 1 1],
    [0 1 0; 1 0 0; 1 1 1],
    [1 1 0; 1 0 0; 1 1 1],
    [0 0 1; 1 0 0; 1 1 1],
    [1 0 1; 1 0 0; 1 1 1],
    [0 1 1; 1 0 0; 1 1 1],
    [1 1 1; 1 0 0; 1 1 1],
    [0 0 0; 0 1 0; 1 1 1],
    [1 0 0; 0 1 0; 1 1 1],
    [0 1 0; 0 1 0; 1 1 1],
    [1 1 0; 0 1 0; 1 1 1],
    [0 0 1; 0 1 0; 1 1 1],
    [1 0 1; 0 1 0; 1 1 1],
    [0 1 1; 0 1 0; 1 1 1],
    [1 1 1; 0 1 0; 1 1 1],
    [0 0 0; 1 1 0; 1 1 1],
    [1 0 0; 1 1 0; 1 1 1],
    [0 1 0; 1 1 0; 1 1 1],
    [1 1 0; 1 1 0; 1 1 1],
    [0 0 1; 1 1 0; 1 1 1],
    [1 0 1; 1 1 0; 1 1 1],
    [0 1 1; 1 1 0; 1 1 1],
    [1 1 1; 1 1 0; 1 1 1],
    [0 0 0; 0 0 1; 1 1 1],
    [1 0 0; 0 0 1; 1 1 1],
    [0 1 0; 0 0 1; 1 1 1],
    [1 1 0; 0 0 1; 1 1 1],
    [0 0 1; 0 0 1; 1 1 1],
    [1 0 1; 0 0 1; 1 1 1],
    [0 1 1; 0 0 1; 1 1 1],
    [1 1 1; 0 0 1; 1 1 1],
    [0 0 0; 1 0 1; 1 1 1],
    [1 0 0; 1 0 1; 1 1 1],
    [0 1 0; 1 0 1; 1 1 1],
    [1 1 0; 1 0 1; 1 1 1],
    [0 0 1; 1 0 1; 1 1 1],
    [1 0 1; 1 0 1; 1 1 1],
    [0 1 1; 1 0 1; 1 1 1],
    [1 1 1; 1 0 1; 1 1 1],
    [0 0 0; 0 1 1; 1 1 1],
    [1 0 0; 0 1 1; 1 1 1],
    [0 1 0; 0 1 1; 1 1 1],
    [1 1 0; 0 1 1; 1 1 1],
    [0 0 1; 0 1 1; 1 1 1],
    [1 0 1; 0 1 1; 1 1 1],
    [0 1 1; 0 1 1; 1 1 1],
    [1 1 1; 0 1 1; 1 1 1],
    [0 0 0; 1 1 1; 1 1 1],
    [1 0 0; 1 1 1; 1 1 1],
    [0 1 0; 1 1 1; 1 1 1],
    [1 1 0; 1 1 1; 1 1 1],
    [0 0 1; 1 1 1; 1 1 1],
    [1 0 1; 1 1 1; 1 1 1],
    [0 1 1; 1 1 1; 1 1 1],
    [1 1 1; 1 1 1; 1 1 1]
    }
    all_probas = map((x) -> motif_p(A, float(x)), possible_motifs)
    @test_approx_eq sum(all_probas) 1.0
  end

end
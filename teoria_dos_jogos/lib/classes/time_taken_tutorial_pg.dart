class PGTimeTutorial {
  int? userId;
  Duration total = Duration();
  Duration main = Duration();
  Duration distribution = Duration();
  Duration election = Duration();
  int sawMain = 1;
  int sawDistribution = 1;
  int sawElection = 1;

  setMain(Duration duration) {
    main = duration;
  }

  setDistribution(Duration duration) {
    distribution = duration;
  }

  setElection(Duration duration) {
    election = duration;
  }

  sawMainCountUp() {
    sawMain++;
  }

  sawDistributionCountUp() {
    sawDistribution++;
  }

  sawElectionCountUp() {
    sawElection++;
  }
}

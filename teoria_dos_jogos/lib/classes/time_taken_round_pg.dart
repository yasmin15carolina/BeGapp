class PGTimeRound {
  int? userId;
  int? round;
  Duration dragToken = Duration();
  Duration distribution = Duration();
  Duration election = Duration();

  setDragToken(Duration duration) {
    dragToken = duration;
  }

  setDistribution(Duration duration) {
    distribution = duration;
  }

  setElection(Duration duration) {
    election = duration;
  }
}

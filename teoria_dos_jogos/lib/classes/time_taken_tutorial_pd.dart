class PDTimeTutorial {
  int? userId;
  Duration total = Duration();
  Duration tutorial = Duration();
  Duration distribution = Duration();
  Duration election = Duration();
  int sawTutorial = 1;
  int sawDistribution = 1;
  int sawElection = 1;

  setTutorial(Duration duration) {
    tutorial = duration;
  }

  sawTutorialCountUp() {
    sawTutorial++;
  }
}

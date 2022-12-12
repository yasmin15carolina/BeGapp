import 'package:mobx/mobx.dart';
part 'runningNumbers.g.dart';

class RunningNumbers = _RunningNumbersBase with _$RunningNumbers;

abstract class _RunningNumbersBase with Store {
  @observable  
  bool start;
  @observable
  bool down;
  @observable
  int inicial;
  @observable
  int diference;
  @observable
  int factor;

  _RunningNumbersBase(this.start,this.down,this.inicial,this.diference,this.factor);

  @action
  startCountUp(){
    this.down=false;
    this.start = true;
  }

  @action
  startCountDown(){
    this.down=true;
    this.start = true;
  }

  @action
  stop(){
    this.start = false;
    this.inicial=0;
    this.diference=0;
  }

  @action
  setValues(final int inicial,final int diference){
    this.inicial = inicial;
    this.diference = diference;
  }
}
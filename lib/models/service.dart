class SchedulingApiAppRequest{
  String fkService = '';
  String start = '';
  String fkClient = '';
  String fkEmployee = '';
  String fkCity = '';

  String get service => fkService;
  
  set service(String value) {
    if (value != null && value.isNotEmpty) {
      fkService = value;
    }
  }

  String get begin => start;
  
  set begin(String value) {
    if (value != null && value.isNotEmpty) {
      start = value;
    }
  }
  String get client => fkClient;
  
  set client(String value) {
    if (value != null && value.isNotEmpty) {
      fkClient = value;
    }
  }

  String get funcionario => fkEmployee;
  
  set funcionario(String value) {
    if (value != null && value.isNotEmpty) {
      fkEmployee = value;
    }
  }

  String get city => fkCity;
  
  set city(String value) {
    if (value != null && value.isNotEmpty) {
      fkCity = value;
    }
  }
    
}



getLanguage(String languageCode){
  switch (languageCode) {
    case 'en' :
      return 'English';
    case 'hi' :
      return 'Hindi';
    case 'ko':
      return 'Korean';
    case 'ja':
      return 'Japanese';
    default :
      return 'English';
  }
}
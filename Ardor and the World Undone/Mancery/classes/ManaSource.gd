class_name ManaSource extends Object

enum Medium {DOMAIN,STUDY,INNATE,COLLECTIVE,ARTIFACT}

class Domain:
	enum {}

class Study:
	enum {}

class Innate:
	enum {}

class Collective:
	enum {}

class ARTIFACT:
	enum {}


static func confess(index : int) -> String:
	return Medium.find_key(index).capitalize()

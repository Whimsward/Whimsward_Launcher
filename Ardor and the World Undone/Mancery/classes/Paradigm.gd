class_name Alignment extends Resource

enum Paradigm {ASSOCIATION,EXTENSION,DOMINATION,EDIFICATION,SEPARATION}
@export var aligned : Paradigm


static func confess(index : int) -> String:
	return Make.confess(Paradigm,index)

static func track_alignment(para):
	if para is Paradigm:
		return para
	elif para is String:
		for p in Paradigm:
			if para == confess(p):
				return p
	elif para is int:
		return Paradigm[para]

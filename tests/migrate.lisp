;import system settings
(run 'apps/sys.inc)

;open farm of children
(defq ids (open-farm "tests/migrate_child" 128 kn_call_child))

;send msgs etc
(while (defq cpu (pop ids) mbox (pop ids))
	(if (ne mbox 0) (mail-send (char 10 long_size) mbox cpu)))

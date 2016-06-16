%include 'inc/func.inc'
%include 'class/class_stream.inc'

	fn_function class/stream/skip_not
		;inputs
		;r0 = stream object
		;r1 = char to not skip
		;trashes
		;all but r0, r4

		ptr inst
		ulong skip_char

		push_scope
		retire {r0, r1}, {inst, skip_char}

		loop_start
			if {inst->stream_bufp == inst->stream_bufe}
				method_call stream, read_next, {inst}
				gotoif {inst->stream_bufp == inst->stream_bufe}, exit
			endif
			breakif {*inst->stream_bufp == skip_char}
			assign {inst->stream_bufp + 1}, {inst->stream_bufp}
		loop_end
	exit:
		eval {inst}, {r0}
		pop_scope
		return

	fn_function_end

%include 'inc/func.inc'
%include 'class/class_stream.inc'

	fn_function class/stream/read_char
		;inputs
		;r0 = stream object
		;outputs
		;r0 = stream object
		;r1 = -1 for EOF, else char read
		;trashes
		;all but r0, r4

		ptr inst
		long char

		push_scope
		retire {r0}, {inst}

		switch
		case {inst->stream_bufp == inst->stream_bufe}
			method_call stream, read_next, {inst}
			assign {-1}, {char}
			breakif {inst->stream_bufp == inst->stream_bufe}
		default
			assign {*inst->stream_bufp}, {char}
			assign {inst->stream_bufp + 1}, {inst->stream_bufp}
		endswitch

		eval {inst, char}, {r0, r1}
		pop_scope
		return

	fn_function_end

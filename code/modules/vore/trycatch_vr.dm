/*
This file is for jamming single-line procs into Polaris procs.
It will prevent runtimes and allow their code to run if VOREStation's fails.
It will also log when we mess up our code rather than making it vague.

Call it at the top of a stock proc with...

if(attempt_vr(object,proc to call,args)) return

...if you are replacing an entire proc.

The proc you're attemping should return nonzero values on success.
*/

/proc/attempt_vr(callon, procname, list/args=null)
	if(!callon || !procname)
		stack_trace("attempt_vr: Invalid obj/proc: [callon]/[procname]")
		return FALSE

	var/result = call(callon,procname)(arglist(args))

	return result

/*
This is the _vr version of calling hooks.
It's meant to have different messages, and also the try/catch block.
For when you want hooks and want to know when you ruin everything,
vs when Polaris ruins everything.

Call it at the top of a stock proc with...

if(hook_vr(proc,args)) return

...if you are replacing an entire proc.

The hooks you're calling should return nonzero values on success.
*/
/proc/hook_vr(hook, list/args=null)
	var/hook_path = text2path("/hook/[hook]")
	if(!hook_path)
		stack_trace("hook_vr: Invalid hook '/hook/[hook]' called.")
		return FALSE

	var/caller = new hook_path
	var/status = TRUE
	for(var/P in typesof("[hook_path]/proc"))
		if(!call(caller, P)(arglist(args)))
			stack_trace("hook_vr: Hook '[P]' failed or runtimed.")
			status = FALSE

	return status


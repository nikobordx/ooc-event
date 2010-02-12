use event

include event | (__USE_BSD)

BufferCB: cover from evbuffercb

Base: cover from struct event_base* {
    new: extern(event_base_new) static func -> Base
    reinit: extern(event_reinit) func -> Int
    dispatch: extern(event_base_dispatch) func -> Int
    getMethod: extern(event_base_get_method) func -> Char*
    free: extern(event_base_free) func
    set: extern(event_base_set) func (arg1: Event) -> Int
    loop: extern(event_base_loop) func (arg1: Int) -> Int
    loopExit: extern(event_base_loopexit) func (arg1: StructTimeval*) -> Int
    loopBreak: extern(event_base_loopbreak) func -> Int
    once: extern(event_base_once) func (fd: Int, events: Short, callback: Func, arg: Void*, timeout: StructTimeval*) -> Int
    priorityInit: extern(event_base_priority_init) func (arg1: Int) -> Int
    bufferset: extern(bufferevent_base_set) func (bufev: BufferEvent) -> Int
}

Buffer: cover from struct evbuffer* {
    new: extern(evbuffer_new) static func -> Buffer
    free: extern(evbuffer_free) func
    expand: extern(evbuffer_expand) func (arg1: SizeT) -> Int
    add: extern(evbuffer_add) func (arg1: Void*, arg2: SizeT) -> Int
    remove: extern(evbuffer_remove) func (arg1: Void*, arg2: SizeT) -> Int
    readline: extern(evbuffer_readline) func -> Char*
    addBuffer: extern(evbuffer_add_buffer) func (arg1: Buffer) -> Int
    addPrintf: extern(evbuffer_add_printf) func (fmt: Char*, ...) -> Int
    addVprintf: extern(evbuffer_add_vprintf) func (fmt: Char*, ap: VaList) -> Int
    drain: extern(evbuffer_drain) func (arg1: SizeT)
    write: extern(evbuffer_write) func (arg1: Int) -> Int
    read: extern(evbuffer_read) func (arg1: Int, arg2: Int) -> Int
    find: extern(evbuffer_find) func (arg1: UChar*, arg2: SizeT) -> UChar*
    setcb: extern(evbuffer_setcb) func (arg1: Func, arg2: Void*)
    init: extern(evtag_init) func
    marshal: extern(evtag_marshal) func (tag: UInt32, data: Void*, len: UInt32)
    encodeInt: extern(encode_int) func (number: UInt32)
    marshalInt: extern(evtag_marshal_int) func (tag: UInt32, integer: UInt32)
    marshalString: extern(evtag_marshal_string) func (tag: UInt32, string: Char*)
    marshalTimeval: extern(evtag_marshal_timeval) func (tag: UInt32, tv: StructTimeval*)
    unmarshal: extern(evtag_unmarshal) func (ptag: UInt32*, dst: Buffer) -> Int
    peek: extern(evtag_peek) func (ptag: UInt32*) -> Int
    peekLength: extern(evtag_peek_length) func (plength: UInt32*) -> Int
    payloadLength: extern(evtag_payload_length) func (plength: UInt32*) -> Int
    consume: extern(evtag_consume) func -> Int
    unmarshalInt: extern(evtag_unmarshal_int) func (needTag: UInt32, pinteger: UInt32*) -> Int
    unmarshalFixed: extern(evtag_unmarshal_fixed) func (needTag: UInt32, data: Void*, len: SizeT) -> Int
    unmarshalString: extern(evtag_unmarshal_string) func (needTag: UInt32, pstring: Char**) -> Int
    unmarshalTimeval: extern(evtag_unmarshal_timeval) func (needTag: UInt32, ptv: StructTimeval*) -> Int
}

BufferEvent: cover from struct bufferevent* {
    new: extern(bufferevent_new) static func (fd: Int, readcb: BufferCB, writecb: BufferCB, errorcb: ErrorCB, cbarg: Void*) -> BufferEvent
    prioritySet: extern(bufferevent_priority_set) func (pri: Int) -> Int
    free: extern(bufferevent_free) func
    setcb: extern(bufferevent_setcb) func (readcb: BufferCB, writecb: BufferCB, errorcb: ErrorCB, cbarg: Void*)
    setfd: extern(bufferevent_setfd) func (fd: Int)
    write: extern(bufferevent_write) func (data: Void*, size: SizeT) -> Int
    writeBuffer: extern(bufferevent_write_buffer) func (buf: Buffer) -> Int
    read: extern(bufferevent_read) func (data: Void*, size: SizeT) -> SizeT
    enable: extern(bufferevent_enable) func (event: Short) -> Int
    disable: extern(bufferevent_disable) func (event: Short) -> Int
    settimeout: extern(bufferevent_settimeout) func (timeoutRead: Int, timeoutWrite: Int)
    setwatermark: extern(bufferevent_setwatermark) func (events: Short, lowmark: SizeT, highmark: SizeT)
}

ErrorCB: cover from everrorcb

Event: cover from struct event* {
    set: extern(event_set) func (arg1: Int, arg2: Short, arg3: Func, arg4: Void*)
    add: extern(event_add) func (timeout: StructTimeval*) -> Int
    del: extern(event_del) func -> Int
    active: extern(event_active) func (arg1: Int, arg2: Short)
    pending: extern(event_pending) func (event: Short, tv: StructTimeval*) -> Int
    prioritySet: extern(event_priority_set) func (arg1: Int) -> Int
}

StructTimeval: cover from struct timeval

StructEventBase: cover from struct event_base

StructEvent: cover from struct event

StructEvkeyval: cover from struct evkeyval {
/*    next: extern struct !None TODO: no support for structs-in-structs yet */
    key: extern Char*
    value: extern Char*
}

StructEventList: cover from struct event_list

StructEvkeyvalq: cover from struct evkeyvalq

EventLogCb: cover from Func

StructEvbuffer: cover from struct evbuffer

StructBufferevent: cover from struct bufferevent

StructEventWatermark: cover from struct event_watermark

socketpair: extern(evutil_socketpair) func (d: Int, type: Int, protocol: Int, sv: Int[]) -> Int
makeSocketNonblocking: extern(evutil_make_socket_nonblocking) func (sock: Int) -> Int
strtoll: extern(evutil_strtoll) func (s: Char*, endptr: Char**, base: Int) -> Int64
snprintf: extern(evutil_snprintf) func (buf: Char*, buflen: SizeT, format: Char*, ...) -> Int
vsnprintf: extern(evutil_vsnprintf) func (buf: Char*, buflen: SizeT, format: Char*, ap: VaList) -> Int
init: extern(event_init) func -> Base
dispatch: extern(event_dispatch) func -> Int
setLogCallback: extern(event_set_log_callback) func (cb: EventLogCb)
loop: extern(event_loop) func (arg0: Int) -> Int
loopExit: extern(event_loopexit) func (arg0: StructTimeval*) -> Int
loopBreak: extern(event_loopbreak) func -> Int
once: extern(event_once) func (arg0: Int, arg1: Short, arg2: Func, arg3: Void*, arg4: StructTimeval*) -> Int
getVersion: extern(event_get_version) func -> Char*
getMethod: extern(event_get_method) func -> Char*
priorityInit: extern(event_priority_init) func (arg0: Int) -> Int


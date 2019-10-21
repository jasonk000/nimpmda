import posix

type
  pmID* = cuint
  pmInDom* = cuint
  pmUnits* {.bycopy.} = object
    pad* {.bitsize: 8.}: cuint
    scaleCount* {.bitsize: 4.}: cint
    scaleTime* {.bitsize: 4.}: cuint
    scaleSpace* {.bitsize: 4.}: cuint
    dimCount* {.bitsize: 4.}: cint
    dimTime* {.bitsize: 4.}: cint
    dimSpace* {.bitsize: 4.}: cint

  pmDesc* {.bycopy.} = object
    pmid*: pmID
    `type`*: cint
    indom*: pmInDom
    sem*: cint
    units*: pmUnits


proc pmErrStr*(a1: cint): cstring {.importc.}
proc pmErrStr_r*(a1: cint; a2: cstring; a3: cint): cstring {.importc.}
proc pmLoadNameSpace*(a1: cstring): cint {.importc.}
proc pmLoadASCIINameSpace*(a1: cstring; a2: cint): cint {.importc.}
proc pmUnloadNameSpace*() {.importc.}
proc pmGetPMNSLocation*(): cint {.importc.}
proc pmTrimNameSpace*(): cint {.importc.}
proc pmLookupName*(a1: cint; a2: cstringArray; a3: ptr pmID): cint {.importc.}
proc pmGetChildren*(a1: cstring; a2: ptr cstringArray): cint {.importc.}
proc pmGetChildrenStatus*(a1: cstring; a2: ptr cstringArray; a3: ptr ptr cint): cint {.importc.}
proc pmNameID*(a1: pmID; a2: cstringArray): cint {.importc.}
proc pmNameAll*(a1: pmID; a2: ptr cstringArray): cint {.importc.}
proc pmTraversePMNS*(a1: cstring; a2: proc (a1: cstring)): cint {.importc.}
proc pmTraversePMNS_r*(a1: cstring; a2: proc (a1: cstring; a2: pointer); a3: pointer): cint {.importc.}
proc pmLookupDesc*(a1: pmID; a2: ptr pmDesc): cint {.importc.}
proc pmLookupInDom*(a1: pmInDom; a2: cstring): cint {.importc.}
proc pmLookupInDomArchive*(a1: pmInDom; a2: cstring): cint {.importc.}
proc pmNameInDom*(a1: pmInDom; a2: cint; a3: cstringArray): cint {.importc.}
proc pmNameInDomArchive*(a1: pmInDom; a2: cint; a3: cstringArray): cint {.importc.}
proc pmGetInDom*(a1: pmInDom; a2: ptr ptr cint; a3: ptr cstringArray): cint {.importc.}
proc pmGetInDomArchive*(a1: pmInDom; a2: ptr ptr cint; a3: ptr cstringArray): cint {.importc.}
proc pmGetContextHostName*(a1: cint): cstring {.importc.}
proc pmGetContextHostName_r*(a1: cint; a2: cstring; a3: cint): cstring {.importc.}
proc pmWhichContext*(): cint {.importc.}
proc pmDestroyContext*(a1: cint): cint {.importc.}
proc pmNewContext*(a1: cint; a2: cstring): cint {.importc.}
proc pmDupContext*(): cint {.importc.}
proc pmUseContext*(a1: cint): cint {.importc.}
proc pmReconnectContext*(a1: cint): cint {.importc.}
proc pmAddProfile*(a1: pmInDom; a2: cint; a3: ptr cint): cint {.importc.}
proc pmDelProfile*(a1: pmInDom; a2: cint; a3: ptr cint): cint {.importc.}
type
  pmInDomProfile* {.bycopy.} = object
    indom*: pmInDom
    state*: cint
    instances_len*: cint
    instances*: ptr cint

  pmProfile* {.bycopy.} = object
    state*: cint
    profile_len*: cint
    profile*: ptr pmInDomProfile

  pmInResult* {.bycopy.} = object
    indom*: pmInDom
    numinst*: cint
    instlist*: ptr cint
    namelist*: cstringArray

  INNER_C_UNION_pmapi_189* {.bycopy.} = object {.union.}
    pval*: ptr pmValueBlock
    lval*: cint

  pmValueBlock* {.bycopy.} = object
    vlen* {.bitsize: 24.}: cuint
    vtype* {.bitsize: 8.}: cuint
    vbuf*: array[1, char]

  pmValue* {.bycopy.} = object
    inst*: cint
    value*: INNER_C_UNION_pmapi_189

  pmValueSet* {.bycopy.} = object
    pmid*: pmID
    numval*: cint
    valfmt*: cint
    vlist*: array[1, pmValue]

  pmResult* {.bycopy.} = object
    timestamp*: posix.Timeval
    numpmid*: cint
    vset*: array[1, ptr pmValueSet]

  pmHighResResult* {.bycopy.} = object
    timestamp*: posix.Timespec
    numpmid*: cint
    vset*: array[1, ptr pmValueSet]

  pmAtomValue* {.bycopy.} = object {.union.}
    l*: int32
    ul*: uint32
    ll*: int64
    ull*: uint64
    f*: cfloat
    d*: cdouble
    cp*: cstring
    vbp*: ptr pmValueBlock


proc pmFetch*(numpmid: cint; pmidlist: ptr pmID; result: ptr ptr pmResult): cint {.importc.}
proc pmFetchArchive*(a1: ptr ptr pmResult): cint {.importc.}
type
  pmLabel* {.bycopy.} = object
    name* {.bitsize: 16.}: cuint
    namelen* {.bitsize: 8.}: cuint
    flags* {.bitsize: 8.}: cuint
    value* {.bitsize: 16.}: cuint
    valuelen* {.bitsize: 16.}: cuint

  pmLabelSet* {.bycopy.} = object
    inst*: cuint
    nlabels*: cint
    json*: cstring
    jsonlen* {.bitsize: 16.}: cuint
    padding* {.bitsize: 15.}: cuint
    compound* {.bitsize: 1.}: cuint
    labels*: ptr pmLabel
    hash*: pointer

proc pmGetContextLabels*(a1: ptr ptr pmLabelSet): cint {.importc.}
proc pmGetDomainLabels*(a1: cint; a2: ptr ptr pmLabelSet): cint {.importc.}
proc pmGetInDomLabels*(a1: pmInDom; a2: ptr ptr pmLabelSet): cint {.importc.}
proc pmGetClusterLabels*(a1: pmID; a2: ptr ptr pmLabelSet): cint {.importc.}
proc pmGetItemLabels*(a1: pmID; a2: ptr ptr pmLabelSet): cint {.importc.}
proc pmGetInstancesLabels*(a1: pmInDom; a2: ptr ptr pmLabelSet): cint {.importc.}
proc pmLookupLabels*(a1: pmID; a2: ptr ptr pmLabelSet): cint {.importc.}
proc pmMergeLabels*(a1: cstringArray; a2: cint; a3: cstring; a4: cint): cint {.importc.}
proc pmMergeLabelSets*(a1: ptr ptr pmLabelSet; a2: cint; a3: cstring; a4: cint; filter: proc (
    a1: ptr pmLabel; a2: cstring; a3: pointer): cint; a6: pointer): cint {.importc.}
proc pmFreeLabelSets*(a1: ptr pmLabelSet; a2: cint) {.importc.}
type
  pmTimeval* {.bycopy.} = object
    tv_sec*: int32
    tv_usec*: int32

  pmTimespec* {.bycopy.} = object
    tv_sec*: int64
    tv_nsec*: int64

  pmLogLabel* {.bycopy.} = object
    ll_magic*: cint
    ll_pid*: posix.Pid
    ll_start*: posix.Timeval
    ll_hostname*: array[64, char]
    ll_tz*: array[40, char]


proc pmGetArchiveLabel*(a1: ptr pmLogLabel): cint {.importc.}
proc pmGetArchiveEnd*(a1: ptr posix.Timeval): cint {.importc.}
proc pmFreeResult*(a1: ptr pmResult) {.importc.}
proc pmExtractValue*(a1: cint; a2: ptr pmValue; a3: cint; a4: ptr pmAtomValue; a5: cint): cint {.importc.}
proc pmPrintValue*(a1: ptr FILE; a2: cint; a3: cint; a4: ptr pmValue; a5: cint) {.importc.}
proc pmConvScale*(a1: cint; a2: ptr pmAtomValue; a3: ptr pmUnits; a4: ptr pmAtomValue;
                 a5: ptr pmUnits): cint {.importc.}
proc pmSortInstances*(a1: ptr pmResult) {.importc.}
proc pmSetMode*(a1: cint; a2: ptr posix.Timeval; a3: cint): cint {.importc.}
proc pmStore*(a1: ptr pmResult): cint {.importc.}
proc pmLookupText*(a1: pmID; a2: cint; a3: cstringArray): cint {.importc.}
proc pmLookupInDomText*(a1: pmInDom; a2: cint; a3: cstringArray): cint {.importc.}
proc pmIDStr*(a1: pmID): cstring {.importc.}
proc pmIDStr_r*(a1: pmID; a2: cstring; a3: cint): cstring {.importc.}
proc pmInDomStr*(a1: pmInDom): cstring {.importc.}
proc pmInDomStr_r*(a1: pmInDom; a2: cstring; a3: cint): cstring {.importc.}
proc pmTypeStr*(a1: cint): cstring {.importc.}
proc pmTypeStr_r*(a1: cint; a2: cstring; a3: cint): cstring {.importc.}
proc pmSemStr*(a1: cint): cstring {.importc.}
proc pmSemStr_r*(a1: cint; a2: cstring; a3: cint): cstring {.importc.}
proc pmUnitsStr*(a1: ptr pmUnits): cstring {.importc.}
proc pmUnitsStr_r*(a1: ptr pmUnits; a2: cstring; a3: cint): cstring {.importc.}
proc pmAtomStr*(a1: ptr pmAtomValue; a2: cint): cstring {.importc.}
proc pmAtomStr_r*(a1: ptr pmAtomValue; a2: cint; a3: cstring; a4: cint): cstring {.importc.}
proc pmNumberStr*(a1: cdouble): cstring {.importc.}
proc pmNumberStr_r*(a1: cdouble; a2: cstring; a3: cint): cstring {.importc.}
proc pmEventFlagsStr*(a1: cint): cstring {.importc.}
proc pmEventFlagsStr_r*(a1: cint; a2: cstring; a3: cint): cstring {.importc.}
proc pmParseInterval*(a1: cstring; a2: ptr posix.Timeval; a3: cstringArray): cint {.importc.}
proc pmParseTimeWindow*(a1: cstring; a2: cstring; a3: cstring; a4: cstring;
                       a5: ptr posix.Timeval; a6: ptr posix.Timeval; a7: ptr posix.Timeval;
                       a8: ptr posix.Timeval; a9: ptr posix.Timeval; a10: cstringArray): cint {.importc.}
proc pmUseZone*(a1: cint): cint {.importc.}
proc pmNewZone*(a1: cstring): cint {.importc.}
proc pmNewContextZone*(): cint {.importc.}
proc pmWhichZone*(a1: cstringArray): cint {.importc.}
proc pmCtime*(a1: ptr posix.Time; a2: cstring): cstring {.importc.}
proc pmLocaltime*(a1: ptr posix.Time; a2: ptr posix.Tm): ptr posix.Tm {.importc.}
type
  pmMetricSpec* {.bycopy.} = object
    isarch*: cint
    source*: cstring
    metric*: cstring
    ninst*: cint
    inst*: array[1, cstring]


proc pmParseMetricSpec*(a1: cstring; a2: cint; a3: cstring; a4: ptr ptr pmMetricSpec;
                       a5: cstringArray): cint {.importc.}
proc pmFreeMetricSpec*(p: ptr pmMetricSpec) {.importc.}
## extern int pmprintf(const char *, ...) __attribute__ ((format (printf, 1,2)));

proc pmflush*(): cint {.importc.}
## extern int pmsprintf(char *, size_t, const char *, ...) __attribute__ ((format (printf, 3,4)));

proc pmGetConfig*(a1: cstring): cstring {.importc,noSideEffect.}
proc pmGetOptionalConfig*(a1: cstring): cstring {.importc.}
proc pmGetAPIConfig*(a1: cstring): cstring {.importc.}
proc pmGetVersion*(): cint {.importc.}
type
  pmOptionOverride* = proc (a1: cint; a2: ptr pmOptions): cint
  pmLongOptions* {.bycopy.} = object
    long_opt*: cstring
    has_arg*: cint
    short_opt*: cint
    argname*: cstring
    message*: cstring

  pmOptions* {.bycopy.} = object
    version*: cint
    flags*: cint
    short_options*: cstring
    long_options*: ptr pmLongOptions
    short_usage*: cstring
    override*: pmOptionOverride
    index*: cint
    optind*: cint
    opterr*: cint
    optopt*: cint
    optarg*: cstring
    initialized*: cint
    nextchar*: cstring
    ordering*: cint
    posixly_correct*: cint
    first_nonopt*: cint
    last_nonopt*: cint
    errors*: cint
    context*: cint
    nhosts*: cint
    narchives*: cint
    hosts*: cstringArray
    archives*: cstringArray
    start*: posix.Timeval
    finish*: posix.Timeval
    origin*: posix.Timeval
    interval*: posix.Timeval
    align_optarg*: cstring
    start_optarg*: cstring
    finish_optarg*: cstring
    origin_optarg*: cstring
    guiport_optarg*: cstring
    timezone*: cstring
    samples*: cint
    guiport*: cint
    padding*: cint
    guiflag* {.bitsize: 1.}: cuint
    tzflag* {.bitsize: 1.}: cuint
    nsflag* {.bitsize: 1.}: cuint
    Lflag* {.bitsize: 1.}: cuint
    zeroes* {.bitsize: 28.}: cuint


proc pmgetopt_r*(a1: cint; a2: cstringArray; a3: ptr pmOptions): cint {.importc.}
proc pmGetOptions*(a1: cint; a2: cstringArray; a3: ptr pmOptions): cint {.importc.}
proc pmGetContextOptions*(a1: cint; a2: ptr pmOptions): cint {.importc.}
proc pmUsageMessage*(a1: ptr pmOptions) {.importc.}
proc pmFreeOptions*(a1: ptr pmOptions) {.importc.}
proc pmLoadDerivedConfig*(a1: cstring): cint {.importc.}
proc pmRegisterDerivedMetric*(a1: cstring; a2: cstring; a3: cstringArray): cint {.importc.}
proc pmRegisterDerived*(a1: cstring; a2: cstring): cstring {.importc.}
proc pmDerivedErrStr*(): cstring {.importc.}
type
  pmEventParameter* {.bycopy.} = object
    ep_pmid*: pmID
    ep_len* {.bitsize: 24.}: cuint
    ep_type* {.bitsize: 8.}: cuint

  pmEventRecord* {.bycopy.} = object
    er_timestamp*: pmTimeval
    er_flags*: cuint
    er_nparams*: cint
    er_param*: array[1, pmEventParameter]

  pmHighResEventRecord* {.bycopy.} = object
    er_timestamp*: pmTimespec
    er_flags*: cuint
    er_nparams*: cint
    er_param*: array[1, pmEventParameter]

  pmEventArray* {.bycopy.} = object
    ea_len* {.bitsize: 24.}: cuint
    ea_type* {.bitsize: 8.}: cuint
    ea_nrecords*: cint
    ea_record*: array[1, pmEventRecord]

  pmHighResEventArray* {.bycopy.} = object
    ea_len* {.bitsize: 24.}: cuint
    ea_type* {.bitsize: 8.}: cuint
    ea_nrecords*: cint
    ea_record*: array[1, pmHighResEventRecord]


proc pmUnpackEventRecords*(a1: ptr pmValueSet; a2: cint; a3: ptr ptr ptr pmResult): cint {.importc.}
proc pmFreeEventResult*(a1: ptr ptr pmResult) {.importc.}
proc pmUnpackHighResEventRecords*(a1: ptr pmValueSet; a2: cint;
                                 a3: ptr ptr ptr pmHighResResult): cint {.importc.}
proc pmFreeHighResEventResult*(a1: ptr ptr pmHighResResult) {.importc.}
proc pmDiscoverServices*(a1: cstring; a2: cstring; a3: ptr cstringArray): cint {.importc.}
proc pmParseUnitsStr*(a1: cstring; a2: ptr pmUnits; a3: ptr cdouble; a4: cstringArray): cint {.importc.}
proc pmSetDebug*(a1: cstring): cint {.importc.}
proc pmClearDebug*(a1: cstring): cint {.importc.}
type
  pmdebugoptions_t* {.bycopy.} = object
    pdu*: cint
    fetch*: cint
    profile*: cint
    value*: cint
    context*: cint
    indom*: cint
    pdubuf*: cint
    log*: cint
    logmeta*: cint
    optfetch*: cint
    af*: cint
    appl0*: cint
    appl1*: cint
    appl2*: cint
    pmns*: cint
    libpmda*: cint
    timecontrol*: cint
    pmc*: cint
    derive*: cint
    lock*: cint
    interp*: cint
    config*: cint
    pmapi*: cint
    fault*: cint
    auth*: cint
    discovery*: cint
    attr*: cint
    http*: cint
    desperate*: cint
    deprecated*: cint
    exec*: cint
    labels*: cint
    series*: cint
    libweb*: cint
    appl3*: cint
    appl4*: cint
    appl5*: cint


var pmDebugOptions*: pmdebugoptions_t

proc pmSetProgname*(a1: cstring) {.importc.}
proc pmGetProgname*(): cstring {.importc.}
proc pmID_build*(a1: cuint; a2: cuint; a3: cuint): pmID {.importc.}
proc pmID_domain*(a1: pmID): cuint {.importc.}
proc pmID_cluster*(a1: pmID): cuint {.importc.}
proc pmID_item*(a1: pmID): cuint {.importc.}
proc pmInDom_build*(a1: cuint; a2: cuint): pmInDom {.importc.}
proc pmInDom_domain*(a1: pmInDom): cuint {.importc.}
proc pmInDom_serial*(a1: pmInDom): cuint {.importc.}
proc pmOpenLog*(a1: cstring; a2: cstring; a3: ptr FILE; a4: ptr cint): ptr FILE {.importc.}
proc pmNoMem*(a1: cstring; a2: csize; a3: cint) {.importc.}
proc pmNotifyErr*(priority: cint, message: cstring) {.importc,varargs.}

proc pmSyslog*(onoff: cint) {.importc.}
proc pmPrintDesc*(a1: ptr FILE; a2: ptr pmDesc) {.importc.}
proc pmPrintLabelSets*(a1: ptr FILE; a2: cint; a3: cint; a4: ptr pmLabelSet; a5: cint) {.importc.}
proc pmtimevalNow*(a1: ptr posix.Timeval) {.importc.}
proc pmtimevalInc*(a1: ptr posix.Timeval; a2: ptr posix.Timeval) {.importc.}
proc pmtimevalDec*(a1: ptr posix.Timeval; a2: ptr posix.Timeval) {.importc.}
proc pmtimevalAdd*(a1: ptr posix.Timeval; a2: ptr posix.Timeval): cdouble {.importc.}
proc pmtimevalSub*(a1: ptr posix.Timeval; a2: ptr posix.Timeval): cdouble {.importc.}
proc pmtimevalToReal*(a1: ptr posix.Timeval): cdouble {.importc.}
proc pmtimevalFromReal*(a1: cdouble; a2: ptr posix.Timeval) {.importc.}
proc pmPrintStamp*(a1: ptr FILE; a2: ptr posix.Timeval) {.importc.}
proc pmPrintHighResStamp*(a1: ptr FILE; a2: ptr posix.Timespec) {.importc.}
proc pmPathSeparator*(): cint {.importc.}
proc pmSetProcessIdentity*(a1: cstring): cint {.importc.}
proc pmGetUsername*(a1: cstringArray): cint {.importc.}
proc pmSpecLocalPMDA*(a1: cstring): cstring {.importc.}

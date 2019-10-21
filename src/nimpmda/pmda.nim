import pmapi
import posix
import libpcp

type
  pmdaIoType* = enum
    pmdaPipe, pmdaInet, pmdaUnix, pmdaUnknown, pmdaIPv6
  pmdaInstid* {.bycopy.} = object
    i_inst*: cint
    i_name*: cstring

  pmdaIndom* {.bycopy.} = object
    it_indom*: pmInDom
    it_numinst*: cint
    it_set*: ptr pmdaInstid

  pmdaMetric* {.bycopy.} = object
    m_user*: pointer
    m_desc*: pmDesc

  pmdaFetchCallBack* = proc (mdesc: ptr pmdaMetric; inst: cuint; avp: ptr pmAtomValue): cint {.cdecl.}


type
  pmdaResultCallBack* = proc (a1: ptr pmResult) {.cdecl.}
  pmdaCheckCallBack* = proc (): cint {.cdecl.}
  pmdaDoneCallBack* = proc () {.cdecl.}
  pmdaEndContextCallBack* = proc (context: cint) {.cdecl.}
  pmdaLabelCallBack* = proc (a1: pmInDom; a2: cuint; a3: ptr ptr pmLabelSet): cint {.cdecl.}
  pmdaExt* {.bycopy.} = object
    e_flags*: cuint
    e_ext*: pointer
    e_sockname*: cstring
    e_name*: cstring
    e_logfile*: cstring
    e_helptext*: cstring
    e_status*: cint
    e_infd*: cint
    e_outfd*: cint
    e_port*: cint
    e_singular*: cint
    e_ordinal*: cint
    e_direct*: cint
    e_domain*: cint
    e_nmetrics*: cint
    e_nindoms*: cint
    e_help*: cint
    e_prof*: ptr pmProfile
    e_io*: pmdaIoType
    e_indoms*: ptr pmdaIndom
    e_idp*: ptr pmdaIndom
    e_metrics*: ptr pmdaMetric
    e_resultCallBack*: pmdaResultCallBack
    e_fetchCallBack*: pmdaFetchCallBack
    e_checkCallBack*: pmdaCheckCallBack
    e_doneCallBack*: pmdaDoneCallBack
    e_context*: cint
    e_endCallBack*: pmdaEndContextCallBack
    e_labelCallBack*: pmdaLabelCallBack

  INNER_C_STRUCT_tmp_111* {.bycopy.} = object
    pmda_interface* {.bitsize: 8.}: cuint
    pmapi_version* {.bitsize: 8.}: cuint
    flags* {.bitsize: 16.}: cuint

  INNER_C_STRUCT_tmp_125* {.bycopy.} = object
    ext*: ptr pmdaExt
    profile*: proc (a1: ptr pmProfile; a2: ptr pmdaExt): cint {.cdecl.}
    fetch*: proc (numpmid: cint; pmidlist: ptr pmID; resp: ptr ptr pmResult; pmda: ptr pmdaExt): cint {.cdecl.}
    desc*: proc (a1: pmID; a2: ptr pmDesc; a3: ptr pmdaExt): cint {.cdecl.}
    instance*: proc (indom: pmInDom; foo: cint; bar: cstring; iresp: ptr ptr pmInResult;
                   pmda: ptr pmdaExt): cint {.cdecl.}
    text*: proc (a1: cint; a2: cint; a3: cstringArray; a4: ptr pmdaExt): cint {.cdecl.}
    store*: proc (result: ptr pmResult; pmda: ptr pmdaExt): cint {.cdecl.}

  INNER_C_STRUCT_tmp_141* {.bycopy.} = object
    ext*: ptr pmdaExt
    profile*: proc (a1: ptr pmProfile; a2: ptr pmdaExt): cint {.cdecl.}
    fetch*: proc (a1: cint; a2: ptr pmID; a3: ptr ptr pmResult; a4: ptr pmdaExt): cint {.cdecl.}
    desc*: proc (a1: pmID; a2: ptr pmDesc; a3: ptr pmdaExt): cint {.cdecl.}
    instance*: proc (a1: pmInDom; a2: cint; a3: cstring; a4: ptr ptr pmInResult;
                   a5: ptr pmdaExt): cint {.cdecl.}
    text*: proc (a1: cint; a2: cint; a3: cstringArray; a4: ptr pmdaExt): cint {.cdecl.}
    store*: proc (result: ptr pmResult; pmda: ptr pmdaExt): cint {.cdecl.}
    pmid*: proc (name: cstring; pmid: ptr pmID; pmda: ptr pmdaExt): cint {.cdecl.}
    name*: proc (pmid: pmID; nameset: ptr cstringArray; pmda: ptr pmdaExt): cint {.cdecl.}
    children*: proc (name: cstring; traverse: cint; offspring: ptr cstringArray; status: ptr ptr cint; pmda: ptr pmdaExt): cint {.cdecl.}

  INNER_C_STRUCT_tmp_158* {.bycopy.} = object
    ext*: ptr pmdaExt
    profile*: proc (a1: ptr pmProfile; a2: ptr pmdaExt): cint {.cdecl.}
    fetch*: proc (a1: cint; a2: ptr pmID; a3: ptr ptr pmResult; a4: ptr pmdaExt): cint {.cdecl.}
    desc*: proc (a1: pmID; a2: ptr pmDesc; a3: ptr pmdaExt): cint {.cdecl.}
    instance*: proc (a1: pmInDom; a2: cint; a3: cstring; a4: ptr ptr pmInResult;
                   a5: ptr pmdaExt): cint {.cdecl.}
    text*: proc (a1: cint; a2: cint; a3: cstringArray; a4: ptr pmdaExt): cint {.cdecl.}
    store*: proc (result: ptr pmResult; pmda: ptr pmdaExt): cint {.cdecl.}
    pmid*: proc (name: cstring; pmid: ptr pmID; pmda: ptr pmdaExt): cint {.cdecl.}
    name*: proc (pmid: pmID; nameset: ptr cstringArray; pmda: ptr pmdaExt): cint {.cdecl.}
    children*: proc (name: cstring; traverse: cint; offspring: ptr cstringArray; status: ptr ptr cint; pmda: ptr pmdaExt): cint {.cdecl.}
    attribute*: proc (context: cint; key: cint; value: cstring; length: cint; pmda: ptr pmdaExt): cint {.cdecl.}

  INNER_C_STRUCT_tmp_176* {.bycopy.} = object
    ext*: ptr pmdaExt
    profile*: proc (a1: ptr pmProfile; a2: ptr pmdaExt): cint {.cdecl.}
    fetch*: proc (a1: cint; a2: ptr pmID; a3: ptr ptr pmResult; a4: ptr pmdaExt): cint {.cdecl.}
    desc*: proc (a1: pmID; a2: ptr pmDesc; a3: ptr pmdaExt): cint {.cdecl.}
    instance*: proc (a1: pmInDom; a2: cint; a3: cstring; a4: ptr ptr pmInResult;
                   a5: ptr pmdaExt): cint {.cdecl.}
    text*: proc (a1: cint; a2: cint; a3: cstringArray; a4: ptr pmdaExt): cint {.cdecl.}
    store*: proc (result: ptr pmResult; pmda: ptr pmdaExt): cint {.cdecl.}
    pmid*: proc (name: cstring; pmid: ptr pmID; pmda: ptr pmdaExt): cint {.cdecl.}
    name*: proc (pmid: pmID; nameset: ptr cstringArray; pmda: ptr pmdaExt): cint {.cdecl.}
    children*: proc (name: cstring; traverse: cint; offspring: ptr cstringArray; status: ptr ptr cint; pmda: ptr pmdaExt): cint {.cdecl.}
    attribute*: proc (a1: cint; a2: cint; a3: cstring; a4: cint; a5: ptr pmdaExt): cint {.cdecl.}
    label*: proc (ident: cint; ltype: cint; lpp: ptr ptr pmLabelSet; pmda: ptr pmdaExt): cint {.cdecl.}

  INNER_C_UNION_tmp_124* {.bycopy.} = object {.union.}
    any*: INNER_C_STRUCT_tmp_125
    two*: INNER_C_STRUCT_tmp_125
    three*: INNER_C_STRUCT_tmp_125
    four*: INNER_C_STRUCT_tmp_141
    five*: INNER_C_STRUCT_tmp_141
    six*: INNER_C_STRUCT_tmp_158
    seven*: INNER_C_STRUCT_tmp_176

  pmdaInterface* {.bycopy.} = object
    domain*: cint
    comm*: INNER_C_STRUCT_tmp_111
    status*: cint
    version*: INNER_C_UNION_tmp_124

  pmDSO* {.bycopy.} = object
    domain*: cint
    name*: cstring
    init*: cstring
    handle*: pointer
    dispatch*: pmdaInterface

  pmdaOptionOverride* = proc (a1: cint; a2: ptr pmdaOptions): cint {.cdecl.}
  pmdaOptions* {.bycopy.} = object
    version*: cint
    flags*: cint
    short_options*: cstring
    long_options*: ptr pmLongOptions
    short_usage*: cstring
    override*: pmdaOptionOverride
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
    username*: cstring


proc pmdaGetOpt*(a1: cint; a2: cstringArray; a3: cstring; a4: ptr pmdaInterface;
                a5: ptr cint): cint {.importc.}
proc pmdaGetOptions*(a1: cint; a2: cstringArray; a3: ptr pmdaOptions;
                    a4: ptr pmdaInterface): cint {.importc.}
proc pmdaUsageMessage*(a1: ptr pmdaOptions) {.importc.}
proc pmdaDaemon*(dispatch: ptr pmdaInterface; intrface: cint; name: cstring; domain: cint; logfile: cstring; helptext: cstring) {.importc.}
proc pmdaDSO*(a1: ptr pmdaInterface; a2: cint; a3: cstring; a4: cstring) {.importc.}
proc pmdaOpenLog*(a1: ptr pmdaInterface) {.importc.}
proc pmdaExtGetData*(a1: ptr pmdaExt): pointer {.importc.}
proc pmdaExtSetData*(a1: ptr pmdaExt; a2: pointer) {.importc.}
proc pmdaSetData*(a1: ptr pmdaInterface; a2: pointer) {.importc.}
proc pmdaExtSetFlags*(a1: ptr pmdaExt; a2: cint) {.importc.}
proc pmdaSetFlags*(a1: ptr pmdaInterface; a2: cint) {.importc.}
proc pmdaSetCommFlags*(a1: ptr pmdaInterface; a2: cint) {.importc.}
proc pmdaInit*(dispatch: ptr pmdaInterface; indoms: ptr pmdaIndom; nindoms: cint; metrics: ptr pmdaMetric; nmetrics: cint) {.importc.}
proc pmdaConnect*(a1: ptr pmdaInterface) {.importc.}
proc pmdaMain*(dspatch: ptr pmdaInterface) {.importc.}
proc pmdaSendError*(a1: ptr pmdaInterface; a2: cint) {.importc.}
proc pmdaSetResultCallBack*(dispatch: ptr pmdaInterface; callback: pmdaResultCallBack) {.importc.}
proc pmdaSetFetchCallBack*(dispatch: ptr pmdaInterface; callback: pmdaFetchCallBack) {.importc.}
proc pmdaSetCheckCallBack*(dispatch: ptr pmdaInterface; callback: pmdaCheckCallBack) {.importc.}
proc pmdaSetDoneCallBack*(dispatch: ptr pmdaInterface; callback: pmdaDoneCallBack) {.importc.}
proc pmdaSetEndContextCallBack*(dispatch: ptr pmdaInterface; callback: pmdaEndContextCallBack) {.importc.}
proc pmdaSetLabelCallBack*(dispatch: ptr pmdaInterface; callback: pmdaLabelCallBack) {.importc.}
proc pmdaProfile*(a1: ptr pmProfile; a2: ptr pmdaExt): cint {.importc.}
proc pmdaFetch*(numpmid: cint; pmidlist: ptr pmID; resp: ptr ptr pmResult; pmda: ptr pmdaExt): cint {.importc,cdecl.}
proc pmdaInstance*(a1: pmInDom; a2: cint; a3: cstring; a4: ptr ptr pmInResult;
                  a5: ptr pmdaExt): cint {.importc.}
proc pmdaDesc*(a1: pmID; a2: ptr pmDesc; a3: ptr pmdaExt): cint {.importc.}
proc pmdaText*(a1: cint; a2: cint; a3: cstringArray; a4: ptr pmdaExt): cint {.importc.}
proc pmdaStore*(result: ptr pmResult; pmda: ptr pmdaExt): cint {.importc.}
proc pmdaPMID*(name: cstring; pmid: ptr pmID; pmda: ptr pmdaExt): cint {.importc.}
proc pmdaName*(pmid: pmID; nameset: ptr cstringArray; pmda: ptr pmdaExt): cint {.importc.}
proc pmdaChildren*(name: cstring; traverse: cint; offspring: ptr cstringArray; status: ptr ptr cint; pmda: ptr pmdaExt): cint {.importc.}
proc pmdaAttribute*(a1: cint; a2: cint; a3: cstring; a4: cint; a5: ptr pmdaExt): cint {.importc.}
proc pmdaLabel*(a1: cint; a2: cint; a3: ptr ptr pmLabelSet; a4: ptr pmdaExt): cint {.importc.}
proc pmdaOpenHelp*(a1: cstring): cint {.importc.}
proc pmdaCloseHelp*(a1: cint) {.importc.}
proc pmdaGetHelp*(a1: cint; a2: pmID; a3: cint): cstring {.importc.}
proc pmdaGetInDomHelp*(a1: cint; a2: pmInDom; a3: cint): cstring {.importc.}
proc pmdaAddLabels*(a1: ptr ptr pmLabelSet; a2: cstring): cint {.varargs,importc.}
proc pmdaAddNotes*(a1: ptr ptr pmLabelSet; a2: cstring): cint {.varargs,importc.}
proc pmdaAddLabelFlags*(a1: ptr pmLabelSet; a2: cint): cint {.importc.}
type
  pmdaUpdatePMNS* = proc (a1: ptr pmdaExt; a2: ptr ptr pmdaNameSpace): cint
  pmdaUpdateText* = proc (a1: ptr pmdaExt; a2: pmID; a3: cint; a4: cstringArray): cint
  pmdaUpdateMetric* = proc (a1: ptr pmdaMetric; a2: ptr pmdaMetric; a3: cint)
  pmdaCountMetrics* = proc (a1: ptr cint; a2: ptr cint)

#proc pmdaExtDynamicPMNS*(a1: cstring; a2: ptr cint; a3: cint; a4: pmdaUpdatePMNS;
#                        a5: pmdaUpdateText; a6: pmdaUpdateMetric;
#                        a7: pmdaCountMetrics; a8: ptr pmdaMetric; a9: cint;
#                        a10: ptr pmdaExt)
#proc pmdaDynamicPMNS*(a1: cstring; a2: ptr cint; a3: cint; a4: pmdaUpdatePMNS;
#                     a5: pmdaUpdateText; a6: pmdaUpdateMetric; a7: pmdaCountMetrics;
#                     a8: ptr pmdaMetric; a9: cint)
proc pmdaDynamicSetClusterMask*(a1: cstring; a2: cuint): cint {.importc.}
proc pmdaDynamicLookupName*(pmda: ptr pmdaExt; name: cstring): ptr pmdaNameSpace {.importc.}
proc pmdaDynamicLookupPMID*(pmda: ptr pmdaExt; pmid: pmID): ptr pmdaNameSpace {.importc.}
proc pmdaDynamicLookupText*(a1: pmID; a2: cint; a3: cstringArray; a4: ptr pmdaExt): cint {.importc.}
proc pmdaDynamicMetricTable*(a1: ptr pmdaExt) {.importc.}
proc pmdaRehash*(a1: ptr pmdaExt; a2: ptr pmdaMetric; a3: cint) {.importc.}
proc pmdaTreePMID*(a1: ptr pmdaNameSpace; a2: cstring; a3: ptr pmID): cint {.importc.}
proc pmdaTreeName*(a1: ptr pmdaNameSpace; a2: pmID; a3: ptr cstringArray): cint {.importc.}
proc pmdaTreeChildren*(a1: ptr pmdaNameSpace; a2: cstring; a3: cint;
                      a4: ptr cstringArray; a5: ptr ptr cint): cint {.importc.}
proc pmdaTreeRebuildHash*(a1: ptr pmdaNameSpace; a2: cint) {.importc.}
proc pmdaTreeSize*(a1: ptr pmdaNameSpace): cint {.importc.}
proc pmdaTreeCreate*(a1: ptr ptr pmdaNameSpace): cint {.importc.}
proc pmdaTreeInsert*(a1: ptr pmdaNameSpace; a2: pmID; a3: cstring): cint {.importc.}
proc pmdaTreeRelease*(a1: ptr pmdaNameSpace) {.importc.}
proc pmdaCacheStore*(a1: pmInDom; a2: cint; a3: cstring; a4: pointer): cint {.importc.}
proc pmdaCacheStoreKey*(a1: pmInDom; a2: cint; a3: cstring; a4: cint; a5: pointer;
                       a6: pointer): cint {.importc.}
proc pmdaCacheLookup*(a1: pmInDom; a2: cint; a3: cstringArray; a4: ptr pointer): cint {.importc.}
proc pmdaCacheLookupName*(a1: pmInDom; a2: cstring; a3: ptr cint; a4: ptr pointer): cint {.importc.}
proc pmdaCacheLookupKey*(a1: pmInDom; a2: cstring; a3: cint; a4: pointer;
                        a5: cstringArray; a6: ptr cint; a7: ptr pointer): cint {.importc.}
proc pmdaCacheOp*(a1: pmInDom; a2: cint): cint {.importc.}
proc pmdaCachePurge*(a1: pmInDom; a2: posix.Time): cint {.importc.}
proc pmdaCacheResize*(a1: pmInDom; a2: cint): cint {.importc.}
#proc __pmdaCntInst*(a1: pmInDom; a2: ptr pmdaExt): cint
#proc __pmdaStartInst*(a1: pmInDom; a2: ptr pmdaExt)
#proc __pmdaNextInst*(a1: ptr cint; a2: ptr pmdaExt): cint
#proc __pmdaMainPDU*(a1: ptr pmdaInterface): cint
#proc __pmdaInFd*(a1: ptr pmdaInterface): cint
#proc __pmdaCacheDumpAll*(a1: ptr FILE; a2: cint)
#proc __pmdaCacheDump*(a1: ptr FILE; a2: pmInDom; a3: cint)
proc pmdaGetContext*(): cint {.importc.}
#proc __pmdaSetContext*(a1: cint)
proc pmdaEventNewArray*(): cint {.importc.}
proc pmdaEventResetArray*(a1: cint): cint {.importc.}
proc pmdaEventReleaseArray*(a1: cint): cint {.importc.}
proc pmdaEventAddRecord*(a1: cint; a2: ptr posix.Timeval; a3: cint): cint {.importc.}
proc pmdaEventAddMissedRecord*(a1: cint; a2: ptr posix.Timeval; a3: cint): cint {.importc.}
proc pmdaEventAddParam*(a1: cint; a2: pmID; a3: cint; a4: ptr pmAtomValue): cint {.importc.}
proc pmdaEventGetAddr*(a1: cint): ptr pmEventArray {.importc.}
proc pmdaEventNewHighResArray*(): cint {.importc.}
proc pmdaEventResetHighResArray*(a1: cint): cint {.importc.}
proc pmdaEventReleaseHighResArray*(a1: cint): cint {.importc.}
proc pmdaEventAddHighResRecord*(a1: cint; a2: ptr posix.Timespec; a3: cint): cint {.importc.}
proc pmdaEventAddHighResMissedRecord*(a1: cint; a2: ptr posix.Timespec; a3: cint): cint {.importc.}
proc pmdaEventHighResAddParam*(a1: cint; a2: pmID; a3: cint; a4: ptr pmAtomValue): cint {.importc.}
proc pmdaEventHighResGetAddr*(a1: cint): ptr pmHighResEventArray {.importc.}
proc pmdaEventNewQueue*(a1: cstring; a2: csize): cint {.importc.}
proc pmdaEventNewActiveQueue*(a1: cstring; a2: csize; a3: cuint): cint {.importc.}
proc pmdaEventQueueShutdown*(a1: cint): cint {.importc.}
proc pmdaEventQueueHandle*(a1: cstring): cint {.importc.}
proc pmdaEventQueueAppend*(a1: cint; a2: pointer; a3: csize; a4: ptr posix.Timeval): cint {.importc.}
proc pmdaEventQueueClients*(a1: cint; a2: ptr pmAtomValue): cint {.importc.}
proc pmdaEventQueueCounter*(a1: cint; a2: ptr pmAtomValue): cint {.importc.}
proc pmdaEventQueueBytes*(a1: cint; a2: ptr pmAtomValue): cint {.importc.}
proc pmdaEventQueueMemory*(a1: cint; a2: ptr pmAtomValue): cint {.importc.}
type
  pmdaEventDecodeCallBack* = proc (a1: cint; a2: pointer; a3: csize; a4: ptr posix.Timeval;
                                a5: pointer): cint

proc pmdaEventQueueRecords*(a1: cint; a2: ptr pmAtomValue; a3: cint;
                           a4: pmdaEventDecodeCallBack; a5: pointer): cint {.importc.}
proc pmdaEventNewClient*(a1: cint): cint {.importc.}
proc pmdaEventEndClient*(a1: cint): cint {.importc.}
proc pmdaEventClients*(a1: ptr pmAtomValue): cint {.importc.}
type
  pmdaEventApplyFilterCallBack* = proc (a1: pointer; a2: pointer; a3: csize): cint
  pmdaEventReleaseFilterCallBack* = proc (a1: pointer)

proc pmdaEventSetFilter*(a1: cint; a2: cint; a3: pointer;
                        a4: pmdaEventApplyFilterCallBack;
                        a5: pmdaEventReleaseFilterCallBack): cint {.importc.}
proc pmdaEventSetAccess*(a1: cint; a2: cint; a3: cint): cint {.importc.}
#proc __pmdaEventPrint*(a1: cstring; a2: cint; a3: cstring; a4: cint): cstring
proc pmdaInterfaceMoved*(a1: ptr pmdaInterface) {.importc.}
proc pmdaRootConnect*(a1: cstring): cint {.importc.}
proc pmdaRootShutdown*(a1: cint) {.importc.}
proc pmdaRootContainerHostName*(a1: cint; a2: cstring; a3: cint; a4: cstring; a5: cint): cint {.importc.}
proc pmdaRootContainerProcessID*(a1: cint; a2: cstring; a3: cint): cint {.importc.}
proc pmdaRootContainerCGroupName*(a1: cint; a2: cstring; a3: cint; a4: cstring; a5: cint): cint {.importc.}
proc pmdaRootProcessStart*(a1: cint; a2: cint; a3: cstring; labellen: cint; a5: cstring;
                          a6: cint; a7: ptr cint; a8: ptr cint; a9: ptr cint): cint {.importc.}
proc pmdaRootProcessWait*(a1: cint; a2: cint; a3: ptr cint): cint {.importc.}
proc pmdaRootProcessTerminate*(a1: cint; a2: cint): cint {.importc.}

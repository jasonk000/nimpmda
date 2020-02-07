type PmdaInterface* = enum
  IF_1 = 1, IF_2, IF_3, IF_4, IF_5, IF_6, IF_7

const PMDA_FLAG_CONTAINER* = 64 # 1<<6
const PMDA_ATTR_CONTAINER* = 15

## metric identifier
const PM_ID_NULL*: uint32 = 0xffffffff.uint32

## instance-domain
const PM_INDOM_NULL*: uint32 = 0xffffffff.uint32
const PM_IN_NULL*: uint32 = 0xffffffff.uint32

type PmSem* = enum
  COUNTER = 1, INSTANT = 3, DISCRETE = 4

type PmTime* = enum
  NSEC, USEC, MSEC, SEC, MIN, HOUR

type PmSpace* = enum
  BYTE, KBYTE, MBYTE, GBYTE, TBYTE, PBYTE, EBYTE, ZBYTE, YBYTE

type PmCount* = enum
  ONE = 0

type PmdaFetch* = enum
  NOVALUES, STATIC, DYNAMIC

type PmType* = enum
  NOSUPPORT = -1,
  INT32 = 0,
  UINT32,
  INT64,
  UINT64,
  FLOAT,
  DOUBLE,
  STRING,
  AGGREGATE,
  AGGREGATE_STATIC,
  EVENT,
  HIGHRES_EVENT,
  UNKNOWN

type PmLogLevels* = enum
  LOG_EMERG, LOG_ALERT, LOG_CRIT, LOG_ERR
  LOG_WARNING, LOG_NOTICE, LOG_INFO, LOG_DEBUG
  LOG_PID, LOG_CONS, LOG_DAEMON

const PM_ERR_BASE2 = 12345
const PM_ERR_BASE = PM_ERR_BASE2
type PmErr* = enum
  PERMISSION = -PM_ERR_BASE - 42
  INST = -PM_ERR_BASE - 15
  INDOM = -PM_ERR_BASE - 14
  PMID = -PM_ERR_BASE - 13
  NAME = -PM_ERR_BASE - 12
  GENERIC = -PM_ERR_BASE - 0,

func PMDA_PMID*(cluster: uint32, item: uint32): uint32 =
  let clusterpart: uint32 = cluster and (0xfff.uint32)
  let itempart: uint32 = item.uint32 and (0x3ff.uint32)
  return ((clusterpart shl 10.uint32) or itempart)

/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef os_wcdb_h
#define os_wcdb_h

#if SQLITE_WCDB_SIGNAL_RETRY

#include "mutex_wcdb.h"

#define SQLITE_WAIT_NONE 0
#define SQLITE_WAIT_EXCLUSIVE 1
#define SQLITE_WAIT_SHARED 2

typedef struct unixInodeInfo unixInodeInfo;
typedef struct unixFile unixFile;

typedef struct unixShmNode unixShmNode;
typedef struct unixShm unixShm;

typedef struct WCDBWaitInfo WCDBWaitInfo;
struct WCDBWaitInfo {
  sqlite3_thread* pThread;
  int eFileLock;
  int eFlag;
  unixFile* pFile;
};

typedef struct WCDBShmWaitInfo WCDBShmWaitInfo;
struct WCDBShmWaitInfo {
  sqlite3_thread* pThread;
  int oMask;
  int eFlag;
  unixFile* pFile;
};

void WCDBOsSignal(unixInodeInfo* pInode);
void WCDBOsTrySignal(unixInodeInfo* pInode);
void WCDBOsWait(unixInodeInfo* pInode, unixFile* pFile, int eFileLock, int eFlag);

void WCDBOsShmSignal(unixShmNode* pShmNode);
void WCDBOsShmTrySignal(unixShmNode* pShmNode);
void WCDBOsShmWait(unixShmNode* pShmNode, unixFile* pFile, int oMask, int eFlag);

void WCDBOsFileSetWait(sqlite3_file* fd, int bFlag);
int WCDBOsFileGetWait(sqlite3_file* fd);

#endif// SQLITE_WCDB_SIGNAL_RETRY

#endif /* os_wcdb_h */

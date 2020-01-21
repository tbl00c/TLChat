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

#if SQLITE_WCDB_SIGNAL_RETRY

#include "queue.h"
#include <assert.h>
#include "sqliteInt.h"

struct QueueElem {
  QueueElem* pPrev;
  QueueElem* pNext;
  void* pData;
};

void sqlite3QueueInit(Queue* pQueue)
{
  assert(pQueue!=NULL);
  pQueue->pHead = NULL;
  pQueue->pTail = NULL;
}

QueueElem* sqlite3QueuePush(Queue* pQueue, void* pData)
{
  assert(pQueue!=NULL);
  QueueElem* elem = (QueueElem*)sqlite3_malloc(sizeof(QueueElem));
  elem->pData = pData;
  elem->pPrev = pQueue->pTail;
  elem->pNext = NULL;
  if (pQueue->pTail) {
    pQueue->pTail->pNext = elem;
  }else {
    pQueue->pHead = elem;
  }
  pQueue->pTail = elem;
  return elem;
}

QueueElem* sqlite3QueuePushFront(Queue* pQueue, void* pData)
{
  assert(pQueue!=NULL);
  QueueElem* elem = (QueueElem*)sqlite3_malloc(sizeof(QueueElem));
  elem->pData = pData;
  elem->pPrev = NULL;
  elem->pNext = pQueue->pHead;
  if (pQueue->pHead) {
    pQueue->pHead->pPrev = elem;
  }else {
    pQueue->pTail = elem;
  }
  pQueue->pHead = elem;
  return elem;
}

void* sqlite3QueuePop(Queue* pQueue)
{
  assert(pQueue!=NULL);
  void* pData = NULL;
  QueueElem* elem = NULL;
  if (pQueue->pHead) {
    elem = pQueue->pHead;
    if (pQueue->pHead==pQueue->pTail) {
      pQueue->pHead = NULL;
      pQueue->pTail = NULL;
    }else {
      pQueue->pHead = pQueue->pHead->pNext;
      pQueue->pHead->pPrev = NULL;
    }
  }
  if (elem) {
    pData = elem->pData;
    sqlite3_free(elem);
  }
  return pData;
}

void* sqlite3QueueFront(Queue* pQueue)
{
  assert(pQueue!=NULL);
  if (pQueue->pHead) {
    return pQueue->pHead->pData;
  }
  return NULL;
}

int sqlite3QueueEmpty(Queue* pQueue)
{
  return pQueue->pHead!=NULL?0:1;
}

void sqlite3QueueFree(Queue* pQueue)
{
  assert(pQueue!=NULL);
  sqlite3_free(pQueue);
}

#endif// SQLITE_WCDB_SIGNAL_RETRY

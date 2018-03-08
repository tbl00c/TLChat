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

#ifndef _SQLITE_QUEUE_H_
#define _SQLITE_QUEUE_H_

#if SQLITE_WCDB_SIGNAL_RETRY

typedef struct Queue Queue;
typedef struct QueueElem QueueElem;

struct Queue {
  QueueElem* pHead;
  QueueElem* pTail;
};

void sqlite3QueueInit(Queue*);

QueueElem* sqlite3QueuePush(Queue*, void*);

QueueElem* sqlite3QueuePushFront(Queue*, void*);

void* sqlite3QueuePop(Queue*);

void* sqlite3QueueFront(Queue*);

int sqlite3QueueEmpty(Queue*);

#endif// SQLITE_WCDB_SIGNAL_RETRY

#endif /* _SQLITE_QUEUE_H_ */

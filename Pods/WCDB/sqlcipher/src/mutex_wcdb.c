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

#include "mutex_wcdb.h"
#include <pthread.h>
#include "sqliteInt.h"
#include "sqlite3.h"

extern pthread_mutex_t* sqlite3GetPthreadMutex(sqlite3_mutex* p);

struct sqlite3_thread {
  pthread_t thread;
};

struct sqlite3_condition {
  pthread_cond_t cond;
};

sqlite3_condition* pthreadCondAlloc()
{
  sqlite3_condition* c = sqlite3MallocZero(sizeof(sqlite3_condition));
  if (c) {
    pthread_cond_init(&c->cond, NULL);
  }
  return c;
}

void pthreadCondFree(sqlite3_condition* c)
{
  pthread_cond_destroy(&c->cond);
  sqlite3_free(c);
}

int pthreadCondWait(sqlite3_condition* c, sqlite3_mutex* p, int timeout)
{
  if (timeout>0) {
    struct timespec relative;
    relative.tv_nsec = 0;
    relative.tv_sec = timeout;
    return pthread_cond_timedwait_relative_np(&c->cond, sqlite3GetPthreadMutex(p), &relative);
  }
  return pthread_cond_wait(&c->cond, sqlite3GetPthreadMutex(p));
}

void pthreadCondSignal(sqlite3_condition* c, sqlite3_thread* t)
{
  if (t&&t->thread) {
    pthread_cond_signal_thread_np(&c->cond, t->thread);
  }else {
    pthread_cond_signal(&c->cond);
  }
}

void pthreadCondBroadcast(sqlite3_condition* c)
{
  pthread_cond_broadcast(&c->cond);
}

sqlite3_thread* pthreadAlloc()
{
  return (sqlite3_thread*)sqlite3MallocZero(sizeof(sqlite3_thread));
}

void pthreadFree(sqlite3_thread* t)
{
  sqlite3_free(t);
}

void pthreadSelf(sqlite3_thread* t)
{
  t->thread = pthread_self();
}

int pthreadIsMain()
{
  return pthread_main_np();
}

sqlite3_mutex* unixVFSMutex(void)
{
  return sqlite3MutexAlloc(SQLITE_MUTEX_STATIC_VFS1);
}

#endif// SQLITE_WCDB_SIGNAL_RETRY

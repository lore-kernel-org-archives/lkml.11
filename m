Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FD8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 18:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbiBRSf4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:35:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiBRSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:35:54 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD47254A40;
        Fri, 18 Feb 2022 10:35:38 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nL82Z-0004OI-B3; Fri, 18 Feb 2022 13:31:35 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        paulmck@kernel.org, gscrivan@redhat.com, viro@zeniv.linux.org.uk,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 0/2] fix rate limited ipc_namespace freeing
Date:   Fri, 18 Feb 2022 13:31:12 -0500
Message-Id: <20220218183114.2867528-1-riel@surriel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test case below fails on 5.17 (and a bunch of older kernels)
with unshare getting -ENOSPC, because the rate at which ipc_namespace
structures can be freed is limited by each item on the to-free list
waiting in synchronize_rcu.

Making kern_unmount use queue_rcu_work gets rid of that slowdown,
allowing a batch of vfsmount structures to be freed after each
RCU grace period has expired.

That, in turn, allows us to just get rid of the workqueue in
ipc/namespace.c completely.

With these two changes the test case reliably succeeds at
calling unshare a million times, even with max_ipc_namespaces
reduced to 1000 :)

#define _GNU_SOURCE
#include <sched.h>
#include <error.h>
#include <errno.h>
#include <stdlib.h>

int main()
{
	int i;

	for (i = 0; i < 1000000; i++) {
		if (unshare(CLONE_NEWIPC) < 0)
			error(EXIT_FAILURE, errno, "unshare");
	}
}


Rik van Riel (2):
  vfs: free vfsmount through rcu work from kern_unmount
  ipc: get rid of free_ipc_work workqueue

 fs/namespace.c                | 11 +++++++++--
 include/linux/ipc_namespace.h |  2 --
 include/linux/mount.h         |  2 ++
 ipc/namespace.c               | 21 +--------------------
 4 files changed, 12 insertions(+), 24 deletions(-)

-- 
2.34.1


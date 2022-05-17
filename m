Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF6FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 18:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351822AbiEQSEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351758AbiEQSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E22D506D1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810620;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5farY2CU759uzh4SooW5XrTDC/5qUq+H5GZdMvHd6k=;
        b=YLJZToiwXiMeCAtfgBTVDKAj9EHaC33u5ythKJPA1LzU/4wLV7zx44dLkU3Nngw6kqqKYw
        kTvO+aS4K9wFFz7ygswECc1Q7brvf9CLvC5ZKaux82b3g0RKA+pXUmdEcUpltkTM23dXS/
        fTQTxKl1ThqvuTL+B+qQjKrbhofK8qk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-LId07ZbaNiaLoxjyuU5EtA-1; Tue, 17 May 2022 14:03:37 -0400
X-MC-Unique: LId07ZbaNiaLoxjyuU5EtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A651F101A52C;
        Tue, 17 May 2022 18:03:36 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4571B400DFB5;
        Tue, 17 May 2022 18:03:36 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 06/11] smp: use smp_call_csd() from irq_work.c and core.c
Date:   Tue, 17 May 2022 14:03:21 -0400
Message-Id: <20220517180326.997129-7-dqiao@redhat.com>
In-Reply-To: <20220517180326.997129-1-dqiao@redhat.com>
References: <20220517180326.997129-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_work.c and core.c should use the cross interface rather than
using a unpublished internal function __smp_call_single_queue.

But this change also exposed unpublished types SMP_CALL_TYPE_TTWU and
SMP_CALL_TYPE_IRQ_WORK. However, this is a temporarily change so that
all kernel clients can call the interface as the first step. A
permanent solution should implement new cross call func() for both
and from there the TTWU and IRQ_WORK types of requests can be processed.
That way, the special TTWU and IRQ_WORK types will not be visible from
the cross call interface. Because this needs to change core.s and
irq_work.c, this should be done with a follow up patch set to reduce
the level of risk.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL to
	  SMP_CALL from the new macros
v2 -> v3: Modifed the commit comments
 kernel/irq_work.c   | 4 ++--
 kernel/sched/core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc4..aa67ea2ccb8f 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -159,8 +159,8 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 			if (!irq_work_claim(work))
 				goto out;
 		}
-
-		__smp_call_single_queue(cpu, &work->node.llist);
+		smp_call_csd(cpu, (call_single_data_t *)&work->node.llist,
+					SMP_CALL_TYPE_IRQ_WORK);
 	} else {
 		__irq_work_queue_local(work);
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..6d1d30bd6220 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3780,7 +3780,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	__smp_call_single_queue(cpu, &p->wake_entry.llist);
+	smp_call_csd(cpu, (call_single_data_t *)&p->wake_entry.llist, SMP_CALL_TYPE_TTWU);
 }
 
 void wake_up_if_idle(int cpu)
-- 
2.27.0


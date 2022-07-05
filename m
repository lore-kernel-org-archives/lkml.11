Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3932EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiGEMZ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbiGEMRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:17:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804F193C6;
        Tue,  5 Jul 2022 05:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8412619A6;
        Tue,  5 Jul 2022 12:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1D5C341C7;
        Tue,  5 Jul 2022 12:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657023178;
        bh=V878LdBN19s8tRJg3JLUYQbVPB/+HWJ83r+Ig4+/bzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0f/biOl4Rk6z+blnDfh6EL8rl9JlRxSpqn14hP/OOnbOH5JWuAA/Z8dMJafhGpmU
         TYZGy4VGycuzF/Ip2ZbO8lXDmOJXQ9IGrqO2gXbEePobLRFUCONXnjGVwjV3go+QBx
         s5RYUjdJFpWI4dIrWidt9BwWRAj1cOriOqKcSJzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 5.15 64/98] selftests/rseq: Remove useless assignment to cpu variable
Date:   Tue,  5 Jul 2022 13:58:22 +0200
Message-Id: <20220705115619.397003598@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115617.568350164@linuxfoundation.org>
References: <20220705115617.568350164@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 930378d056eac2c96407b02aafe4938d0ac9cc37 upstream.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-4-mathieu.desnoyers@efficios.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rseq/param_test.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -368,9 +368,7 @@ void *test_percpu_spinlock_thread(void *
 		abort();
 	reps = thread_data->reps;
 	for (i = 0; i < reps; i++) {
-		int cpu = rseq_cpu_start();
-
-		cpu = rseq_this_cpu_lock(&data->lock);
+		int cpu = rseq_this_cpu_lock(&data->lock);
 		data->c[cpu].count++;
 		rseq_percpu_unlock(&data->lock, cpu);
 #ifndef BENCHMARK



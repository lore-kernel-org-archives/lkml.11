Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6DFCCA48D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 21:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379500AbiFGVGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358488AbiFGUHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A91C4269;
        Tue,  7 Jun 2022 11:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D076612F2;
        Tue,  7 Jun 2022 18:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58987C385A2;
        Tue,  7 Jun 2022 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654626359;
        bh=4FWVvpGIVHGySV3NM6oA2OJC61WladjaOASJ3N08TN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbE7BjJ5gTsGkEcolIRXoxUzuQjejm1eaJkp6y+TmsWpLVJiVFbVhEW3CFXMJ0HzG
         9mJs3I2heyOgIF9PTltY7X8jluMNxrYCIQ/IN0hshh1SoUD8JNKtLVPV3VgTA2j2as
         lB9z99KPIj2x0B7D6kBxK7KB6vISkVjLkulUc+ZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 351/772] perf/amd/ibs: Use interrupt regs ip for stack unwinding
Date:   Tue,  7 Jun 2022 18:59:03 +0200
Message-Id: <20220607164959.362821184@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@amd.com>

[ Upstream commit 3d47083b9ff46863e8374ad3bb5edb5e464c75f8 ]

IbsOpRip is recorded when IBS interrupt is triggered. But there is
a skid from the time IBS interrupt gets triggered to the time the
interrupt is presented to the core. Meanwhile processor would have
moved ahead and thus IbsOpRip will be inconsistent with rsp and rbp
recorded as part of the interrupt regs. This causes issues while
unwinding stack using the ORC unwinder as it needs consistent rip,
rsp and rbp. Fix this by using rip from interrupt regs instead of
IbsOpRip for stack unwinding.

Fixes: ee9f8fce99640 ("x86/unwind: Add the ORC unwinder")
Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220429051441.14251-1-ravi.bangoria@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/ibs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 367ca899e6e8..2704ec1e42a3 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -304,6 +304,16 @@ static int perf_ibs_init(struct perf_event *event)
 	hwc->config_base = perf_ibs->msr;
 	hwc->config = config;
 
+	/*
+	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
+	 * recorded as part of interrupt regs. Thus we need to use rip from
+	 * interrupt regs while unwinding call stack. Setting _EARLY flag
+	 * makes sure we unwind call-stack before perf sample rip is set to
+	 * IbsOpRip.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
+
 	return 0;
 }
 
@@ -687,6 +697,14 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		data.raw = &raw;
 	}
 
+	/*
+	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
+	 * recorded as part of interrupt regs. Thus we need to use rip from
+	 * interrupt regs while unwinding call stack.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		data.callchain = perf_callchain(event, iregs);
+
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
 	if (throttle) {
-- 
2.35.1




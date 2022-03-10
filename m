Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55702C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 21:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbiCJVIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiCJVIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2F92240AF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646946465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E2nPX4HLkdeLoXSmv3Q/oY0b2uV3m7DpBJLpMWu4IqM=;
        b=IxxUBr8WV4HWLMnwyUe/2FM6pJTVnBh74izu4HKRzw7x+m1KNQjlI9DO5x8t0XUbc6VXuR
        /YUTZvJmkRKpI82EmMqVy3xHdLPJgJZwnDMiiZSIy4DJOd/XqBdUgasrroXuB3IZrWmwhy
        Z8B4Z3jKXwN6fGOE3945qZnPL7tWYwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-vezZfxkSMBuoY7ycZY8RnA-1; Thu, 10 Mar 2022 16:07:43 -0500
X-MC-Unique: vezZfxkSMBuoY7ycZY8RnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7282E1854E2A;
        Thu, 10 Mar 2022 21:07:42 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83392610E7;
        Thu, 10 Mar 2022 21:07:16 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] x86/entry_64: Fix incorrect comment referring to error_exit
Date:   Thu, 10 Mar 2022 16:07:09 -0500
Message-Id: <20220310210709.1595028-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 23d73f2ad4e7 ("x86/entry/64: Remove error_exit()") and
related commits, the error_exit symbol name is gone and error_return is
used instead. Fix the incorrect comment in paranoid_exit to correctly
reference error_return.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 466df3e50276..7077b076323e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -939,7 +939,7 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	 *
 	 * NB to anyone to try to optimize this code: this code does
 	 * not execute at all for exceptions from user mode. Those
-	 * exceptions go through error_exit instead.
+	 * exceptions go through error_return instead.
 	 */
 	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
 
-- 
2.27.0


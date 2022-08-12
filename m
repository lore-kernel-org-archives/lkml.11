Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B893C25B08
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 10:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbiHLKbt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 06:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiHLKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:31:29 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF0D89DFBB;
        Fri, 12 Aug 2022 03:31:28 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 75FAC1E80D9D;
        Fri, 12 Aug 2022 18:29:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6SEcfFyIG0SN; Fri, 12 Aug 2022 18:29:13 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C41911E80D95;
        Fri, 12 Aug 2022 18:29:13 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH 5/5] kvm/kvm_main: remove unnecessary (const void*) conversions
Date:   Fri, 12 Aug 2022 18:31:20 +0800
Message-Id: <20220812103120.8433-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220812101523.8066-1-kunyu@nfschina.com>
References: <20220812101523.8066-1-kunyu@nfschina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casting from a pointer of type void * to a pointer of type const void *
does not require a cast.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f047799bf19b..01883ecd8cc4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3278,7 +3278,7 @@ EXPORT_SYMBOL_GPL(kvm_read_guest_cached);
 
 int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 {
-	const void *zero_page = (const void *) __va(page_to_phys(ZERO_PAGE(0)));
+	const void *zero_page = __va(page_to_phys(ZERO_PAGE(0)));
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	int seg;
 	int offset = offset_in_page(gpa);
-- 
2.18.2


Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD3AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 05:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiBWF04 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 00:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238222AbiBWF0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:26:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613406E2AA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:24:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i6-20020a255406000000b006241e97e420so18864439ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qiOY3I7MTzDOyydGuOsoL3kibVHTWqt/T8NonRDSdjI=;
        b=gHD/ZzZ2afDsPzQ43uzTfHDeNudIA9BOq9xrr9L14+jP+dH61iVLZ9hzKNk6oCuBOI
         frJ4Y/pMW9lHMFuHIDT5LntquphVA/hdUftBkeKzRimB/OZsUvqrqt+OTldNL/5M2dvF
         +PIjZDytqBI9qNUICzwPtZ9WZreG3la5anScSUKXP0fumh99WG+FQaCeyfbwMohmDN9Z
         TqQY1Ne53dTgZlticBLJ/nLFoMZJ6npZslQ1FhKLNnIG+gBpH+SHHrgjBmREZgI8pcKn
         GtFQ6xyENvmtRWa1WOq2159X/570g6HXWtqzHRNADNoxBQZmRvsc5EkR5xI3zImo/8Xk
         CC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qiOY3I7MTzDOyydGuOsoL3kibVHTWqt/T8NonRDSdjI=;
        b=tCCmwyiXaNGBUU0y083xTRbFoM+zVjiT/Vl6uxenVEShbrkdNhdfSXJ6cOobxf1Mdt
         Un5QqByfYzfmDj0uGajMYVn+1a7l83uk8byIpODfSxqqGS1r0rtargF1n4KK+1z56XvT
         tKyhsXPjSCvdL1q9jAseWVQq0Ksd7P1hshGB7o/UKtydQZAqL7/+Ykxst9qGll2nqA88
         1IyhT7Cge7Rsxko448pjFoL3D9OV+ugbgr+pssolSEOuFtrSU5JwxZ5n+wMmU5hqrV61
         KvX6VxX0RWi1N8rCAe1y0vn1xtU+hMHofmtQch6kYwgJf4wBKqDiZQgYTGeJ7TIsbKtN
         y6RQ==
X-Gm-Message-State: AOAM532wm9DR7WNVRk/mp9qrwdMtyYjpW4cvVqjN4XLIcmfMyQaV5JpF
        WOCd+QrXm0dEW0nr25SU0JIRWBVYxuCbIR0jslxz8Z6cgeqXJX5nf/pZPfIqIgsU4Ny9lrfWUSs
        HJ000XN8Pj1JlCcgHh5YYUXCuIUadlJDYce5J5yArLApDKzI6MHsv9eAvi86UdClva+H5A8m1
X-Google-Smtp-Source: ABdhPJz0RUH+JeSNvxcFS2t+PaXJsk2Yx25dJd/bxX+okavoC9VlrjteMlukvkj4zkv9eNKI+iSQhOk6jOMd
X-Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:202:ccbe:5d15:e2e6:322])
 (user=junaids job=sendgmr) by 2002:a25:bad2:0:b0:620:fe28:ff53 with SMTP id
 a18-20020a25bad2000000b00620fe28ff53mr26732357ybk.340.1645593881600; Tue, 22
 Feb 2022 21:24:41 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:22:01 -0800
In-Reply-To: <20220223052223.1202152-1-junaids@google.com>
Message-Id: <20220223052223.1202152-26-junaids@google.com>
Mime-Version: 1.0
References: <20220223052223.1202152-1-junaids@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [RFC PATCH 25/47] mm: asi: Avoid warning from NMI userspace accesses
 in ASI context
From:   Junaid Shahid <junaids@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, jmattson@google.com,
        pjt@google.com, oweisse@google.com, alexandre.chartre@oracle.com,
        rppt@linux.ibm.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, luto@kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nmi_uaccess_okay() emits a warning if current CR3 != mm->pgd.
Limit the warning to only when ASI is not active.

Signed-off-by: Junaid Shahid <junaids@google.com>


---
 arch/x86/mm/tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 25bee959d1d3..628f1cd904ac 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1292,7 +1292,8 @@ bool nmi_uaccess_okay(void)
 	if (loaded_mm != current_mm)
 		return false;
 
-	VM_WARN_ON_ONCE(current_mm->pgd != __va(read_cr3_pa()));
+	VM_WARN_ON_ONCE(current_mm->pgd != __va(read_cr3_pa()) &&
+			!is_asi_active());
 
 	return true;
 }
-- 
2.35.1.473.g83b2b277ed-goog


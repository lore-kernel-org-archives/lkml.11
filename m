Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA88DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 20:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357886AbiFNULL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358051AbiFNUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:10:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2EBBE19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:08:34 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 78-20020a630051000000b003fe25580679so5455757pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=GcnQGtIgWgA8fnCOJZ2NC0z3fNMByJKLtilK+3LRet8=;
        b=UUtRfLBdt6WVEsGg8pTCK6naNVhi6UmL2mpQWCl4tgb+SWxp688YfD43lVCKfntZtp
         ulzBd3n3DXfhY32sqPSq40Uo8lgJ2qnSVRsBRN/OswminfCDsUmo8WOzC3xnw6s2nQ/q
         0dDOIAinhyxAs6/Lq9gY5rAhptG1Mz8jcWsyPLBMz2EQb66gZlz3QFYnaLHAcEYoXwS7
         Dnwv7Qe7yRYZ2lVH9FTCVwXKXYpHIWub63SuXvefqgHcw785Ez7TKcdYSM5xIy7cr4L5
         8NMLQ2m+hy+43ld5vGxlvk5tWwo9B9gGRE8po6sm6g6mvdSSQHfExeqUkQE06XrYY96M
         5Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=GcnQGtIgWgA8fnCOJZ2NC0z3fNMByJKLtilK+3LRet8=;
        b=MAeVUSnMJNCd6qJU1FAO7kNcetbTZpQOSp7oR7Upem7UGFGthCtSRkXpDI5EM2sbL8
         o2RuMCHApAYXoQimnYvJxVYV/sfTan6eVqxURhtj5dqNRvDIr47i/EqQTlqqJpVi5pvG
         5FQz8zUd5qOIMTd9sL7lMC0oIHRwRY8OfjVPuG1VnwGhvyCaIKfElLCOtiuBEmfqRNhz
         UTynqyhwXtuBCv1vWFZ0DN5/CAupBIPcUU1mbJFHXhkSpAgaeh1QGQ6BgA8676f+jVYQ
         9Ob6AnbUeIp8/zBk5qLMF4EM/qxJW/EAXcwrkSw1omfWzge88thi7EMGrJr1Q/Hj44EP
         j+aw==
X-Gm-Message-State: AJIora/4Ihn+3X1zzE8eFojyilfMjnYda+DsBbGDudO1Se1a/S93KFAh
        zpCJ42yu02o+LUexf6FpyXOuxI5oy9g=
X-Google-Smtp-Source: AGRyM1tbmRuWodF0xUlWN6zVml/CAWJNtDGr7rzGXaVv3e5/LmimEj98XorvzTGzIlQDPkTO0GS2+EyRaz4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1d02:b0:1e6:961d:d56f with SMTP id
 on2-20020a17090b1d0200b001e6961dd56fmr6287808pjb.225.1655237302377; Tue, 14
 Jun 2022 13:08:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:07:04 +0000
In-Reply-To: <20220614200707.3315957-1-seanjc@google.com>
Message-Id: <20220614200707.3315957-40-seanjc@google.com>
Mime-Version: 1.0
References: <20220614200707.3315957-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 39/42] KVM: selftests: Skip AMX test if ARCH_REQ_XCOMP_GUEST_PERM
 isn't supported
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip the AMX test instead of silently returning if the host kernel
doesn't support ARCH_REQ_XCOMP_GUEST_PERM.  KVM didn't support XFD until
v5.17, so it's extremely unlikely allowing the test to run on a pre-v5.15
kernel is the right thing to do.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c7fe584c71ed..ee346a280482 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -601,14 +601,7 @@ void vm_xsave_req_perm(int bit)
 
 	TEST_REQUIRE(bitmask & (1ULL << bit));
 
-	rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_GUEST_PERM, bit);
-
-	/*
-	 * The older kernel version(<5.15) can't support
-	 * ARCH_REQ_XCOMP_GUEST_PERM and directly return.
-	 */
-	if (rc)
-		return;
+	TEST_REQUIRE(!syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_GUEST_PERM, bit));
 
 	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_GUEST_PERM, &bitmask);
 	TEST_ASSERT(rc == 0, "prctl(ARCH_GET_XCOMP_GUEST_PERM) error: %ld", rc);
-- 
2.36.1.476.g0c4daa206d-goog


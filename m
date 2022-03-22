Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 22:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiCVWRG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 18:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCVWQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:16:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E089532FC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d7eaa730d9so161987667b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=50G7bdvRpnkEWCRx25n5fuGGImUWUWrpu2rzhqm9RSw=;
        b=Pcua82bNwW6ZhrNJ8K3tV/e5P5U/aHlgnnU7KxmReET5t16D1e4nkVGQ7njJdRSqnO
         H1nKUN1oBFzVI4daa5JWToQ5UE4J+zFha8+s3mt6eVvr3Q3d1JdlXA9DuaveQG1Ka823
         ykzHaLAZ2IQbKUeIrG8PLJ4plllkDenhOEw0Glmkg4BNK2o+CFWBkvsuHq2R7HlKH7/h
         oC5NTfzGkTkVPfXPgujfjZt3uxB8Q/2jcT5E/CyV7IhbBnHjHG0WVWrijM7aF6J397Pk
         z42IvcI3hS3kw90xNBCdPbuKXsK2YNscLew2eID/XLCeRAUZxaoyFhQKlds6+4xNNjjP
         E3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=50G7bdvRpnkEWCRx25n5fuGGImUWUWrpu2rzhqm9RSw=;
        b=vmQsBLYde20pOwI1c552vhaoTUy/DG4EuJRyuHT+NHN1VJlNM/ntoxfcs0txPJT+ZX
         rMaLAyT4Kjv+0IWH78/QhT4eqGQzTB3mQllBTl+OTpsrEgd7ekW9fPYlWql6LIvh0/vf
         xDKIZqKD5/UubBDmiY54vVTIgmcXytiuJ6h9eLu+34r1KGQvOKHNoFwiCRXi3PY4yd+V
         TNN+sy+kub5SL+N0hAz0ZujUNILuota7Q+RbvSX6yKBByibBopbWGFaJpiwUbIT50CoI
         wl/pCAeUoVw/q2XIAEYIAJdm0XBIRcRx6181jFr9ZenYj3TcRK2xJxoOTdyBvlgsnv3f
         P0wA==
X-Gm-Message-State: AOAM5307LnVdYPKuS1/usJT0DdjgZXmlu9K8Bgmu68kE510TMLDljLwu
        CQhvYsyE8TTFOq6gmpYi7pFpiKMJwk0by2uE51/Mf0qip9Ui5RGZ9TkMJiUm84OQwOO9DaXb041
        I451v8U+AWCe7/O0IX012gF5ho8+lUwN2dI4O9l3XFsVfoIPOO6q0y+RivCPaSmXQd3+uK/9O
X-Google-Smtp-Source: ABdhPJyAcixNySsnaXqbNfFt9CkR18LFPySVrtwaEEbDXutyEY/llA+XXhfjQa6tGwAAUCG+IPj/MFOSGFZC
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a81:6d3:0:b0:2e5:a089:867e with SMTP id
 202-20020a8106d3000000b002e5a089867emr31632385ywg.516.1647987330162; Tue, 22
 Mar 2022 15:15:30 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:06 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-3-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 02/13] x86/cpufeatures: add AMD Fam19h Branch Sampling feature
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, rafael@kernel.org,
        ravi.bangoria@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a cpu feature for AMD Fam19h Branch Sampling feature as bit
31 of EBX on CPUID leaf function 0x80000008.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 9a59e2e73bee..ff3ee4f4ebbb 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -315,6 +315,7 @@
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 #define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
+#define X86_FEATURE_BRS			(13*32+31) /* Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.35.1.894.gb6a874cedc-goog


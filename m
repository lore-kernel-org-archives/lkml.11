Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470EAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 07:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbiETH3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 03:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiETH3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:29:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D163814B67B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:29:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i1so6697980plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vMIyw87PdmpulkbYcxeN2hlKzY6uLlcHvdsVNSaUc3o=;
        b=BwwAhaWlyPct9vCBceb33ioKVg6w1bOMXYN/5k6KVqNAzGQXMAagTuP/8fbA1vTGP7
         ZQSUNInsF4ZBxBXA0QyFOBfabxFoiNxFL6c1KYFHWGBSSHLIeDOeJ7fEmf9wPuag6m1g
         dBbfmX1ZV2gcQhuABmTyQER/kKbFER7RkU4I2mEc//Rv6rhR+sesaAWHcchViu60E6aD
         5H2kwRZN2/O4LE1HcORklozNISIBo/+kEHGj0uaF4C1v3vmsthK13pxID61HJCeN6Jdl
         /NDD/FllZRnrd08PHuG1BvC1ELlZqpsZVt27m7ZlYuQudD0dJAByprULru2jMMFBDbBh
         wC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vMIyw87PdmpulkbYcxeN2hlKzY6uLlcHvdsVNSaUc3o=;
        b=rX0M/v4KmsoAy4VqZ7vtq3FD3aGiAVnUrVND1Qh438gEPhL/Tn/3G/Nsym4lDXvULq
         rAVZN+36cJIQ/1HIin9ViLTh8jmbXuRjQgHn5R5yQXvm/+ck8UCAUmj4NOx8AJVeDVsU
         FySzwq21m9O6f9XhX+mCDcr2BwK8MseaAlkPTLhyoieVB9kcH2ff4B1Lx4iGE+m2TqZI
         C0ddgcaL/xyrzkzQtXfxModRWDgy3OsysYeAVg1gIkHkVxs9M/NEbdSDMU24Q5hX7WLh
         dlMUfPYqvHnhzEIairrap7Cf+/D9EcItIWQ00EDO7pd1qG0fmD8VK+3kJmiwpyN+EGLe
         19Gg==
X-Gm-Message-State: AOAM53031P8zu8uHXGEK08IWs9YOnlEbbyhTQHwyLxUDngcW8cLztb/q
        rHsanluxK4/MzDncPnQ3HE0=
X-Google-Smtp-Source: ABdhPJx64dRz4CL62NN/EYPd4nUNgA3TNP6Fn5RTooOrytOK6zrMQrKLVhBYMFi8tJpwi5gX5l8M8Q==
X-Received: by 2002:a17:903:18b:b0:15e:92b9:783 with SMTP id z11-20020a170903018b00b0015e92b90783mr8611793plg.30.1653031751346;
        Fri, 20 May 2022 00:29:11 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id jz10-20020a17090b14ca00b001df54afccb3sm1102705pjb.6.2022.05.20.00.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:29:10 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     srivatsa@csail.mit.edu, amakhalov@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Cc:     virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, yesshedi@gmail.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH] x86/vmware: use unsigned integer for shifting
Date:   Fri, 20 May 2022 12:58:57 +0530
Message-Id: <20220520072857.592746-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is implementation-defined
behaviour. Using unsigned is better option for this.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c04b933f48d3..b28f789d3c56 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -476,7 +476,7 @@ static bool __init vmware_legacy_x2apic_available(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
-	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
+	return (eax & (1U << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
 	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
 }
 
-- 
2.36.1


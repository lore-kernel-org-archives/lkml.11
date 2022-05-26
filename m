Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F37C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 21:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349204AbiEZVYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349072AbiEZVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:24:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEAA60069
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:24:24 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t14-20020a1709028c8e00b0015cf7e541feso1703861plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+ARLUoQErvE10R5Z3P5YbADKHrFc+h+h9fYwAe9gqkQ=;
        b=P1O1m4A5QB3PkqYRhvWgKI3trzoLpiD17Kap9u1Ntf7VXNNt1LmTVq0xans+HuPbwP
         mrMXwad+SEnBrc5v+SdXuwL7TfEDMDuy3jr82opB5JprY8fpDve5pmyhw/qPJ5KCyALt
         rFJ5C02+GK3Um1cpjhCZFsMdja3ACtm7xaEK2uFGIcSrATj61okbfsKEv/q9Q2V0qgcE
         8XbzvEcswTakOhChRP0G2ohPJDooOxl1wJ3oRkV0+YniNUu3+5oXZwertnhEL7elo276
         CFUTe0QOajucWkgSzuSbC60D7gFaNKbeIkXJgjThxp8libH4wQFoylreajXaLkiXjahY
         loeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+ARLUoQErvE10R5Z3P5YbADKHrFc+h+h9fYwAe9gqkQ=;
        b=vJKGYJz0ckPbia07V4O2JIOpkf6JWY2tUp6DJL2+cUzpw3UwZASjVe4fF/2lZq+TX0
         vWTSmgkQzstV5fVrKoilMnej46n48aqdaz5Sxyjff9qqNech7kJkfrrXgBUS/JhO8BaR
         voohlP+/9PvEYDm/dDBrA4locwPMFQJ0swZRKvYADCve2SpOFyKOAOwTRL3nIjs0TWpX
         TYFfvMTjhGqEeF0xk7ZVPUERlk0ZyBlx/pXQXx71y0wmpKazGgzldZGqtdUCaH2pzqzL
         wmo8aCE1NGRlUysRKhDkl0NGToxGro5VFCJub54lishxg5KpbaLa6HJtUk4ARxnhrSmD
         t6HQ==
X-Gm-Message-State: AOAM531H5qZfmTluYhx7ARJ13xnGMjJWWvveCMxgIiBKeATgZG1U2svw
        rdtRz+vsdMZT1U++5FDvOzaFJ4UsvXs=
X-Google-Smtp-Source: ABdhPJw0nK+wAhiONzhiRIha9jnwWLcnJmVTgMO2zOQF0Ko9glHAJQlpshUO38CIPt2CWi406/F7XXICRcc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:e819:0:b0:518:6a98:b02 with SMTP id
 c25-20020a62e819000000b005186a980b02mr34100356pfi.74.1653600263944; Thu, 26
 May 2022 14:24:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 26 May 2022 21:08:13 +0000
In-Reply-To: <20220526210817.3428868-1-seanjc@google.com>
Message-Id: <20220526210817.3428868-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220526210817.3428868-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 4/8] KVM: x86: Use 16-bit fields to track dirty/valid
 emulator GPRs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Robert Dinse <nanook@eskimo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a u16 instead of a u32 to track the dirty/valid status of GPRs in the
emulator.  Unlike struct kvm_vcpu_arch, x86_emulate_ctxt tracks only the
"true" GPRs, i.e. doesn't include RIP in its array, and so only needs to
track 16 registers.

Note, maxing out at 16 GPRs is a fundamental property of x86-64 and will
not change barring a massive architecture update.  Legacy x86 ModRM and
SIB encodings use 3 bits for GPRs, i.e. support 8 registers.  x86-64 uses
a single bit in the REX prefix for each possible reference type to double
the number of supported GPRs to 16 registers (4 bits).

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c     | 3 +++
 arch/x86/kvm/kvm_emulate.h | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c74c0fd3b860..5aaf1d1200af 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -262,6 +262,9 @@ static ulong *reg_write(struct x86_emulate_ctxt *ctxt, unsigned nr)
 	if (WARN_ON_ONCE(nr >= NR_EMULATOR_GPRS))
 		nr &= NR_EMULATOR_GPRS - 1;
 
+	BUILD_BUG_ON(sizeof(ctxt->regs_dirty) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
+	BUILD_BUG_ON(sizeof(ctxt->regs_valid) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
+
 	ctxt->regs_valid |= 1 << nr;
 	ctxt->regs_dirty |= 1 << nr;
 	return &ctxt->_regs[nr];
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index bc3f8295c8c8..3a65d6ea7fe6 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -356,9 +356,9 @@ struct x86_emulate_ctxt {
 	u8 lock_prefix;
 	u8 rep_prefix;
 	/* bitmaps of registers in _regs[] that can be read */
-	u32 regs_valid;
+	u16 regs_valid;
 	/* bitmaps of registers in _regs[] that have been written */
-	u32 regs_dirty;
+	u16 regs_dirty;
 	/* modrm */
 	u8 modrm;
 	u8 modrm_mod;
-- 
2.36.1.255.ge46751e96f-goog


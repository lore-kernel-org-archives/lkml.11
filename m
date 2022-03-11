Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC728C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 05:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346619AbiCKFyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 00:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346602AbiCKFwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:42 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61010ECB30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:34 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p8-20020a17090a74c800b001bf257861efso7268144pjl.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=emCA/tvvyJ2efmmGNI3zej5xo0FQCGV6fGdLSat4I7c=;
        b=lWtf2u3vSetMdZSOR+twpZfb0d0apL+VekYKn3VhGok6LLdMZHCuxKf0fWY2+ACJ1X
         JR3BrxghU1yFmU7XYIXMu6JbUWNqE9AP2O3MXVVlfI9I1wuBUKD6IBj6Ch8HzSZ73Gri
         RrKbXcz8v4Ld5hAy/MJz6kwsl7RFmUWEbpBnvtjnfTdcONj/UIYyRWygJtcpnQtFNcuU
         wROFXjDVMPtDtCE7a6vaOVqc7kjbphu8TxahJIAFFhkC6jT8Rdq5dhcB+7NsmKKp4zSA
         q+LOzX64bG2elXXjQZVPxYd4kd9nuhipWPItBIjAhlC7SaeKztoeimmEm33oBY/WTYMR
         Q7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=emCA/tvvyJ2efmmGNI3zej5xo0FQCGV6fGdLSat4I7c=;
        b=wLB2jYIXhLdcYEHTnSSemR8GGY1vjcJzKd7JMDa5yivIwUZ09nXulmEiwIBsWOajMV
         LzwgJSMmUlEDFVGivOm19IcA8p9O9dOcDIG066hQzUszbPVS+1fCgornnnEvZVL6313k
         5X1YJiGKt0mz9XXINp06IDI2x+RwHL+HXISAPgPm+CJAh1sGgHEL7tZvW7kUzGoPYM4u
         RS7DXygR/q7TbqdGzQZSLynTEYMiSvDuKaV49bVPAOCawoF8j0wsAXR1mj+eCmA4vRX/
         RSAPGCsVbb/zBGxue43PjnaHr/8PzfF4pfVLrKs05bPH1VDM98v0xQMXi5Zgr4YYVFt0
         XVlA==
X-Gm-Message-State: AOAM532+11yOVWo+R249IT+GdQSnmkazdshX6fQaKNocinEND3AHyvhz
        dXipa7nC9n8wTf903FheVWELCosbMDC5D27fV1rAps/gPQGttsynSV/74QDhVtDGGwdLRgVIS9x
        dZpGYLQNRekH/lRt3Iee4fXgN3IuKtPONip3MXzo6Ci1XFUUZwo0TbCt7wzu7Hb/rG4ZaIg==
X-Google-Smtp-Source: ABdhPJxt9q09h8ksPAnjIoTfHEG4b9LnDxuEEWORenT0r305qH/wfd3AKOK1MW1Nq/ey1T/Etxw4EnG7F24=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:9017:0:b0:4df:e33f:f1b4 with SMTP id
 m23-20020aa79017000000b004dfe33ff1b4mr8800411pfo.80.1646977893746; Thu, 10
 Mar 2022 21:51:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:28 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-18-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 017/105] KVM: selftests: Make x86-64's register dump
 helpers static
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/kvm_util_internal.h     | 34 ------------------
 .../selftests/kvm/lib/x86_64/processor.c      | 36 ++-----------------
 2 files changed, 2 insertions(+), 68 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index 0c7c44499129..544b90df2f80 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -88,40 +88,6 @@ struct vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid);
  */
 void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
 
-/*
- * Register Dump
- *
- * Input Args:
- *   stream - Output FILE stream
- *   regs   - Registers
- *   indent - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the state of the registers given by @regs, to the FILE stream
- * given by @stream.
- */
-void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent);
-
-/*
- * System Register Dump
- *
- * Input Args:
- *   stream - Output FILE stream
- *   sregs  - System registers
- *   indent - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the state of the system registers given by @sregs, to the FILE stream
- * given by @stream.
- */
-void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent);
-
 struct userspace_mem_region *
 memslot2region(struct kvm_vm *vm, uint32_t memslot);
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 64dd2acb2ab7..c47b84449a8a 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -51,8 +51,7 @@ struct pageTableEntry {
 	uint64_t execute_disable:1;
 };
 
-void regs_dump(FILE *stream, struct kvm_regs *regs,
-	       uint8_t indent)
+static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
 {
 	fprintf(stream, "%*srax: 0x%.16llx rbx: 0x%.16llx "
 		"rcx: 0x%.16llx rdx: 0x%.16llx\n",
@@ -75,21 +74,6 @@ void regs_dump(FILE *stream, struct kvm_regs *regs,
 		regs->rip, regs->rflags);
 }
 
-/*
- * Segment Dump
- *
- * Input Args:
- *   stream  - Output FILE stream
- *   segment - KVM segment
- *   indent  - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the state of the KVM segment given by @segment, to the FILE stream
- * given by @stream.
- */
 static void segment_dump(FILE *stream, struct kvm_segment *segment,
 			 uint8_t indent)
 {
@@ -107,21 +91,6 @@ static void segment_dump(FILE *stream, struct kvm_segment *segment,
 		segment->unusable, segment->padding);
 }
 
-/*
- * dtable Dump
- *
- * Input Args:
- *   stream - Output FILE stream
- *   dtable - KVM dtable
- *   indent - Left margin indent amount
- *
- * Output Args: None
- *
- * Return: None
- *
- * Dumps the state of the KVM dtable given by @dtable, to the FILE stream
- * given by @stream.
- */
 static void dtable_dump(FILE *stream, struct kvm_dtable *dtable,
 			uint8_t indent)
 {
@@ -131,8 +100,7 @@ static void dtable_dump(FILE *stream, struct kvm_dtable *dtable,
 		dtable->padding[0], dtable->padding[1], dtable->padding[2]);
 }
 
-void sregs_dump(FILE *stream, struct kvm_sregs *sregs,
-		uint8_t indent)
+static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent)
 {
 	unsigned int i;
 
-- 
2.35.1.723.g4982287a31-goog


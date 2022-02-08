Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E062BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 09:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355407AbiBHJeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 04:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355385AbiBHJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:34:15 -0500
Received: from out0-148.mail.aliyun.com (out0-148.mail.aliyun.com [140.205.0.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C1C03FEC1;
        Tue,  8 Feb 2022 01:34:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.Mn.uQL0_1644312849;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.Mn.uQL0_1644312849)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Feb 2022 17:34:09 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] KVM: x86/emulator: Move the unhandled outer privilege level logic of far return into __load_segment_descriptor()
Date:   Tue, 08 Feb 2022 17:34:05 +0800
Message-Id: <5b7188e6388ac9f4567d14eab32db9adf3e00119.1644292363.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644292363.git.houwenlong.hwl@antgroup.com>
References: <cover.1644292363.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Outer-privilege level return is not implemented in emulator,
move the unhandled logic into __load_segment_descriptor to
make it easier to understand why the checks for RET are
incomplete.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/kvm/emulate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 37c4213bdcc1..bd91b952eb0a 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1631,9 +1631,14 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 		if (!(seg_desc.type & 8))
 			goto exception;
 
-		/* RET can never return to an inner privilege level. */
-		if (transfer == X86_TRANSFER_RET && rpl < cpl)
-			goto exception;
+		if (transfer == X86_TRANSFER_RET) {
+			/* RET can never return to an inner privilege level. */
+			if (rpl < cpl)
+				goto exception;
+			/* Outer-privilege level return is not implemented */
+			if (rpl > cpl)
+				return X86EMUL_UNHANDLEABLE;
+		}
 		if (transfer == X86_TRANSFER_RET || transfer == X86_TRANSFER_TASK_SWITCH) {
 			if (seg_desc.type & 4) {
 				/* conforming */
@@ -2228,9 +2233,6 @@ static int em_ret_far(struct x86_emulate_ctxt *ctxt)
 	rc = emulate_pop(ctxt, &cs, ctxt->op_bytes);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
-	/* Outer-privilege level return is not implemented */
-	if (ctxt->mode >= X86EMUL_MODE_PROT16 && (cs & 3) > cpl)
-		return X86EMUL_UNHANDLEABLE;
 	rc = __load_segment_descriptor(ctxt, (u16)cs, VCPU_SREG_CS, cpl,
 				       X86_TRANSFER_RET,
 				       &new_desc);
-- 
2.31.1


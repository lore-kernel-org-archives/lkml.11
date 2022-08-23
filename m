Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA392C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349684AbiHWJYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348714AbiHWJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:20:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D970E89833;
        Tue, 23 Aug 2022 01:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F243ACE1B45;
        Tue, 23 Aug 2022 08:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106CCC433D6;
        Tue, 23 Aug 2022 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661243579;
        bh=c0oQWHbTvcNHrAYGEU4I81+4AJyeLsiRKKSH4gPd8po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pwm3beKzPBY91yiuM+A7gpuA1AGAUvvaroLTG3NOgYo4m7DI7ZKTltBBHtdsMg07R
         BoHe99JnKnnbzy5QZiU/PB96H+ZRbXiOEt0SXDkIr4tQKwNcazzC1vqMIdG6X7Pv/z
         zQgMUOvWfWvpfPk3W7FX7ooOVYorQLdgJAfd9IzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 321/365] KVM: PPC: Book3S HV: Fix "rm_exit" entry in debugfs timings
Date:   Tue, 23 Aug 2022 10:03:42 +0200
Message-Id: <20220823080131.606216655@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabiano Rosas <farosas@linux.ibm.com>

[ Upstream commit 9981bace85d816ed8724ac46e49285e8488d29e6 ]

At debugfs/kvm/<pid>/vcpu0/timings we show how long each part of the
code takes to run:

$ cat /sys/kernel/debug/kvm/*-*/vcpu0/timings
rm_entry: 123785 49398892 118 4898
rm_intr: 123780 6075890 22 390
rm_exit: 0 0 0 0                     <-- NOK
guest: 123780 46732919988 402 9997638
cede: 0 0 0 0                        <-- OK, no cede napping in P9

The "rm_exit" is always showing zero because it is the last one and
end_timing does not increment the counter of the previous entry.

We can fix it by calling accumulate_time again instead of
end_timing. That way the counter gets incremented. The rest of the
arithmetic can be ignored because there are no timing points after
this and the accumulators are reset before the next round.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20220525130554.2614394-2-farosas@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
index 112a09b33328..7f88be386b27 100644
--- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
+++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
@@ -438,15 +438,6 @@ void restore_p9_host_os_sprs(struct kvm_vcpu *vcpu,
 EXPORT_SYMBOL_GPL(restore_p9_host_os_sprs);
 
 #ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
-static void __start_timing(struct kvm_vcpu *vcpu, struct kvmhv_tb_accumulator *next)
-{
-	struct kvmppc_vcore *vc = vcpu->arch.vcore;
-	u64 tb = mftb() - vc->tb_offset_applied;
-
-	vcpu->arch.cur_activity = next;
-	vcpu->arch.cur_tb_start = tb;
-}
-
 static void __accumulate_time(struct kvm_vcpu *vcpu, struct kvmhv_tb_accumulator *next)
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
@@ -478,8 +469,8 @@ static void __accumulate_time(struct kvm_vcpu *vcpu, struct kvmhv_tb_accumulator
 	curr->seqcount = seq + 2;
 }
 
-#define start_timing(vcpu, next) __start_timing(vcpu, next)
-#define end_timing(vcpu) __start_timing(vcpu, NULL)
+#define start_timing(vcpu, next) __accumulate_time(vcpu, next)
+#define end_timing(vcpu) __accumulate_time(vcpu, NULL)
 #define accumulate_time(vcpu, next) __accumulate_time(vcpu, next)
 #else
 #define start_timing(vcpu, next) do {} while (0)
-- 
2.35.1




Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5267DC25B0F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Aug 2022 15:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbiHNPrX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Aug 2022 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbiHNPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 11:44:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F3248E1;
        Sun, 14 Aug 2022 08:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35239B80B79;
        Sun, 14 Aug 2022 15:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E452EC433C1;
        Sun, 14 Aug 2022 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660491244;
        bh=lY8Vu6e1a86oTT8LLYHfgkFVDDyf4+IO166QYIoKdS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reeUw7Su+x7OFAsbsfPGVuofObE0hWaoGYvoO9TMYmxOLzazFNOrzrx97MNNKBJnT
         w3zYciuAZ62nvHhg6adb95y3+iYQqnpBgdhqqzO9AOsHoi20Dn3Q56ya1XuoCZLYFC
         zEJWzjcpCO8pnJSdDkVIFY+YrLjT2Tw/foYKDyZnF4f7WIdRBrI2bsBRIA6+WbDKLM
         EOH52PuNLMKJwc7dMAMu2tvi0jhKfil6XWtFPRI+Grea+7BMLvNKJB8/uu6fOQBs36
         B/CWijjrSKSvPr48pFms1XtrEKxIjZtRM6Jja1h3BdgFb9S7UCv/wvwJg75dnZHXBU
         Pj1K0n+cs1p7A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liao Chang <liaochang1@huawei.com>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Guo Ren <guoren@kernel.org>, Sasha Levin <sashal@kernel.org>,
        rostedt@goodmis.org, lkp@intel.com, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 35/46] csky/kprobe: reclaim insn_slot on kprobe unregistration
Date:   Sun, 14 Aug 2022 11:32:36 -0400
Message-Id: <20220814153247.2378312-35-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814153247.2378312-1-sashal@kernel.org>
References: <20220814153247.2378312-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

[ Upstream commit a2310c74d418deca0f1d749c45f1f43162510f51 ]

On kprobe registration kernel allocate one insn_slot for new kprobe,
but it forget to reclaim the insn_slot on unregistration, leading to a
potential leakage.

Reported-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/probes/kprobes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index 4045894d9280..584ed9f36290 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -124,6 +124,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
+	if (p->ainsn.api.insn) {
+		free_insn_slot(p->ainsn.api.insn, 0);
+		p->ainsn.api.insn = NULL;
+	}
 }
 
 static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
-- 
2.35.1


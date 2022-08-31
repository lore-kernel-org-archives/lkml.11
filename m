Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D247CECAAD3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 18:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiHaSJx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiHaSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6807E8692;
        Wed, 31 Aug 2022 11:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CABB161C1D;
        Wed, 31 Aug 2022 18:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6625C4315A;
        Wed, 31 Aug 2022 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969329;
        bh=xbjqcsHpZLXZwlNWH/Cbgm5wue/oCBT8GsMoqoWOFtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+7gVi8yFm3V3RD6T/WGbR/vDUeIq5UBo0A6wNESq7DWzBVB49wILZoyuSgVzOCC2
         rnTa20DoLo7rRkJf7myG6HugA48VHkmLvis6NZ1Du7QSESk/umgnpvf2vXrs7hpfcP
         XziZDBydnKYKqmsb4lkoXqCo2YzHqfT3Vg0KKLdvBdR5n7ok1oBC20OV/2Jy0Nx5Xf
         GwT4E8whMUzEmE0dNxJVmU4FC5YW2MbREEBOpLoURCWb9WNrb4TYuXnisoNDUiVuJk
         gFIP+/fH7hTgzzjajJqKIIqqNdpoYbqnV6RrydBHArpNf5A7DA3vEeTsrx1Cfv5TuP
         g0duUCmddN/GQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: [PATCH v2 5/5] riscv: Allow to enable RT
Date:   Thu,  1 Sep 2022 01:59:20 +0800
Message-Id: <20220831175920.2806-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220831175920.2806-1-jszhang@kernel.org>
References: <20220831175920.2806-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to select RT.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9f2f1936b1b5..69cdcb3cf251 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
-- 
2.34.1


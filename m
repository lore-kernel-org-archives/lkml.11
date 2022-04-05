Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6917C3527D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiDEH6C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiDEHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132F596810;
        Tue,  5 Apr 2022 00:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7354616C1;
        Tue,  5 Apr 2022 07:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BDDC340EE;
        Tue,  5 Apr 2022 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649144568;
        bh=qSyWIa0LwaDLc/TyczrTv77qy/lz9Ul+0t4Qk+PHhjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tUAWsHvjTEwAIwg+Sjj6yKnOfuDiUIrYtiJuEwDQ46xlwiahwr2F4pY1P2cYQPI3L
         Nee8BVj0VaYxErpi69hshYLWU5lGMf4DPwj0eqPDgr5ZXh2djOVr5GpdYDOHreMIdd
         6G28bYipSq2SRqNIxZOzwmcJYCu1neGr+r73pkRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 5.17 0090/1126] RISC-V: Declare per cpu boot data as static
Date:   Tue,  5 Apr 2022 09:13:57 +0200
Message-Id: <20220405070410.210211813@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atishp@rivosinc.com>

commit f1de125766d6f377a4b5d5821bc12928f929a4eb upstream.

The per cpu boot data is only used within the cpu_ops_sbi.c. It can
be delcared as static.

Fixes: 9a2451f18663 ("RISC-V: Avoid using per cpu array for ordered booting")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/cpu_ops_sbi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -21,7 +21,7 @@ const struct cpu_operations cpu_ops_sbi;
  * be invoked from multiple threads in parallel. Define a per cpu data
  * to handle that.
  */
-DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
+static DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
 
 static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
 			      unsigned long priv)



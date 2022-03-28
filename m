Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AB4C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 22:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiC1WOV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiC1WOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:14:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E30629E4C4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GPW5RwZdDm3KH7zWeWgiALLUJU6InmlVaBP2w+GyecY=; b=ToFJz5e20udbw2odMn9o0WQ1z/
        FnyWbO0upMPSBALg5JAe0cYVGSAmJQ2K6KmKg+NeAVhHYQ2K0DgJPvPgz9l14BXF8CcD1ZSRnQH/9
        4NclVfRmQrjxGXgREET1cgyzU7uvrQzI3mMDU95nC0vMNPtEB/iHjJ3ACYodzFBM6zdHdwQ9g0u3A
        UWEf+NPq9jb0acO9bF3OUkd46CiN3N4BRveZ6MCZW/BRtBeu6og1u2TFDbCkocaii5oCZ8MeD19rU
        6693M1WgI6/owqOl2zaB+i/vuIRvLgYWLSAB+dLDYKEnwPg76GTlI8GtLKhcYA3zAEoQZZwsRqild
        oxnKwuzw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYxTG-00AJIB-PG; Mon, 28 Mar 2022 22:04:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: cpu.c: don't use kernel-doc markers for comments
Date:   Mon, 28 Mar 2022 15:04:17 -0700
Message-Id: <20220328220417.25675-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repair kernel-doc build warnings caused by using "/**" kernel-doc
markers for comments that are not in kernel-doc format:

cpu.c:89: warning: cannot understand function prototype: 'struct riscv_isa_ext_data isa_ext_arr[] = '
cpu.c:114: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Atish Patra <atishp@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/kernel/cpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20220328.orig/arch/riscv/kernel/cpu.c
+++ linux-next-20220328/arch/riscv/kernel/cpu.c
@@ -69,7 +69,7 @@ int riscv_of_parent_hartid(struct device
 		.uprop = #UPROP,				\
 		.isa_ext_id = EXTID,				\
 	}
-/**
+/*
  * Here are the ordering rules of extension naming defined by RISC-V
  * specification :
  * 1. All extensions should be separated from other multi-letter extensions
@@ -110,7 +110,7 @@ static void print_isa_ext(struct seq_fil
 	}
 }
 
-/**
+/*
  * These are the only valid base (single letter) ISA extensions as per the spec.
  * It also specifies the canonical order in which it appears in the spec.
  * Some of the extension may just be a place holder for now (B, K, P, J).

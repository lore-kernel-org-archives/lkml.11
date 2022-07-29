Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBF1C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 02:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiG2CHg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 22:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG2CHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:07:34 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B132DA6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659060451;
        bh=IPitxC8+QzlmhXhZVxo4SRdkLRxdiyRH0+ciRt/55KM=;
        h=Subject:From:To:Cc:Date:From;
        b=PO4prvHcTKErkGL7qV7uR2xAK4aC3Z8IA+D5YOH+vf5ZfIlCwq1PEvNMpHKU5bygA
         ss0k+jGn8Mi2oYNeqJexf+LuJj+TSulijkmIIcdnisdM+Q06Zk3GP9aRw+iY120hOy
         2cJkyLA42vG1t8Ih+c02XQXPtHatCgWjrPfZpYoc=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 9998D65929;
        Thu, 28 Jul 2022 22:07:29 -0400 (EDT)
Message-ID: <bb7824d39a694b13069718c2b8193379f79229b4.camel@xry111.site>
Subject: [PATCH v3 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Fri, 29 Jul 2022 10:07:27 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The version 2.00 of LoongArch ELF ABI specification introduced new
relocation types, and the development tree of Binutils and GCC has
started to use them.  If the kernel is built with the latest snapshot of
Binutils or GCC, it will fail to load the modules because of unrecognized
relocation types in modules.

Add support for GOT and new relocation types for the module loader, so
the kernel (with modules) can be built with the "normal" code model and
function properly.

This series does not break the compatibility with old toolchain using
stack-based relocation types, so with the patches applied the kernel can
be be built with both old and new toolchains.

Tested by building the kernel with both Binutils & GCC master branch and
my system Binutils & GCC (without new relocation type support), running
both the builds with 35 in-tree modules loaded, and loading one module
with 20 GOT loads (loaded addresses verified by comparing with
/proc/kallsyms).

Changes from v2 to v3:

- Use `union loongarch_instruction` instead of explicit bit shifts
  applying the relocation.  Suggested by Youling.
- For R_LARCH_B26, move the alignment check before the range check to be
  consistent with stack pop relocations.  Suggested by Youling.
- Reword the commit message of the 3rd patch.  Suggested by Huacai.

Xi Ruoyao (4):
  LoongArch: Add section of GOT for kernel module
  LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation type in kernel
    module
  LoongArch: Remove -fplt and -Wa,-mla-* from CFLAGS
  LoongArch: Support modules with new relocation types

 arch/loongarch/Makefile                 |  4 --
 arch/loongarch/include/asm/elf.h        | 37 ++++++++++
 arch/loongarch/include/asm/module.h     | 23 ++++++
 arch/loongarch/include/asm/module.lds.h |  1 +
 arch/loongarch/kernel/head.S            | 10 +--
 arch/loongarch/kernel/module-sections.c | 51 +++++++++++--
 arch/loongarch/kernel/module.c          | 96 +++++++++++++++++++++++++
 7 files changed, 209 insertions(+), 13 deletions(-)

--=20
2.37.0



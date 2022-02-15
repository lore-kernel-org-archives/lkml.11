Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE6CC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiBOFbL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:31:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiBOFa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF1A1285A1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV696Fvjz4y4F;
        Tue, 15 Feb 2022 16:30:09 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <83c97bd58a3596ef1b0ff28b1e41fd492d005520.1643616989.git.christophe.leroy@csgroup.eu>
References: <83c97bd58a3596ef1b0ff28b1e41fd492d005520.1643616989.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/nohash: Remove pte_same()
Message-Id: <164490280514.270256.13075668635877697100.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 08:16:48 +0000, Christophe Leroy wrote:
> arch/powerpc/include/asm/nohash/{32/64}/pgtable.h has
> 
> 	#define __HAVE_ARCH_PTE_SAME
> 	#define pte_same(A,B)      ((pte_val(A) ^ pte_val(B)) == 0)
> 
> include/linux/pgtable.h has
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/nohash: Remove pte_same()
      https://git.kernel.org/powerpc/c/535bda36dbf2d271f59e06fe252c32eff452666d

cheers

Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4443CC433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 10:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiCLKcK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 05:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiCLKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:31:59 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD33323D18B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:30:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbZ3swXz4xPt;
        Sat, 12 Mar 2022 21:30:50 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <adc9c9d6378f6b5008246ca717993d7870188efb.1644569473.git.christophe.leroy@csgroup.eu>
References: <adc9c9d6378f6b5008246ca717993d7870188efb.1644569473.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/bitops: Force inlining of fls()
Message-Id: <164708098783.827774.9289683232577719958.b4-ty@ellerman.id.au>
Date:   Sat, 12 Mar 2022 21:29:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 09:51:32 +0100, Christophe Leroy wrote:
> Building a kernel with CONFIG_CC_OPTIMISE_FOR_SIZE leads to
> the following functions being copied several times in vmlinux:
> 
> 	31 times __ilog2_u32()
> 	34 times fls()
> 
> Disassembly follows:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/bitops: Force inlining of fls()
      https://git.kernel.org/powerpc/c/0b0057cc4193c7cd9c0829a440e4901b29ce4ff8

cheers

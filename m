Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F698C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 10:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiEOKbU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 06:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiEOKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:31:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC221766B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:31:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZJ3y9dz4xZ0;
        Sun, 15 May 2022 20:31:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <6bb118fb2ee89fa3c1f9cf90ed19f88220002cb0.1647877467.git.christophe.leroy@csgroup.eu>
References: <6bb118fb2ee89fa3c1f9cf90ed19f88220002cb0.1647877467.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: align address to page boundary in change_page_attr()
Message-Id: <165261053145.1047019.10970993413033058326.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:28:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 16:44:45 +0100, Christophe Leroy wrote:
> Aligning address to page boundary allows flush_tlb_kernel_range()
> to know it's a single page flush and use tlbie instead of tlbia.
> 
> On 603 we now have the following code in first leg of
> change_page_attr():
> 
> 	  2c:	55 29 00 3c 	rlwinm  r9,r9,0,0,30
> 	  30:	91 23 00 00 	stw     r9,0(r3)
> 	  34:	7c 00 22 64 	tlbie   r4,r0
> 	  38:	7c 00 04 ac 	hwsync
> 	  3c:	38 60 00 00 	li      r3,0
> 	  40:	4e 80 00 20 	blr
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: align address to page boundary in change_page_attr()
      https://git.kernel.org/powerpc/c/65883b78bc9f49ac891bb202c59fcb76b9cfc611

cheers

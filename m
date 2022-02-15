Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BF6C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiBOFbA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:31:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiBOFa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8665D128663
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6B3FFPz4y4G;
        Tue, 15 Feb 2022 16:30:10 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <bbc196451dd34521d239023ccca488db35b8fff1.1643567900.git.christophe.leroy@csgroup.eu>
References: <bbc196451dd34521d239023ccca488db35b8fff1.1643567900.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/ptdump: Fix sparse warning in hashpagetable.c
Message-Id: <164490279413.270256.17140116336898117103.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:34 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 18:39:18 +0000, Christophe Leroy wrote:
>   arch/powerpc/mm/ptdump/hashpagetable.c:264:29: warning: restricted __be64 degrades to integer
>   arch/powerpc/mm/ptdump/hashpagetable.c:265:49: warning: restricted __be64 degrades to integer
>   arch/powerpc/mm/ptdump/hashpagetable.c:267:36: warning: incorrect type in assignment (different base types)
>   arch/powerpc/mm/ptdump/hashpagetable.c:267:36:    expected unsigned long long [usertype]
>   arch/powerpc/mm/ptdump/hashpagetable.c:267:36:    got restricted __be64 [usertype] v
>   arch/powerpc/mm/ptdump/hashpagetable.c:268:36: warning: incorrect type in assignment (different base types)
>   arch/powerpc/mm/ptdump/hashpagetable.c:268:36:    expected unsigned long long [usertype]
>   arch/powerpc/mm/ptdump/hashpagetable.c:268:36:    got restricted __be64 [usertype] r
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ptdump: Fix sparse warning in hashpagetable.c
      https://git.kernel.org/powerpc/c/961f649fb3ad9a9e384c695a050d776d970ddabd

cheers

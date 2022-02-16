Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3E7C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 12:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiBPMad (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:30:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiBPMa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:30:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F872A414A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:30:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHNN6HHwz4xmx;
        Wed, 16 Feb 2022 23:30:12 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <7304a889dbe885aefad8a8333673c81ee4b8f7a6.1642751874.git.christophe.leroy@csgroup.eu>
References: <7304a889dbe885aefad8a8333673c81ee4b8f7a6.1642751874.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Use the newly added is_tsk_32bit_task() macro
Message-Id: <164501434972.521186.548176126612170796.b4-ty@ellerman.id.au>
Date:   Wed, 16 Feb 2022 23:25:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 07:58:47 +0000, Christophe Leroy wrote:
> Two places deserve using the macro is_tsk_32bit_task() added by
> commit 252745240ba0 ("powerpc/audit: Fix syscall_get_arch()")
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Use the newly added is_tsk_32bit_task() macro
      https://git.kernel.org/powerpc/c/9d44d1bd93b9a881f407b3202dc13fbd85fb5f1a

cheers

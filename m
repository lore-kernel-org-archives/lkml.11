Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAEAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 12:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbiCBMrc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbiCBMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:47:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B85D8AE4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:46:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v4z1XYWz4xvG;
        Wed,  2 Mar 2022 23:46:43 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1d862ce3eab3da6ca7ac47d4a78a18f154462511.1645806970.git.christophe.leroy@csgroup.eu>
References: <1d862ce3eab3da6ca7ac47d4a78a18f154462511.1645806970.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc/interrupt: Remove struct interrupt_state
Message-Id: <164622490826.2052779.1956163553651248861.b4-ty@ellerman.id.au>
Date:   Wed, 02 Mar 2022 23:41:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 17:36:22 +0100, Christophe Leroy wrote:
> Since commit ceff77efa4f8 ("powerpc/64e/interrupt: Use new interrupt
> context tracking scheme") struct interrupt_state has been empty and
> unused.
> 
> Remove it.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/interrupt: Remove struct interrupt_state
      https://git.kernel.org/powerpc/c/973e2e6462405d85d3e8bb02d516d5fe6d1193ed

cheers

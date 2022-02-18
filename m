Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E3C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 02:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiBRCYw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 21:24:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiBRCYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:24:47 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225406582E;
        Thu, 17 Feb 2022 18:24:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K0FrY646xz4xbw;
        Fri, 18 Feb 2022 13:24:29 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Maxime Bizon <mbizon@freebox.fr>, stable@vger.kernel.org
In-Reply-To: <aea33b4813a26bdb9378b5f273f00bd5d4abe240.1638857364.git.christophe.leroy@csgroup.eu>
References: <aea33b4813a26bdb9378b5f273f00bd5d4abe240.1638857364.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/603: Fix boot failure with DEBUG_PAGEALLOC and KFENCE
Message-Id: <164515103939.912400.9280138789823591343.b4-ty@ellerman.id.au>
Date:   Fri, 18 Feb 2022 13:23:59 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 06:10:05 +0000, Christophe Leroy wrote:
> Allthough kernel text is always mapped with BATs, we still have
> inittext mapped with pages, so TLB miss handling is required
> when CONFIG_DEBUG_PAGEALLOC or CONFIG_KFENCE is set.
> 
> The final solution should be to set a BAT that also maps inittext
> but that BAT then needs to be cleared at end of init, and it will
> require more changes to be able to do it properly.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/603: Fix boot failure with DEBUG_PAGEALLOC and KFENCE
      https://git.kernel.org/powerpc/c/9bb162fa26ed76031ed0e7dbc77ccea0bf977758

cheers

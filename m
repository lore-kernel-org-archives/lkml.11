Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48458C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiBOFai (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:30:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiBOFa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BD61285B9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV685GSvz4y45;
        Tue, 15 Feb 2022 16:30:08 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <bbb13848ff0100a76ee9ea95118058c30ae95f2c.1643613343.git.christophe.leroy@csgroup.eu>
References: <bbb13848ff0100a76ee9ea95118058c30ae95f2c.1643613343.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/603: Clear C bit when PTE is read only
Message-Id: <164490280429.270256.7360085115220568003.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 07:17:57 +0000, Christophe Leroy wrote:
> On book3s/32 MMU, PP bits don't offer kernel RO protection,
> kernel pages are always RW.
> 
> However, on the 603 a page fault is always generated when the
> C bit (change bit = dirty bit) is not set.
> 
> Enforce kernel RO protection by clearing C bit in TLB miss
> handler when the page doesn't have _PAGE_RW flag.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/603: Clear C bit when PTE is read only
      https://git.kernel.org/powerpc/c/4634bf4455fe26f07dabf97c3585c9ccb86353c4

cheers

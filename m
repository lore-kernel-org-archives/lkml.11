Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43711C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 10:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiEOKOh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiEOKOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:14:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F33D1F9
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:14:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JC75MJ5z4xYX;
        Sun, 15 May 2022 20:14:27 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     frowand.list@gmail.com, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220424184014.968274-1-frowand.list@gmail.com>
References: <20220424184014.968274-1-frowand.list@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/boot: remove unused function find_node_by_linuxphandle()
Message-Id: <165260953673.1040779.7258073916648499773.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:12:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 13:40:14 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The last user of find_node_by_linuxphandle() was removed in v4.18-rc1
> by commit 30f4bbe0472a ("powerpc/boot: Remove support for Marvell MPSC serial controller")
> four years ago.  This function is no longer needed.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/boot: remove unused function find_node_by_linuxphandle()
      https://git.kernel.org/powerpc/c/2fb70d1d36e2f8482a78bb8aae688ae1416af889

cheers

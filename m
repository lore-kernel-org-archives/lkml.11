Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B87C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 10:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiEOKcq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 06:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiEOKbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:31:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B9DAE4B;
        Sun, 15 May 2022 03:31:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZS1sXJz4xZv;
        Sun, 15 May 2022 20:31:12 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Fabiano Rosas <farosas@linux.ibm.com>, stable@vger.kernel.org
In-Reply-To: <20220504101244.12107-1-ldufour@linux.ibm.com>
References: <20220504101244.12107-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/rtas: Keep MSR[RI] set when calling RTAS
Message-Id: <165261054578.1047019.8022784676618367625.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:29:05 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 12:12:44 +0200, Laurent Dufour wrote:
> RTAS runs in real mode (MSR[DR] and MSR[IR] unset) and in 32bits
> big endian mode (MSR[SF,LE] unset).
> 
> The change in MSR is done in enter_rtas() in a relatively complex way,
> since the MSR value could be hardcoded.
> 
> Furthermore, a panic has been reported when hitting the watchdog interrupt
> while running in RTAS, this leads to the following stack trace:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/rtas: Keep MSR[RI] set when calling RTAS
      https://git.kernel.org/powerpc/c/b6b1c3ce06ca438eb24e0f45bf0e63ecad0369f5

cheers

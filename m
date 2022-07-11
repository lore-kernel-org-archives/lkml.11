Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6802C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 16:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiGKQns (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:43:46 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81E811EC48
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:43:44 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26BGdZSI007170;
        Mon, 11 Jul 2022 11:39:35 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26BGdYRl007169;
        Mon, 11 Jul 2022 11:39:34 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 11 Jul 2022 11:39:34 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] powerpc/32: Do not allow selection of e5500 or e6500 CPUs on PPC32
Message-ID: <20220711163934.GE25951@gate.crashing.org>
References: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Jul 11, 2022 at 04:19:29PM +0200, Christophe Leroy wrote:
> Commit 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
> enlarged the CPU selection logic to PPC32 by removing depend to
> PPC64, and failed to restrict that depend to E5500_CPU and E6500_CPU.
> Fortunately that got unnoticed because -mcpu=8540 will override the
> -mcpu=e500mc64 or -mpcu=e6500 as they are ealier, but that's
> fragile and may no be right in the future.

A later -mcpu= always overrides an earlier one.  This is the same as
with all other GCC option flags, and will not change in the future.


Segher
